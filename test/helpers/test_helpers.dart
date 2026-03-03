import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:flutter_casino_platform/core/l10n/app_localizations.dart';
import 'package:flutter_casino_platform/core/theme/app_theme.dart';
import 'package:flutter_casino_platform/features/auth/domain/entities/user.dart';
import 'package:flutter_casino_platform/features/games/domain/entities/game_detail.dart';
import 'package:flutter_casino_platform/features/home/domain/entities/game_category.dart';
import 'package:flutter_casino_platform/features/home/domain/entities/game_summary.dart';
import 'package:flutter_casino_platform/features/home/domain/entities/promo_banner.dart';

// ── Shared widget wrapper ────────────────────────────────────────────────────

/// Wraps [child] in a [MaterialApp] with the app theme and full l10n setup.
///
/// Use this in widget tests to avoid boilerplate:
/// ```dart
/// await tester.pumpWidget(buildTestWidget(const MyWidget()));
/// ```
Widget buildTestWidget(Widget child) {
  return MaterialApp(
    theme: AppTheme.dark,
    localizationsDelegates: const [
      AppLocalizations.delegate,
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
    ],
    supportedLocales: AppLocalizations.supportedLocales,
    home: Scaffold(body: child),
  );
}

// ── Shared fixtures ──────────────────────────────────────────────────────────

/// Reusable [User] fixture for authentication tests.
final testUser = User(
  uid: 'uid-test-001',
  name: 'Alice Smith',
  email: 'alice@example.com',
  memberSince: DateTime(2024, 1, 15),
  accountId: 'ACC-TEST01',
);

/// Reusable [GameDetail] fixture for game-related tests.
const testGame = GameDetail(
  id: 'book-of-dead',
  name: 'Book of Dead',
  category: GameCategory.slots,
  provider: "Play'n GO",
  description: 'Join Rich Wilde on his quest through ancient Egypt.',
  rtp: 96.21,
  volatility: Volatility.high,
  imageUrl: 'https://picsum.photos/seed/bookdead/400/300',
  isNew: false,
  isHot: true,
);

/// Reusable [GameSummary] fixture derived from [testGame].
const testGameSummary = GameSummary(
  id: 'book-of-dead',
  name: 'Book of Dead',
  category: GameCategory.slots,
  provider: "Play'n GO",
  imageUrl: 'https://picsum.photos/seed/bookdead/400/300',
  isNew: false,
  isHot: true,
);

/// Reusable [PromoBanner] fixture for home screen tests.
const testBanner = PromoBanner(
  id: 'welcome-bonus',
  title: 'Welcome Bonus',
  subtitle: '200% up to \$500 on your first deposit',
  ctaLabel: 'Claim Now',
  imageUrl: 'https://picsum.photos/seed/welcome/800/400',
);

/// A list of test banners for tests that need multiple banners.
final testBanners = [
  testBanner,
  const PromoBanner(
    id: 'free-spins',
    title: '50 Free Spins',
    subtitle: 'Exclusively on Gates of Olympus',
    ctaLabel: 'Spin Now',
    imageUrl: 'https://picsum.photos/seed/freespins/800/400',
  ),
];

/// A list of test game summaries for home screen tests.
final testGames = [
  testGameSummary,
  const GameSummary(
    id: 'gates-of-olympus',
    name: 'Gates of Olympus',
    category: GameCategory.slots,
    provider: 'Pragmatic Play',
    imageUrl: 'https://picsum.photos/seed/olympus/400/300',
    isHot: true,
  ),
  const GameSummary(
    id: 'lightning-roulette',
    name: 'Lightning Roulette',
    category: GameCategory.live,
    provider: 'Evolution',
    imageUrl: 'https://picsum.photos/seed/roulette/400/300',
  ),
];
