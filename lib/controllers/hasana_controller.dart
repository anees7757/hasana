import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';

class HasanaController extends GetxController with WidgetsBindingObserver {
  final storage = GetStorage();

  // Observable variables
  RxInt currentStreak = 0.obs;
  RxInt bestStreak = 0.obs;
  RxInt totalDays = 0.obs;
  RxString lastDeedDate = ''.obs;
  RxBool canPressToday = true.obs;

  // Storage keys
  static const String keyStreak = 'current_streak';
  static const String keyBestStreak = 'best_streak';
  static const String keyTotalDays = 'total_days';
  static const String keyLastDate = 'last_deed_date';

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addObserver(this);
    loadData();
    checkStreakStatus();
  }

  @override
  void onClose() {
    WidgetsBinding.instance.removeObserver(this);
    super.onClose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      checkStreakStatus();
    }
  }

  void loadData() {
    currentStreak.value = storage.read(keyStreak) ?? 0;
    bestStreak.value = storage.read(keyBestStreak) ?? 0;
    totalDays.value = storage.read(keyTotalDays) ?? 0;
    lastDeedDate.value = storage.read(keyLastDate) ?? '';
  }

  void checkStreakStatus() {
    final difference = _daysSinceLastDeed();

    if (difference == 0) {
      // Already pressed today
      canPressToday.value = false;
    } else if (difference == 1) {
      // Can continue streak
      canPressToday.value = true;
    } else {
      // Streak broken (difference > 1 or no deed yet)
      if (difference != null && difference > 1) {
        currentStreak.value = 0;
        storage.write(keyStreak, 0);
      }
      canPressToday.value = true;
    }
  }

  int? _daysSinceLastDeed() {
    if (lastDeedDate.value.isEmpty) return null;

    final lastDate = DateTime.parse(lastDeedDate.value);
    final today = DateTime.now();
    final todayDate = DateTime(today.year, today.month, today.day);
    final lastDateOnly = DateTime(lastDate.year, lastDate.month, lastDate.day);

    return todayDate.difference(lastDateOnly).inDays;
  }

  void recordGoodDeed() {
    if (!canPressToday.value) return;

    final today = DateTime.now();
    final todayString = DateFormat('yyyy-MM-dd').format(today);

    currentStreak.value++;
    if (currentStreak.value > bestStreak.value) {
      bestStreak.value = currentStreak.value;
      storage.write(keyBestStreak, bestStreak.value);
    }
    
    totalDays.value++;
    lastDeedDate.value = todayString;
    canPressToday.value = false;

    // Save to storage
    storage.write(keyStreak, currentStreak.value);
    storage.write(keyTotalDays, totalDays.value);
    storage.write(keyLastDate, todayString);
  }

  String getTodayDateString() {
    return DateFormat('yyyy-MM-dd').format(DateTime.now());
  }

  bool hasStreakBrokenSinceLastVisit() {
    final difference = _daysSinceLastDeed();
    return difference != null && difference > 1;
  }
}
