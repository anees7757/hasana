import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTextStyles {
  static TextStyle get logo => GoogleFonts.vibes(
    fontSize: 32,
    fontWeight: FontWeight.w600,
    color: AppColors.primary,
  );

  static TextStyle get heading => const TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: AppColors.textHeading,
  );

  static TextStyle get subHeading => const TextStyle(
    fontSize: 15,
    color: AppColors.textHint,
    fontWeight: FontWeight.w400,
  );

  static TextStyle get buttonText =>
      const TextStyle(fontSize: 18, fontWeight: FontWeight.w500);

  static TextStyle get streakNumber => const TextStyle(
    fontSize: 36,
    fontWeight: FontWeight.bold,
    color: AppColors.primary,
  );

  static TextStyle get streakLabel => const TextStyle(
    fontSize: 20,
    color: AppColors.textSecondary,
    fontWeight: FontWeight.w500,
  );

  static TextStyle get kalima => GoogleFonts.notoNastaliqUrdu(fontSize: 18);

  static TextStyle get quote => const TextStyle(
    fontSize: 14,
    color: AppColors.primary,
    fontStyle: FontStyle.italic,
    fontWeight: FontWeight.w500,
  );

  static TextStyle get dialogTitle => const TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: AppColors.textHeading,
  );

  static TextStyle get dialogBody =>
      const TextStyle(fontSize: 15, color: AppColors.textBody, height: 1.4);
}
