# QuickQuest - Flutter Questionnaire App

A beautiful, modern Flutter questionnaire application with authentication, offline storage, and location tracking. Built with GetX state management and Firebase authentication.

## 📱 Features

### ✨ Authentication
- **Register** - Create account with phone and password
- **Login** - Secure authentication with validation
- **Logout** - Confirmation dialog with session management
- **Session Persistence** - Auto-login for returning users

### 🏠 Home Screen
- Beautiful gradient UI with animations
- List of available questionnaires
- Colorful gradient cards with smooth transitions
- Empty state handling
- Profile navigation

### 📝 Questionnaire
- 5 MCQ-type questions per questionnaire
- Custom radio button design with animations
- Real-time answer selection
- Validation before submission
- Location tracking (Latitude & Longitude)
- Offline storage of submissions

### 👤 Profile Screen
- User information display
- Total questionnaires completed count
- Submission history with:
  - Questionnaire name
  - Submission date & time
  - Location coordinates (Lat/Long)
- Animated cards with gradient design
- Logout functionality

### 🎨 UI/UX Highlights
- Gradient backgrounds throughout the app
- Smooth page transitions and animations
- Material 3 design
- Custom styled components
- Responsive layouts
- Beautiful color schemes

## 🛠️ Tech Stack

### Framework & Language
- **Flutter SDK**: ^3.11.0
- **Dart**: ^3.11.0

### State Management
- **GetX**: ^4.7.2 - Reactive state management, dependency injection, and routing

### Local Storage
- **Hive**: ^2.2.3 - Fast, lightweight NoSQL database
- **Hive Flutter**: ^1.1.0 - Flutter integration for Hive

### Backend & Authentication
- **Firebase Core**: ^3.13.1 - Firebase initialization
- **Firebase Auth**: ^5.5.1 - User authentication

### Location Services
- **Geolocator**: ^12.0.0 - GPS location tracking

### Utilities
- **Intl**: ^0.20.2 - Date/time formatting and internationalization

## 📁 Project Structure

```
lib/
├── app/
│   ├── controllers/          # GetX Controllers
│   │   ├── auth_controller.dart
│   │   ├── home_controller.dart
│   │   ├── profile_controller.dart
│   │   └── questionnaire_controller.dart
│   ├── models/               # Data Models
│   │   ├── app_user.dart
│   │   ├── questionnaire.dart
│   │   └── submission.dart
│   ├── routes/               # Navigation
│   │   ├── app_pages.dart
│   │   └── app_routes.dart
│   ├── screens/              # UI Screens
│   │   ├── home_screen.dart
│   │   ├── login_screen.dart
│   │   ├── profile_screen.dart
│   │   ├── questionnaire_screen.dart
│   │   └── register_screen.dart
│   └── services/             # Business Logic
│       ├── auth_service.dart
│       ├── firebase_service.dart
│       ├── local_storage_service.dart
│       ├── location_service.dart
│       └── questionnaire_service.dart
├── app.dart                  # App Configuration
└── main.dart                 # Entry Point
```

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (3.11.0 or higher)
- Dart SDK (3.11.0 or higher)
- Android Studio / VS Code
- Android SDK / Xcode (for iOS)
- Firebase account (for authentication)

### Installation

1. **Clone the repository**
```bash
git clone <repository-url>
cd quickquest
```

2. **Install dependencies**
```bash
flutter pub get
```

3. **Firebase Setup**
   - Create a Firebase project at [Firebase Console](https://console.firebase.google.com/)
   - Add Android/iOS app to your Firebase project
   - Download `google-services.json` (Android) and place in `android/app/`
   - Download `GoogleService-Info.plist` (iOS) and place in `ios/Runner/`
   - Enable Email/Password authentication in Firebase Console

4. **Run the app**
```bash
flutter run
```

## 📱 Supported Platforms
- ✅ Android
- ✅ iOS
- ✅ Windows (partial support)

## 🔧 Configuration

### Android Permissions
Add to `android/app/src/main/AndroidManifest.xml`:
```xml
<uses-permission android:name="android.permission.INTERNET"/>
<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION"/>
<uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION"/>
```

### iOS Permissions
Add to `ios/Runner/Info.plist`:
```xml
<key>NSLocationWhenInUseUsageDescription</key>
<string>This app needs location access to track questionnaire submissions</string>
```

## 📦 Build

### Android APK
```bash
flutter build apk --release
```

### Android App Bundle
```bash
flutter build appbundle --release
```

### iOS
```bash
flutter build ios --release
```

## 🎯 Key Features Implementation

### Offline Storage
- Uses Hive for local database
- Stores user sessions
- Saves questionnaire submissions
- Persists data across app restarts

### Location Tracking
- Captures GPS coordinates on submission
- Stores latitude and longitude with each response
- Handles location permissions

### State Management
- GetX for reactive programming
- Lazy loading of controllers
- Proper dependency injection
- Route bindings for clean architecture

### Animations
- Fade-in transitions
- Slide animations
- Staggered list animations
- Smooth page transitions

## 🐛 Troubleshooting

### Black Screen Issue
- Ensure all controllers are properly initialized
- Check GetX bindings in routes
- Verify Firebase initialization

### Location Not Working
- Check location permissions
- Enable GPS on device
- Verify geolocator package setup

### Firebase Errors
- Verify `google-services.json` is in correct location
- Check Firebase project configuration
- Ensure authentication is enabled

## 📄 License

This project is created for educational purposes.

## 👨‍💻 Developer

Built with ❤️ using Flutter

## 📞 Support

For issues and questions, please create an issue in the repository.

---

**Version**: 1.0.0  
**Last Updated**: 2024
