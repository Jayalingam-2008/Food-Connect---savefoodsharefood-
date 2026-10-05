-- Food Connect v26 matching patch
-- Removes verification as a matching requirement.
-- Keeps existing status filters and the 20 km PostGIS distance logic.

CREATE OR REPLACE FUNCTION public.get_nearby_network(
    p_lat double precision,
    p_lng double precision,
    p_mode text,
    p_radius_km numeric DEFAULT 20
)
RETURNS TABLE (
    id uuid,
    name text,
    food_type text,
    category text,
    quantity numeric,
    unit text,
    people_to_serve integer,
    pickup_address text,
    lat double precision,
    lng double precision,
    distance_km numeric,
    verified boolean,
    status text
)
LANGUAGE sql
SECURITY DEFINER
SET search_path = ''
STABLE
AS $$
    WITH center AS (
        SELECT
            extensions.ST_SetSRID(
                extensions.ST_MakePoint(p_lng, p_lat),
                4326
            )::extensions.geography AS location
    )

    SELECT
        r.id,
        o.name,
        r.food_required AS food_type,
        r.preferred_category AS category,
        NULL::numeric AS quantity,
        NULL::text AS unit,
        r.people_to_serve,
        r.pickup_address,
        extensions.ST_Y(r.location::extensions.geometry) AS lat,
        extensions.ST_X(r.location::extensions.geometry) AS lng,
        ROUND(
            (
                extensions.ST_Distance(c.location, r.location) / 1000.0
            )::numeric,
            2
        ) AS distance_km,
        o.verified,
        r.status
    FROM public.food_requests r
    JOIN public.organizations o
        ON o.id = r.organization_id
    CROSS JOIN center c
    WHERE p_mode = 'donate'
      AND r.location IS NOT NULL
      AND r.status IN ('pending', 'verified', 'matching')
      AND extensions.ST_DWithin(
          c.location,
          r.location,
          p_radius_km * 1000
      )

    UNION ALL

    SELECT
        d.id,
        d.donor_name AS name,
        d.food_type,
        d.category,
        d.quantity,
        d.unit,
        NULL::integer AS people_to_serve,
        d.pickup_address,
        extensions.ST_Y(d.location::extensions.geometry) AS lat,
        extensions.ST_X(d.location::extensions.geometry) AS lng,
        ROUND(
            (
                extensions.ST_Distance(c.location, d.location) / 1000.0
            )::numeric,
            2
        ) AS distance_km,
        true AS verified,
        d.status
    FROM public.donations d
    CROSS JOIN center c
    WHERE p_mode = 'seek'
      AND d.location IS NOT NULL
      AND d.status = 'pending'
      AND (
          d.available_until IS NULL
          OR d.available_until >= now()
      )
      AND extensions.ST_DWithin(
          c.location,
          d.location,
          p_radius_km * 1000
      )

    ORDER BY distance_km ASC;
$$;

REVOKE EXECUTE
ON FUNCTION public.get_nearby_network(
    double precision,
    double precision,
    text,
    numeric
)
FROM PUBLIC, anon;

GRANT EXECUTE
ON FUNCTION public.get_nearby_network(
    double precision,
    double precision,
    text,
    numeric
)
TO authenticated;

CREATE OR REPLACE FUNCTION public.create_nearby_matches(
    donation_uuid uuid
)
RETURNS TABLE (
    match_id uuid,
    request_id uuid,
    organization_id uuid,
    distance_km numeric,
    status text
)
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public, extensions
AS $$
BEGIN
    RETURN QUERY

    INSERT INTO public.matches (
        donation_id,
        request_id,
        distance_km,
        status
    )
    SELECT
        d.id,
        r.id,
        r.organization_id,
        ROUND(
            (
                extensions.ST_Distance(d.location, r.location) / 1000.0
            )::numeric,
            2
        ),
        'pending'
    FROM public.donations d
    JOIN public.food_requests r
      ON r.status IN ('pending', 'verified', 'matching')
    JOIN public.organizations o
      ON o.id = r.organization_id
    WHERE d.id = donation_uuid
      AND d.location IS NOT NULL
      AND r.location IS NOT NULL
      AND extensions.ST_DWithin(
          d.location,
          r.location,
          d.matching_radius_km * 1000
      )
    ON CONFLICT (donation_id, request_id)
    DO UPDATE SET
        distance_km = EXCLUDED.distance_km
    RETURNING
        id,
        request_id,
        organization_id,
        distance_km,
        status;
END;
$$;

GRANT EXECUTE
ON FUNCTION public.create_nearby_matches(uuid)
TO authenticated;
