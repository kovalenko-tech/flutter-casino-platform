import 'package:flutter/material.dart';

/// Semantic color roles resolved automatically via [ThemeExtension].
///
/// Widgets read these instead of branching on `isDark`.
class AppColorsExtension extends ThemeExtension<AppColorsExtension> {
  final Color textSecondary;
  final Color card;
  final Color background;
  final Color border;

  const AppColorsExtension({
    required this.textSecondary,
    required this.card,
    required this.background,
    required this.border,
  });

  @override
  AppColorsExtension copyWith({
    Color? textSecondary,
    Color? card,
    Color? background,
    Color? border,
  }) {
    return AppColorsExtension(
      textSecondary: textSecondary ?? this.textSecondary,
      card: card ?? this.card,
      background: background ?? this.background,
      border: border ?? this.border,
    );
  }

  @override
  AppColorsExtension lerp(AppColorsExtension? other, double t) {
    if (other is! AppColorsExtension) return this;
    return AppColorsExtension(
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t)!,
      card: Color.lerp(card, other.card, t)!,
      background: Color.lerp(background, other.background, t)!,
      border: Color.lerp(border, other.border, t)!,
    );
  }
}
