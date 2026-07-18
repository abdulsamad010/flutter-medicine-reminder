import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  final FlutterLocalNotificationsPlugin notifications =
  FlutterLocalNotificationsPlugin();

  final NotificationDetails notificationDetails =
  const NotificationDetails(
    android: AndroidNotificationDetails(
      'medicine_channel',
      'Medicine Reminder',
      channelDescription: 'Medicine reminder notifications',
      importance: Importance.max,
      priority: Priority.high,
    ),
  );

  Future<void> initialize() async {
    tz.initializeTimeZones();

    const AndroidInitializationSettings androidSettings =
    AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings settings = InitializationSettings(
      android: androidSettings,
    );

    await notifications.initialize(settings: settings);

    await notifications
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();
  }

  Future<void> scheduleMedicineNotification({
    required int id,
    required String medicineName,
    required String reminderTime,
  }) async {
    final now = DateTime.now();

    final time = DateFormat('hh:mm a').parse(reminderTime);

    DateTime scheduled = DateTime(
      now.year,
      now.month,
      now.day,
      time.hour,
      time.minute,
    );

    if (scheduled.isBefore(now)) {
      scheduled = scheduled.add(const Duration(days: 1));
    }

    final tz.TZDateTime scheduledDate =
    tz.TZDateTime.from(scheduled, tz.local);

    await notifications.zonedSchedule(
      id: id,
      title: 'Medicine Reminder',
      body: 'Time to take $medicineName',
      scheduledDate: scheduledDate,
      notificationDetails: notificationDetails,
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
    );
  }

  Future<void> cancelNotification(int id) async {
    await notifications.cancel(id:id);
  }
}