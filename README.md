# Medicine Reminder

A Flutter medicine reminder application for managing scheduled medications with offline data persistence and recurring local notifications.

The application allows users to create medicine reminders for themselves or people they care for, store reminder information locally, and receive notifications at scheduled medicine times without requiring an internet connection or user account.

## Planned Features

- Add medicine reminders
- View saved medicine reminders
- Edit medicine reminders
- Delete medicine reminders
- Assign medicines to a person
- Store medicine data locally using SQLite
- Manage application state using Provider and ChangeNotifier
- Schedule recurring daily local notifications
- Update notifications when medicine reminders are edited
- Cancel notifications when medicine reminders are deleted
- Form validation
- Loading and empty states
- Clean Material 3 user interface

## Tech Stack

- Flutter
- Dart
- Provider
- ChangeNotifier
- SQLite
- sqflite
- flutter_local_notifications
- timezone
- Material 3

## Project Structure

```text
lib/
├── main.dart
├── models/
│   └── medicine.dart
├── providers/
│   └── medicine_provider.dart
├── database/
│   └── database_helper.dart
├── services/
│   └── notification_service.dart
├── screens/
│   ├── home_screen.dart
│   └── medicine_form_screen.dart
└── widgets/
    └── medicine_card.dart