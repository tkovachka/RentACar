# RentACar 🚗

**A modern car rental mobile application built using Flutter with robust Firebase integration and API-powered data sourcing.**

## 🔧 Project Overview

RentACar is an android mobile application (with options for cross-platform development) that allows users to browse, reserve, and manage car rentals efficiently. The app features secure authentication, real-time data handling, image caching, and intuitive calendar-based booking functionality.

---

## 📂 Architecture

The app follows a **clean architecture** approach, separating concerns into the following layers:

- **Widgets Layer**: Custom UI components, common utilities and shared components
- **Screens Layer**: Screen logic
- **Service Layer**: Business logic, Firebase Firestore access, caching mechanisms
- **Models Layer**: Models for handling the cars and bookings data

---

## 🔌 Firebase Integration

The app uses Firebase extensively for backend services:

- **Authentication**: Email/password sign-up and login, with:
  - Email verification
  - Password reset
- **Firestore**: Stores user data, car details, bookings per user
- **Firebase Storage**: Hosts user profile images
- **Cloud Functions**: Implemented for getting/updating the car data from the APIs (see below). Optionally can be extended for sending confirmation notifications/emails to users.

> 🔐 Future possible extensions include **Google** and **Facebook sign-in**.

---

## 🔗 APIs Used

- **Car Data API**: Fetched from a third-party API to populate car details.  
  [Car API Source](https://carapi.app/)
  
- **Unsplash API**: Used to fetch high-quality car images for better UI/UX.  
  [Unsplash Developers](https://unsplash.com/developers)

Fetched API data is persisted in Firestore for offline access and real-time syncing.

---

## 📅 Calendar & Booking

Users can:

- Browse available cars
- View and select **available rental dates** via an interactive calendar  
  → Implemented using the [`table_calendar`](https://pub.dev/packages/table_calendar) package
- Book cars only on **non-conflicting available dates**
- Cancel existing bookings
- Choose from multiple **payment methods** (cash, credit card *card payment not implemented)

---

## 👤 User Profile Features

- Users can **update their profile picture**, which is uploaded to Firebase Storage
- Users can **remove their profile picture**, which automatically deletes it from Firebase Storage
- Users can verify their email address
- Users can change their password (only after email address verification)

---

## 📍 Upcoming Features

- **Location-based pickup/drop-off** selection via Google Maps integration
- **Push notifications** for booking confirmations, cancellations, and promotions
- **Advanced filtering** based on car type, price range, location

---

## 🧠 State Management & Caching

- Managed using `Provider` + `ChangeNotifier`
- **Image Caching**: Uses `cached_network_image` for efficient image loading and caching
- **Data Caching**: Key user and booking data stored in Shared Preferences and in-memory stores to minimize redundant API calls

---

## 📌 Getting Started

1. Clone the repository:
   ```powershell
   git clone https://github.com/tkovachka/RentACar.git
   cd RentACar
2. Install dependencies:
   ```powershell
   flutter pub get
3. Set up Firebase for your project: [Read more](https://firebase.google.com/docs/flutter/setup?platform=android)
4. Run the app:
   ```powershell
   flutter run
6. View the app on a connected device or emulator, read more:
- [Android device developer mode](https://developer.android.com/studio/debug/dev-options)
- [Android Studio emulator set up](https://developer.android.com/studio/run/emulator)
