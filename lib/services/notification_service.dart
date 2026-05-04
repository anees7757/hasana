import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

/// Daily reminder time slots.
/// Each slot fires independently; if the deed is already logged the
/// notification is suppressed and all remaining slots for the day are cancelled.
const List<_TimeSlot> _kSlots = [
  _TimeSlot(id: 10, hour: 10, minute: 0, label: 'Morning reminder'),
  _TimeSlot(id: 13, hour: 13, minute: 0, label: 'Afternoon reminder'),
  _TimeSlot(id: 16, hour: 16, minute: 0, label: 'Late afternoon reminder'),
  _TimeSlot(id: 19, hour: 19, minute: 0, label: 'Evening reminder'),
  _TimeSlot(id: 21, hour: 21, minute: 0, label: 'Night reminder'),
];

/// Motivational messages paired to each slot.
const Map<int, String> _kMessages = {
  10: 'Start your day with a good deed 🌅\nHave you chosen good today?',
  13: 'Still time to choose good today 🌿\nLog your good deed now.',
  16: 'The afternoon is still yours ✨\nDid you choose good today?',
  19: 'Evening — don\'t miss today\'s deed 🌙\nLog it before the day ends.',
  21: 'One last chance before midnight 🌟\nRecord today\'s good deed — don\'t break your streak!',
};

class NotificationService {
  NotificationService._();

  static final NotificationService instance = NotificationService._();

  final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  static const String _channelId = 'hasana_daily_reminders';
  static const String _channelName = 'Daily Reminders';
  static const String _channelDesc =
      'Reminds you to log your good deed for the day.';

  // ─── Initialisation ────────────────────────────────────────────────────────

  Future<void> init() async {
    tz.initializeTimeZones();

    // Try to keep the local timezone; fall back to UTC if unavailable.
    try {
      final localTz = DateTime.now().timeZoneName;
      tz.setLocalLocation(tz.getLocation(localTz));
    } catch (_) {
      tz.setLocalLocation(tz.UTC);
    }

    const androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosInit = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    await _plugin.initialize(
      const InitializationSettings(android: androidInit, iOS: iosInit),
    );

    await _requestPermission();
  }

  Future<void> _requestPermission() async {
    final android = _plugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >();
    await android?.requestNotificationsPermission();
    await android?.requestExactAlarmsPermission();
  }

  // ─── Schedule ──────────────────────────────────────────────────────────────

  /// Schedules (or re-schedules) all 5 daily reminder slots.
  /// Call this on every app launch so slots always point to the
  /// correct upcoming time.
  Future<void> scheduleDailySlots() async {
    // If the user already logged today, skip scheduling until tomorrow.
    if (_hasLoggedToday()) {
      await cancelAll();
      return;
    }

    final now = tz.TZDateTime.now(tz.local);

    for (final slot in _kSlots) {
      // Build TZDateTime for today's slot time.
      var scheduledDate = tz.TZDateTime(
        tz.local,
        now.year,
        now.month,
        now.day,
        slot.hour,
        slot.minute,
      );

      // If this slot has already passed today, schedule for tomorrow.
      if (scheduledDate.isBefore(now)) {
        scheduledDate = scheduledDate.add(const Duration(days: 1));
      }

      await _plugin.zonedSchedule(
        slot.id,
        'حسنة — Hasana',
        _kMessages[slot.id] ?? 'Have you chosen good today?',
        scheduledDate,
        _notificationDetails(),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        matchDateTimeComponents: DateTimeComponents.time,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
      );
    }
  }

  /// Cancels ALL pending reminder notifications for today (and future days).
  /// Call this immediately after the user records their good deed.
  Future<void> cancelAll() async {
    for (final slot in _kSlots) {
      await _plugin.cancel(slot.id);
    }
  }

  /// Cancels only the slots that are strictly after [afterHour].
  /// Useful for suppressing later-in-day reminders once an early slot fires.
  Future<void> cancelSlotsAfter(int afterHour) async {
    for (final slot in _kSlots) {
      if (slot.hour > afterHour) {
        await _plugin.cancel(slot.id);
      }
    }
  }

  // ─── Storage helpers ───────────────────────────────────────────────────────

  bool _hasLoggedToday() {
    final storage = GetStorage();
    final lastDate = storage.read<String>('last_deed_date') ?? '';
    if (lastDate.isEmpty) return false;
    final today = DateFormat('yyyy-MM-dd').format(DateTime.now());
    return lastDate == today;
  }

  // ─── Android notification channel ─────────────────────────────────────────

  NotificationDetails _notificationDetails() {
    const android = AndroidNotificationDetails(
      _channelId,
      _channelName,
      channelDescription: _channelDesc,
      importance: Importance.high,
      priority: Priority.high,
      icon: '@mipmap/ic_launcher',
      playSound: true,
      enableVibration: true,
      styleInformation: BigTextStyleInformation(''),
    );

    const ios = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    return const NotificationDetails(android: android, iOS: ios);
  }
}

// ─── Internal model ──────────────────────────────────────────────────────────

class _TimeSlot {
  const _TimeSlot({
    required this.id,
    required this.hour,
    required this.minute,
    required this.label,
  });

  final int id;
  final int hour;
  final int minute;
  final String label;
}
