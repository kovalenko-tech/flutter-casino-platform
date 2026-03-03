import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Typography tokens for the "Velvet & Gold" design system.
///
/// Headings use Poppins (personality, weight contrast).
/// Body copy uses Inter (readability at small sizes).
/// Numeric / metric styles use Inter with tabular-nums feature
/// so that digits stay fixed-width — critical for RTP, balances, stats.
abstract final class AppTypography {
  // ── Display (Poppins) ─────────────────────────────────────────────────────

  static TextStyle displayLarge(Color color) => GoogleFonts.poppins(
        fontSize: 36,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.5,
        color: color,
      );

  static TextStyle displayMedium(Color color) => GoogleFonts.poppins(
        fontSize: 28,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.25,
        color: color,
      );

  static TextStyle displaySmall(Color color) => GoogleFonts.poppins(
        fontSize: 22,
        fontWeight: FontWeight.w700,
        color: color,
      );

  // ── Headline (Poppins) ────────────────────────────────────────────────────

  static TextStyle headlineLarge(Color color) => GoogleFonts.poppins(
        fontSize: 24,
        fontWeight: FontWeight.w700,
        color: color,
      );

  static TextStyle headlineMedium(Color color) => GoogleFonts.poppins(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: color,
      );

  static TextStyle headlineSmall(Color color) => GoogleFonts.poppins(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: color,
      );

  // ── Title (Poppins) ───────────────────────────────────────────────────────

  static TextStyle titleLarge(Color color) => GoogleFonts.poppins(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: color,
      );

  static TextStyle titleMedium(Color color) => GoogleFonts.poppins(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: color,
      );

  static TextStyle titleSmall(Color color) => GoogleFonts.poppins(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.1,
        color: color,
      );

  // ── Body (Inter) ─────────────────────────────────────────────────────────

  static TextStyle bodyLarge(Color color) => GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: color,
      );

  static TextStyle bodyMedium(Color color) => GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: color,
      );

  static TextStyle bodySmall(Color color) => GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: color,
      );

  // ── Label (Inter) ─────────────────────────────────────────────────────────

  static TextStyle labelLarge(Color color) => GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.1,
        color: color,
      );

  static TextStyle labelMedium(Color color) => GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.5,
        color: color,
      );

  static TextStyle labelSmall(Color color) => GoogleFonts.inter(
        fontSize: 10,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.5,
        color: color,
      );

  // ── Numeric / metric (Inter tabular) ─────────────────────────────────────
  //
  // Use these for any value that changes dynamically: RTP percentages,
  // balances, counts, scores. Tabular nums keep digits fixed-width so
  // the layout doesn't shift as numbers update.

  static TextStyle numericLarge(Color color) => GoogleFonts.inter(
        fontSize: 28,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.5,
        color: color,
        fontFeatures: const [FontFeature.tabularFigures()],
      );

  static TextStyle numericMedium(Color color) => GoogleFonts.inter(
        fontSize: 20,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.25,
        color: color,
        fontFeatures: const [FontFeature.tabularFigures()],
      );

  static TextStyle numericSmall(Color color) => GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: color,
        fontFeatures: const [FontFeature.tabularFigures()],
      );

  /// Compact mono metric — used for IDs, account numbers, codes.
  static TextStyle monoSmall(Color color) => GoogleFonts.robotoMono(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.5,
        color: color,
        fontFeatures: const [FontFeature.tabularFigures()],
      );

  // ── TextTheme builder ─────────────────────────────────────────────────────

  static TextTheme buildTextTheme(Color primary, Color secondary) => TextTheme(
        displayLarge: displayLarge(primary),
        displayMedium: displayMedium(primary),
        displaySmall: displaySmall(primary),
        headlineLarge: headlineLarge(primary),
        headlineMedium: headlineMedium(primary),
        headlineSmall: headlineSmall(primary),
        titleLarge: titleLarge(primary),
        titleMedium: titleMedium(primary),
        titleSmall: titleSmall(primary),
        bodyLarge: bodyLarge(primary),
        bodyMedium: bodyMedium(primary),
        bodySmall: bodySmall(secondary),
        labelLarge: labelLarge(primary),
        labelMedium: labelMedium(secondary),
        labelSmall: labelSmall(secondary),
      );
}
