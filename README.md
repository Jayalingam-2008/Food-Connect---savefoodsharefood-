# 🍱 Food Connect – Save Food, Share Food

**Food Connect** is a location-based food redistribution platform that connects people and organizations with surplus food to nearby seekers who need it.

The platform aims to reduce food wastage by making it easier to **share surplus food, discover available food, find nearby seekers, and coordinate food collection**.

## 🌱 Problem

Large amounts of usable food can be wasted from restaurants, hotels, colleges, homes, weddings, functions, caterers and other events, while people and organizations may need food.

Food Connect provides a simple digital platform to help connect these two sides.

## 💡 Solution

### Donor

```text
Register / Login
      ↓
Share Surplus Food
      ↓
Add Food + Quantity + Location
      ↓
Set Available Until Time
      ↓
Find Nearby Seekers
      ↓
Contact Through WhatsApp
      ↓
Food Collection
```

### Seeker

```text
Register / Login
      ↓
Add Location
      ↓
Find Available Food
      ↓
Select Food
      ↓
Contact Donor Through WhatsApp
      ↓
Coordinate Collection
```

## ✨ Key Features

* 🔐 User registration and login
* 🔑 Password reset and email authentication
* 🍱 Surplus food listing
* 🙋 Food request system
* 📍 GPS-based location detection
* 📏 Nearby donor/seeker matching
* 🗺️ Location navigation
* 🔎 Available Food discovery
* 👥 Available Seekers discovery
* 💬 WhatsApp-based communication
* ⏰ Time-based food availability
* 📱 Responsive interface
* 🤝 Donor–seeker connection
* 🌱 Community-focused food redistribution

## 📍 Location-Based Matching

Food Connect uses latitude and longitude to identify nearby donors and seekers.

The current matching system supports a **20 km radius** for nearby connections and calculates the approximate distance between users.

## 💬 WhatsApp Integration

Users can contact donors or seekers directly through WhatsApp using pre-filled messages.

WhatsApp is used for communication and coordination. Messages require user interaction and are not silently sent by the website.

## 🛠️ Technology Stack

### Frontend

* HTML5
* CSS3
* JavaScript

### Backend

* Supabase

### Database

* PostgreSQL

### Geographic Matching

* PostGIS

### Authentication

* Supabase Authentication

### Hosting

* Netlify

### Communication

* WhatsApp

## 🏗️ System Architecture

```text
                    FOOD CONNECT
                         │
                  ┌──────┴──────┐
                  │             │
              FRONTEND       SUPABASE
                  │             │
          HTML/CSS/JS      ┌────┴────┐
                           │         │
                        Auth     PostgreSQL
                                     │
                                  PostGIS
                                     │
                            Location Matching
                                     │
                              Donor ↔ Seeker
                                     │
                                  WhatsApp
```

## 🌍 Community Collaboration

Food Connect is designed to support collaboration with:

* NGOs
* Volunteers
* Colleges
* Restaurants
* Hotels
* Caterers
* Event organizers
* Community organizations

A potential collaboration model is:

**FOOD CONNECT × SWOTT**

**Technology + Community Network = Social Impact**

## 📊 Potential Impact

The platform can be extended to track:

* Food donations
* Successful food connections
* People served
* Food rescued
* Participating organizations
* Volunteers involved

## 🚀 Future Scope

* 📱 Android / iOS application
* 🔔 Push notifications
* 🗺️ Advanced map interface
* 📊 Impact dashboard
* 👥 Volunteer management
* 🏢 Organization dashboards
* 📸 Food image uploads
* 🤖 Smart food matching
* 🔗 Integration with more NGOs and institutions

## 🔒 Security

The project uses Supabase authentication and database security mechanisms.

**Important:** API secrets, service-role keys, passwords and private credentials should never be committed to this repository.

## 👨‍💻 Developer

**JAYALINGAM A.**

Electronics and Communication Engineering Student

### Food Connect

**Save Food • Share Food • Serve Communities ❤️**

---

## 📄 Project Status

🚧 Active Development

Food Connect is being developed as a technology-driven initiative to explore how digital platforms can help connect surplus food with community needs.
