import 'package:flutter/material.dart';
import 'app_colors.dart';

/// Elevation / shadow presets for the "Velvet & Gold" design system.
abstract final class AppShadows {
  /// Subtle shadow used on game cards.
  static const List<BoxShadow> card = [
    BoxShadow(
      color: Color(0x40000000),
      blurRadius: 12,
      offset: Offset(0, 4),
    ),
  ];

  /// Deeper shadow for modal sheets and dialogs.
  static const List<BoxShadow> modal = [
    BoxShadow(
      color: Color(0x66000000),
      blurRadius: 32,
      offset: Offset(0, 8),
    ),
  ];

  /// Golden glow effect for the active bottom-nav indicator.
  static const List<BoxShadow> bottomNavActive = [
    BoxShadow(
      color: Color(0x40F0B429),
      blurRadius: 8,
      spreadRadius: 1,
    ),
  ];

  /// Primary (gold) glow for CTA buttons.
  static const List<BoxShadow> primaryGlow = [
    BoxShadow(
      color: Color(0x60F0B429),
      blurRadius: 16,
      offset: Offset(0, 4),
    ),
  ];
}
