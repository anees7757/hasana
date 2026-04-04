import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import '../controllers/hasana_controller.dart';
import '../widgets/info_dialog.dart';
import '../data/islamic_quotes.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animController;
  late Animation<double> _scaleAnim;
  late Animation<double> _glowAnim;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 180),
    );

    _scaleAnim = Tween<double>(begin: 1.0, end: 0.91).animate(
      CurvedAnimation(parent: _animController, curve: Curves.easeInOut),
    );

    _glowAnim = Tween<double>(begin: 0.3, end: 0.7).animate(
      CurvedAnimation(parent: _animController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  void _onTapDown(bool canPress) {
    if (!canPress) return;
    _animController.forward();
  }

  void _onTapUp(bool canPress, HasanaController controller) {
    if (!canPress) return;
    _animController.reverse();
    HapticFeedback.selectionClick();
    controller.recordGoodDeed();
    Get.snackbar(
      '',
      '',
      titleText: const SizedBox.shrink(),
      messageText: Text(
        'May Allah accept your good deeds',
        style: AppTextStyles.dialogBody.copyWith(color: AppColors.surface),
        textAlign: TextAlign.center,
      ),
      backgroundColor: AppColors.primary,
      colorText: AppColors.surface,
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
      duration: const Duration(seconds: 4),
    );
  }

  void _onTapCancel() {
    _animController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HasanaController>();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        titleSpacing: 20,
        centerTitle: false,
        title: Text('حسنة', style: AppTextStyles.logo),
        actions: [
          IconButton(
            onPressed: () {
              Get.dialog(const InfoDialog());
            },
            icon: const Icon(
              PhosphorIconsRegular.info,
              color: AppColors.textHint,
              size: 26,
            ),
          ),
          SizedBox(width: 10),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),

              Obx(() {
                final canPress = controller.canPressToday.value;
                return Column(
                  children: [
                    Text(
                      canPress
                          ? 'Did you choose good today?'
                          : 'You chose good today!',
                      style: AppTextStyles.heading,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Obx(() {
                      final streak = controller.currentStreak.value;

                      return Text(
                        streak == 0
                            ? 'بسم الله'
                            : controller.canPressToday.value
                            ? 'إن شاء الله'
                            : controller.hasStreakBrokenSinceLastVisit()
                            ? 'ما شاء الله'
                            : 'بارك الله فيك',
                        style: AppTextStyles.kalima.copyWith(
                          color: controller.hasStreakBrokenSinceLastVisit()
                              ? AppColors.accent
                              : AppColors.textHint,
                        ),
                        textAlign: TextAlign.center,
                      );
                    }),
                  ],
                );
              }),

              const Spacer(),

              // Main button
              Obx(() {
                final canPress = controller.canPressToday.value;
                final screenWidth = MediaQuery.of(context).size.width;
                final buttonSize = (screenWidth * 0.60).clamp(160.0, 260.0);

                return GestureDetector(
                  onTapDown: (_) => _onTapDown(canPress),
                  onTapUp: (_) => _onTapUp(canPress, controller),
                  onTapCancel: _onTapCancel,
                  child: AnimatedBuilder(
                    animation: _animController,
                    builder: (context, child) {
                      return Transform.scale(
                        scale: canPress ? _scaleAnim.value : 1.0,
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          width: buttonSize,
                          height: buttonSize,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: canPress
                                ? AppColors.primaryLight
                                : AppColors.primaryPale,
                            boxShadow: canPress
                                ? [
                                    BoxShadow(
                                      color: AppColors.primary.withValues(
                                        alpha: _glowAnim.value,
                                      ),
                                      blurRadius: 30,
                                      spreadRadius: 5,
                                    ),
                                  ]
                                : [],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                canPress
                                    ? PhosphorIconsFill.sparkle
                                    : PhosphorIconsRegular.sparkle,
                                size: 48,
                                color: canPress
                                    ? AppColors.primary
                                    : AppColors.textHint,
                              ),
                              const SizedBox(height: 24),
                              Text(
                                canPress
                                    ? 'I chose good today'
                                    : 'Alhamdulillah!',
                                style: AppTextStyles.buttonText.copyWith(
                                  color: canPress
                                      ? AppColors.primary
                                      : AppColors.textSecondary,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                );
              }),

              const Spacer(),

              // Streak display
              Obx(() {
                final streak = controller.currentStreak.value;

                return Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('$streak', style: AppTextStyles.streakNumber),
                        const SizedBox(width: 8),
                        Text(
                          streak == 1 ? 'day streak' : 'days streak',
                          style: AppTextStyles.streakLabel,
                        ),
                        const SizedBox(width: 6),
                        Icon(
                          streak > 0
                              ? PhosphorIconsFill.fire
                              : PhosphorIconsRegular.fire,
                          size: 26,
                          color: streak > 0
                              ? AppColors.accent
                              : AppColors.textHint,
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),

                    if (streak > 0) ...[
                      _buildMilestoneBar(streak),
                    ] else ...[
                      SizedBox(height: 8),
                    ],
                  ],
                );
              }),

              const SizedBox(height: 50),

              // Bottom quote
              Obx(() {
                final streak = controller.currentStreak.value;
                final isBroken = controller.isStreakBroken.value;
                final showBrokenUI = isBroken && streak == 0;

                return AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                  decoration: BoxDecoration(
                    color: showBrokenUI
                        ? AppColors.accent.withValues(alpha: 0.12)
                        : AppColors.surface.withValues(alpha: 0.7),
                    borderRadius: BorderRadius.circular(16),
                    border: showBrokenUI
                        ? Border.all(
                            color: AppColors.accent.withValues(alpha: 0.3),
                            width: 1,
                          )
                        : null,
                  ),
                  child: Text(
                    IslamicQuotes.getStreakMessage(streak, isBroken: isBroken),
                    style: AppTextStyles.quote.copyWith(
                      color: showBrokenUI
                          ? AppColors.accent
                          : AppColors.textSecondary,
                      fontWeight: showBrokenUI ? FontWeight.w500 : null,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                );
              }),

              SizedBox(height: MediaQuery.paddingOf(context).bottom),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMilestoneBar(int streak) {
    int nextMilestone = 7;
    if (streak >= 100) {
      nextMilestone = 365;
    } else if (streak >= 30) {
      nextMilestone = 100;
    } else if (streak >= 14) {
      nextMilestone = 30;
    } else if (streak >= 7) {
      nextMilestone = 14;
    }

    double progress = (streak / nextMilestone).clamp(0.0, 1.0);

    return Column(
      children: [
        Container(
          width: 200,
          height: 8,
          decoration: BoxDecoration(
            color: AppColors.primaryPale,
            borderRadius: BorderRadius.circular(4),
          ),
          child: FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: progress,
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Next goal: $nextMilestone days',
          style: AppTextStyles.subHeading.copyWith(fontSize: 12),
        ),
      ],
    );
  }
}
