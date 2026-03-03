import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_casino_platform/features/games/domain/entities/game_detail.dart';
import 'package:flutter_casino_platform/features/home/domain/entities/game_summary.dart';
import 'package:flutter_casino_platform/features/home/domain/entities/game_category.dart';

void main() {
  const testGame = GameDetail(
    id: 'book-of-dead',
    name: 'Book of Dead',
    category: GameCategory.slots,
    provider: "Play'n GO",
    description: 'An iconic Egypt-themed slot.',
    rtp: 96.21,
    volatility: Volatility.high,
    imageUrl: 'https://example.com/bod.jpg',
    isNew: false,
    isHot: true,
  );

  group('Volatility enum', () {
    test('has low variant', () {
      expect(Volatility.low, isA<Volatility>());
    });

    test('has medium variant', () {
      expect(Volatility.medium, isA<Volatility>());
    });

    test('has high variant', () {
      expect(Volatility.high, isA<Volatility>());
    });

    test('has exactly three values', () {
      expect(Volatility.values.length, equals(3));
    });
  });

  group('GameDetail', () {
    test('toSummary returns GameSummary with matching id', () {
      final summary = testGame.toSummary();
      expect(summary.id, equals(testGame.id));
    });

    test('toSummary returns GameSummary with matching name', () {
      final summary = testGame.toSummary();
      expect(summary.name, equals(testGame.name));
    });

    test('toSummary returns GameSummary with matching category', () {
      final summary = testGame.toSummary();
      expect(summary.category, equals(testGame.category));
    });

    test('toSummary returns GameSummary with matching provider', () {
      final summary = testGame.toSummary();
      expect(summary.provider, equals(testGame.provider));
    });

    test('toSummary returns GameSummary with matching imageUrl', () {
      final summary = testGame.toSummary();
      expect(summary.imageUrl, equals(testGame.imageUrl));
    });

    test('toSummary preserves isNew flag', () {
      final summary = testGame.toSummary();
      expect(summary.isNew, equals(testGame.isNew));
    });

    test('toSummary preserves isHot flag', () {
      final summary = testGame.toSummary();
      expect(summary.isHot, equals(testGame.isHot));
    });

    test('toSummary returns a GameSummary instance', () {
      expect(testGame.toSummary(), isA<GameSummary>());
    });

    test('two GameDetails with same fields are equal', () {
      const gameCopy = GameDetail(
        id: 'book-of-dead',
        name: 'Book of Dead',
        category: GameCategory.slots,
        provider: "Play'n GO",
        description: 'An iconic Egypt-themed slot.',
        rtp: 96.21,
        volatility: Volatility.high,
        imageUrl: 'https://example.com/bod.jpg',
        isNew: false,
        isHot: true,
      );
      expect(testGame, equals(gameCopy));
    });
  });
}
