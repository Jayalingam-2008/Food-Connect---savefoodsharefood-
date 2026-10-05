# Food Connect v26

This is the cleaned, single-file v26 build based on the deployed v24 HTML supplied by the project owner.

## What v26 fixes

- Correct Supabase project URL and publishable key.
- One clean authentication implementation: create account, email confirmation, sign in, resend confirmation, forgot password, password recovery and show/hide password.
- No verification requirement in the user flow or matching logic.
- Donor flow: donor details → food details → photos/safety → exact pickup location.
- Seeker flow: organization details → food need/location → WhatsApp consent/authorization.
- Browser GPS + Leaflet map pin + area/locality, district and city fill.
- Nearby matching through the `get_nearby_network` RPC within 20 km.
- Nearby match creation after a donor submits through `create_nearby_matches`.
- Nearby preview shows up to five fallback results when nothing is inside 20 km.
- WhatsApp buttons prepare a message and open `wa.me`; WhatsApp is never sent automatically.
- Food photos upload to the `food-photos` Supabase Storage bucket.
- Live database stats and live pending donation listings; no hard-coded demo counts/listings.
- Mobile-responsive landing page, navigation drawer and food-themed Share/Request cards.

## Supabase setup

The browser uses the Supabase **publishable** key only. Do not put a service-role/secret key in this file.

After the main Food Connect database setup is already complete, run `supabase_v26_matching_patch.sql` in the Supabase SQL Editor. This updates the two matching functions used by v26 so they do not require organization verification.

## Authentication redirect URL

In Supabase Dashboard → Authentication → URL Configuration, add the exact Netlify site URL, for example:

`https://YOUR-SITE.netlify.app/`

The same site URL is used by confirmation and password-reset links.

## Gmail SMTP

Keep the working SMTP settings already configured in Supabase. The website itself does not contain the Gmail password or App Password.

## Local testing

Do not open `index.html` directly with `file://` when testing authentication.

From this folder run:

```bash
python -m http.server 5500
```

Then open `http://localhost:5500/`.

For Netlify, upload the contents of this folder or connect the folder/repository as the Netlify publish directory.
