import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

import 'package:flutter_casino_platform/core/theme/app_theme.dart';
import 'package:flutter_casino_platform/features/home/domain/entities/game_category.dart';
import 'package:flutter_casino_platform/features/home/domain/entities/game_summary.dart';
import 'package:flutter_casino_platform/features/home/presentation/widgets/game_card.dart';

/// Returns a [GoRouter] wired up for testing — navigation is captured
/// but doesn't cause the test to fail.
GoRouter _testRouter({required Widget home}) {
  return GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(path: '/', builder: (_, __) => home),
      GoRoute(
        path: '/games/:id',
        builder: (_, __) => const Scaffold(body: Text('Game Detail')),
      ),
    ],
  );
}

Widget _buildTestApp(Widget child) {
  return MaterialApp.router(
    theme: AppTheme.dark,
    routerConfig: _testRouter(home: Scaffold(body: child)),
  );
}

void main() {
  const baseGame = GameSummary(
    id: 'book-of-dead',
    name: 'Book of Dead',
    category: GameCategory.slots,
    provider: "Play'n GO",
    imageUrl: 'https://picsum.photos/seed/bookdead/400/300',
  );

  group('GameCard', () {
    testWidgets('displays game name', (tester) async {
      await tester.pumpWidget(_buildTestApp(const GameCard(game: baseGame)));
      await tester.pump();

      expect(find.text('Book of Dead'), findsOneWidget);
    });

    testWidgets('shows NEW badge when isNew=true', (tester) async {
      const newGame = GameSummary(
        id: 'new-game',
        name: 'New Slot',
        category: GameCategory.slots,
        provider: 'Dev',
        imageUrl: 'https://picsum.photos/seed/newgame/400/300',
        isNew: true,
      );

      await tester.pumpWidget(_buildTestApp(const GameCard(game: newGame)));
      await tester.pump();

      expect(find.text('NEW'), findsOneWidget);
    });

    testWidgets('shows HOT badge when isHot=true', (tester) async {
      const hotGame = GameSummary(
        id: 'hot-game',
        name: 'Hot Slot',
        category: GameCategory.slots,
        provider: 'Dev',
        imageUrl: 'https://picsum.photos/seed/hotgame/400/300',
        isHot: true,
      );

      await tester.pumpWidget(_buildTestApp(const GameCard(game: hotGame)));
      await tester.pump();

      expect(find.text('HOT'), findsOneWidget);
    });

    testWidgets('shows no badge when isNew=false and isHot=false', (
      tester,
    ) async {
      await tester.pumpWidget(_buildTestApp(const GameCard(game: baseGame)));
      await tester.pump();

      expect(find.text('NEW'), findsNothing);
      expect(find.text('HOT'), findsNothing);
    });

    testWidgets('navigates on tap without throwing', (tester) async {
      await tester.pumpWidget(_buildTestApp(const GameCard(game: baseGame)));
      await tester.pump();

      // Tap should trigger GoRouter navigation without errors.
      await tester.tap(find.byType(GestureDetector).first);
      await tester.pumpAndSettle();

      // After navigation we should see the detail stub page.
      expect(find.text('Game Detail'), findsOneWidget);
    });
  });
}
