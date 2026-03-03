/// Component size tokens for the "Velvet & Gold" design system.
///
/// Use these constants for all fixed dimensions: heights, widths,
/// avatar diameters, image slots, and interactive target sizes.
/// Never hardcode a pixel value in widget code.
abstract final class AppSizes {
  // ── Touch targets ─────────────────────────────────────────────────────────
  /// Minimum tap target size per Material/HIG guidelines.
  static const double tapMin = 44;

  // ── Buttons ───────────────────────────────────────────────────────────────
  static const double buttonHeightSm = 36;
  static const double buttonHeightMd = 48;
  static const double buttonHeightLg = 56;

  // ── Input fields ──────────────────────────────────────────────────────────
  static const double inputHeight = 52;

  // ── Avatars ───────────────────────────────────────────────────────────────
  static const double avatarXs = 28;
  static const double avatarSm = 36;
  static const double avatarMd = 48;
  static const double avatarLg = 64;
  static const double avatarXl = 88;

  // ── Game cards (grid) ─────────────────────────────────────────────────────
  /// Thumbnail image height inside a game card.
  static const double gameThumbnailHeight = 72;
  /// Total card height in the 4-column grid.
  static const double gameCardHeight = 108;

  // ── Hero / banners ────────────────────────────────────────────────────────
  static const double heroBannerHeight = 180;
  static const double heroBannerHeightLarge = 220;

  // ── Game detail header image ──────────────────────────────────────────────
  static const double gameDetailHeaderHeight = 240;

  // ── Bottom navigation ─────────────────────────────────────────────────────
  static const double bottomNavHeight = 64;
  /// Thickness of the active-tab gold top border.
  static const double bottomNavIndicatorHeight = 3;

  // ── App bar ───────────────────────────────────────────────────────────────
  static const double appBarHeight = 56;

  // ── Category chips ────────────────────────────────────────────────────────
  static const double chipHeight = 32;

  // ── Badges ───────────────────────────────────────────────────────────────
  static const double badgeHeight = 18;
  static const double badgePaddingH = 6;

  // ── Dividers ─────────────────────────────────────────────────────────────
  static const double dividerThickness = 1;

  // ── Border widths ────────────────────────────────────────────────────────
  static const double borderThin = 1;
  static const double borderMedium = 2;

  // ── Max content width (tablet clamping) ──────────────────────────────────
  static const double maxContentWidth = 480;
}
