import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'controllers/hasana_controller.dart';
import 'screens/home_screen.dart';
import 'services/notification_service.dart';

/// Background entry-point for AndroidAlarmManager.
/// This runs in a separate Dart isolate — keep it lightweight.
@pragma('vm:entry-point')
Future<void> _alarmCallback() async {
  await GetStorage.init();
  await NotificationService.instance.init();
  // Re-schedule slots for today (shows notification only if deed not yet logged)
  await NotificationService.instance.scheduleDailySlots();
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await AndroidAlarmManager.initialize();

  // Set status bar to transparent with dark icons
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
    ),
  );

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  Get.put(HasanaController());

  runApp(const HasanaApp());
}

class HasanaApp extends StatelessWidget {
  const HasanaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'حسنة',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
        scaffoldBackgroundColor: const Color(0xFFF5F5F0),
        fontFamily: 'Georgia',
        useMaterial3: true,
      ),
      home: MediaQuery(
        data: MediaQuery.of(
          context,
        ).copyWith(textScaler: const TextScaler.linear(1.0)),
        child: const HomeScreen(),
      ),
    );
  }
}
