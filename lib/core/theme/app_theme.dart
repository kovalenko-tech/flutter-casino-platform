import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app_colors.dart';
import 'app_radius.dart';
import 'app_spacing.dart';
import 'app_typography.dart';

/// Assembles full ThemeData instances from design tokens.
/// Import this class wherever MaterialApp needs its theme.
abstract final class AppTheme {
  static ThemeData get dark => _buildTheme(
        scheme: AppColors.darkScheme,
        scaffoldBackground: AppColors.darkBackground,
        textPrimary: AppColors.darkTextPrimary,
        textSecondary: AppColors.darkTextSecondary,
        cardColor: AppColors.darkCard,
        dividerColor: AppColors.darkBorder,
        brightness: Brightness.dark,
        systemUiStyle: SystemUiOverlayStyle.light,
      );

  static ThemeData get light => _buildTheme(
        scheme: AppColors.lightScheme,
        scaffoldBackground: AppColors.lightBackground,
        textPrimary: AppColors.lightTextPrimary,
        textSecondary: AppColors.lightTextSecondary,
        cardColor: AppColors.lightCard,
        dividerColor: AppColors.lightBorder,
        brightness: Brightness.light,
        systemUiStyle: SystemUiOverlayStyle.dark,
      );

  // ---------------------------------------------------------------------------

  static ThemeData _buildTheme({
    required ColorScheme scheme,
    required Color scaffoldBackground,
    required Color textPrimary,
    required Color textSecondary,
    required Color cardColor,
    required Color dividerColor,
    required Brightness brightness,
    required SystemUiOverlayStyle systemUiStyle,
  }) {
    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: scheme,
      scaffoldBackgroundColor: scaffoldBackground,
      dividerColor: dividerColor,
      textTheme: AppTypography.buildTextTheme(textPrimary, textSecondary),

      // ── AppBar ──────────────────────────────────────────────────────────
      appBarTheme: AppBarTheme(
        backgroundColor: scaffoldBackground,
        foregroundColor: textPrimary,
        elevation: 0,
        centerTitle: true,
        systemOverlayStyle: systemUiStyle,
        titleTextStyle: AppTypography.titleLarge(textPrimary),
      ),

      // ── Card ────────────────────────────────────────────────────────────
      cardTheme: CardThemeData(
        color: cardColor,
        elevation: 0,
        shape: const RoundedRectangleBorder(borderRadius: AppRadius.lgAll),
        margin: EdgeInsets.zero,
      ),

      // ── Bottom Navigation ────────────────────────────────────────────────
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: scaffoldBackground,
        selectedItemColor: scheme.primary,
        unselectedItemColor: textSecondary,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
        selectedLabelStyle: AppTypography.labelSmall(scheme.primary),
        unselectedLabelStyle: AppTypography.labelSmall(textSecondary),
      ),

      // ── Input / TextField ────────────────────────────────────────────────
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: cardColor,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.md,
        ),
        border: OutlineInputBorder(
          borderRadius: AppRadius.mdAll,
          borderSide: BorderSide(color: dividerColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: AppRadius.mdAll,
          borderSide: BorderSide(color: dividerColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: AppRadius.mdAll,
          borderSide: BorderSide(color: scheme.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: AppRadius.mdAll,
          borderSide: BorderSide(color: scheme.error),
        ),
        labelStyle: AppTypography.bodyMedium(textSecondary),
        hintStyle: AppTypography.bodyMedium(textSecondary),
      ),

      // ── ElevatedButton ───────────────────────────────────────────────────
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: scheme.primary,
          foregroundColor: scheme.onPrimary,
          minimumSize: const Size(double.infinity, 52),
          shape: const RoundedRectangleBorder(borderRadius: AppRadius.mdAll),
          textStyle: AppTypography.labelLarge(scheme.onPrimary),
          elevation: 0,
        ),
      ),

      // ── OutlinedButton ───────────────────────────────────────────────────
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: scheme.primary,
          minimumSize: const Size(double.infinity, 52),
          shape: const RoundedRectangleBorder(borderRadius: AppRadius.mdAll),
          side: BorderSide(color: scheme.primary),
          textStyle: AppTypography.labelLarge(scheme.primary),
        ),
      ),

      // ── Chip ─────────────────────────────────────────────────────────────
      chipTheme: ChipThemeData(
        backgroundColor: cardColor,
        selectedColor: scheme.primary,
        labelStyle: AppTypography.labelMedium(textSecondary),
        side: BorderSide(color: dividerColor),
        shape: const RoundedRectangleBorder(borderRadius: AppRadius.fullAll),
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.sm,
          vertical: AppSpacing.xs,
        ),
      ),
    );
  }
}
