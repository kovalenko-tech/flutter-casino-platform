import 'package:flutter/material.dart';

/// Color tokens for the "Velvet & Gold" design system.
/// Two schemes: dark (default casino look) and light.
abstract final class AppColors {
  // ── Dark scheme ──────────────────────────────────────────────────────────
  static const Color darkBackground = Color(0xFF080B14);
  static const Color darkSurface = Color(0xFF111827);
  static const Color darkCard = Color(0xFF1C2333);
  static const Color darkPrimary = Color(0xFFF0B429);
  static const Color darkAccent = Color(0xFF8B5CF6);
  static const Color darkSuccess = Color(0xFF10B981);
  static const Color darkError = Color(0xFFEF4444);
  static const Color darkOnPrimary = Color(0xFF0A0A0A);
  static const Color darkTextPrimary = Color(0xFFF9FAFB);
  static const Color darkTextSecondary = Color(0xFF9CA3AF);
  static const Color darkBorder = Color(0xFF2D3748);

  // ── Light scheme ─────────────────────────────────────────────────────────
  static const Color lightBackground = Color(0xFFF5F4EF);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightCard = Color(0xFFFAF9F6);
  static const Color lightPrimary = Color(0xFFD97706);
  static const Color lightAccent = Color(0xFF7C3AED);
  static const Color lightSuccess = Color(0xFF10B981);
  static const Color lightError = Color(0xFFEF4444);
  static const Color lightOnPrimary = Color(0xFFFFFFFF);
  static const Color lightTextPrimary = Color(0xFF0F172A);
  static const Color lightTextSecondary = Color(0xFF64748B);
  static const Color lightBorder = Color(0xFFE2E8F0);

  // ── Shared ───────────────────────────────────────────────────────────────
  static const Color transparent = Colors.transparent;

  // ── ColorScheme factories ────────────────────────────────────────────────
  static ColorScheme get darkScheme => const ColorScheme(
        brightness: Brightness.dark,
        primary: darkPrimary,
        onPrimary: darkOnPrimary,
        secondary: darkAccent,
        onSecondary: darkTextPrimary,
        error: darkError,
        onError: darkTextPrimary,
        surface: darkSurface,
        onSurface: darkTextPrimary,
        surfaceContainerHighest: darkCard,
        outline: darkBorder,
        background: darkBackground,
        onBackground: darkTextPrimary,
        tertiary: darkSuccess,
        onTertiary: darkOnPrimary,
      );

  static ColorScheme get lightScheme => const ColorScheme(
        brightness: Brightness.light,
        primary: lightPrimary,
        onPrimary: lightOnPrimary,
        secondary: lightAccent,
        onSecondary: lightTextPrimary,
        error: lightError,
        onError: lightOnPrimary,
        surface: lightSurface,
        onSurface: lightTextPrimary,
        surfaceContainerHighest: lightCard,
        outline: lightBorder,
        background: lightBackground,
        onBackground: lightTextPrimary,
        tertiary: lightSuccess,
        onTertiary: lightOnPrimary,
      );
}
