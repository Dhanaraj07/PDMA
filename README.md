# PDMA - Profile Discovery Management App

## Project Overview

PDMA (Profile Discovery Management App) is a Flutter-based mobile application that allows users to create, manage, discover, search, filter, and favorite profiles. The application also integrates with the Random User API to provide suggested profiles.

---

## Features

### Authentication

* User Registration
* User Login
* Forgot Password

### Profile Management

* Create Profile
* Edit Profile
* Delete Profile
* Upload Profile Picture
* View Profile Details
* Multiple Profile Support

### Profile Discovery

* Browse Profiles
* Search Profiles
* Filter Profiles by Location
* View Profile Details
* Favorite Profiles

### API Integration

* Random User API
* Suggested Profiles
* API Error Handling
* Loading States

### Favorites

* Add to Favorites
* Remove from Favorites
* View Favorite Profiles

### Settings

* Application Settings Screen

---

## Project Setup Instructions

### Clone Repository

```bash
git clone https://github.com/Dhanaraj07/PDMA.git
```

### Navigate to Project

```bash
cd PDMA
```

### Install Dependencies

```bash
flutter pub get
```

### Run Application

```bash
flutter run
```

---

## Architecture Overview

The application follows a feature-based architecture with Riverpod state management.

### Layers

1. Presentation Layer

   * Screens
   * Widgets

2. State Management Layer

   * Riverpod Providers

3. Data Layer

   * Models
   * API Services

4. Storage Layer

   * SharedPreferences

---

## Project Structure

```text
lib/
│
├── features/
│   ├── auth/
│   ├── profile/
│   ├── discovery/
│   └── settings/
│
├── shared/
│
└── main.dart
```

---

## Libraries Used

| Package              | Purpose               |
| -------------------- | --------------------- |
| flutter_riverpod     | State Management      |
| dio                  | API Requests          |
| shared_preferences   | Local Storage         |
| image_picker         | Profile Image Upload  |
| cached_network_image | Network Image Caching |
| flutter_screenutil   | Responsive UI         |

---

## Assumptions and Decisions

* Riverpod is used for scalable state management.
* SharedPreferences is used for local profile persistence.
* Random User API is used to demonstrate API integration.
* Favorites are stored locally.
* Profile images are selected from the device gallery.

---

## APK Build

```bash
flutter build apk --release
```

Output:

```text
build/app/outputs/flutter-apk/app-release.apk
```

---

## Author

Dhanaraj

PDMA - Profile Discovery Management App
