# PDMA - Profile Discovery Management App

## Overview

PDMA (Profile Discovery Management App) is a Flutter application that allows users to create, manage, discover, search, filter, and favorite profiles. The app also integrates with the Random User API to display suggested profiles.

---

## Features

### Authentication

* User Login
* User Registration
* Forgot Password

### Profile Management

* Create Profile
* Edit Profile
* Delete Profile
* Upload Profile Picture
* View Profile Details
* Local Storage using SharedPreferences

### Profile Discovery

* Browse Profiles
* Search Profiles
* Filter Profiles by Location
* View Profile Details
* Save/Favorite Profiles

### API Integration

* Random User API
* Suggested Profiles
* Loading State Handling
* Error State Handling
* JSON Response Parsing

### Favorites

* Add Profiles to Favorites
* View Favorite Profiles
* Profile Details from Favorites

---

## Technologies Used

* Flutter
* Dart
* Riverpod (State Management)
* SharedPreferences
* Dio (API Calls)
* Image Picker
* Random User API

---

## Project Structure

lib/
├── features/
│ ├── auth/
│ ├── profile/
│ ├── discovery/
│ └── settings/
├── home/
└── main.dart

---

## Packages

* flutter_riverpod
* dio
* shared_preferences
* image_picker
* cached_network_image
* flutter_screenutil

---

## Screens

### Profile

* Create Profile
* Edit Profile
* Profile Details
* Profile List

### Discovery

* Search Profiles
* Filter Profiles
* Suggested Profiles (API)
* Favorites

### Settings

* App Settings Page

---

## Installation

1. Clone the repository

```bash
git clone <repository-url>
```

2. Navigate to project

```bash
cd profile_discovery_app
```

3. Install dependencies

```bash
flutter pub get
```

4. Run application

```bash
flutter run
```

---

## Build APK

```bash
flutter build apk --release
```

APK Location:

```text
build/app/outputs/flutter-apk/app-release.apk
```

---

## Author

Dhanaraj

Flutter Developer Project - PDMA
