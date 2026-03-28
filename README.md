# Hasana (حسنة) - Good Deeds Tracker

A beautiful Islamic app to track your daily good deeds and build a streak of positivity.

## Features

- ✨ **One Tap Per Day**: Record your good deed with a single tap
- 🔥 **Streak System**: Build consecutive days of good deeds
- 📊 **Total Tracking**: Keep count of all your good deeds
- 💾 **Persistent Storage**: Your data is saved using GetX Storage
- 🎨 **Islamic Design**: Calming colors with Arabic elements
- ℹ️ **Info Dialog**: Learn what counts as a good deed
- 🚫 **One Press Per Day**: Button disabled after daily press

## What Counts as Good?

- Gave charity (sadaqah)
- Controlled your anger
- Didn't watch something harmful
- Helped someone in need
- Made du'a or dhikr
- Forgave someone
- Spoke kindly to others
- Prayed on time

**Any act of kindness, self-control, or worship counts. The intention matters most.**

## Tech Stack

- **Flutter**: Cross-platform UI framework
- **GetX**: State management and storage
- **GetStorage**: Local persistent storage
- **Material Design 3**: Modern UI components

## Project Structure

```
lib/
├── main.dart
├── controllers/
│   └── hasana_controller.dart
├── screens/
│   └── home_screen.dart
└── widgets/
│   └── info_dialog.dart
└── data/
    └── islamic_quotes.dart
```

## Setup Instructions

1. **Install Flutter**: Make sure you have Flutter installed on your system
   ```bash
   flutter doctor
   ```

2. **Get Dependencies**:
   ```bash
   cd hasana_app
   flutter pub get
   ```

3. **Run the App**:
   ```bash
   flutter run
   ```

## How It Works

### State Management
The app uses GetX for reactive state management. The `HasanaController` handles:
- Current streak count
- Total days count
- Last deed date
- Daily press eligibility

### Streak Logic
- If you press the button today, streak increases by 1
- If you skip a day, streak resets to 0
- You can only press once per day
- Total days count never decreases

### Storage
All data persists locally using GetStorage:
- `current_streak`: Number of consecutive days
- `total_days`: Total number of good deeds recorded
- `last_deed_date`: Date of last recorded deed

## Customization

### Colors
Main colors used in the app:
- Primary: `#5F9EA0` (Cadet Blue)
- Background: `#F5F5F0` (Beige)
- Dialog: `#FFF9E6` (Light Yellow)
- Text: `#2C3E50` (Dark Blue Gray)

## Build for Production

### Android
```bash
flutter build apk --release
```

### iOS
```bash
flutter build ios --release
```

## License

This is a personal project for Islamic practice and self-improvement.

---

**May Allah accept all our good deeds** ✨
