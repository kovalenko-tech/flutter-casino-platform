import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_casino_platform/features/home/domain/entities/game_summary.dart';
import 'package:flutter_casino_platform/features/home/domain/entities/game_category.dart';

void main() {
  group('GameSummary', () {
    const base = GameSummary(
      id: 'game-1',
      name: 'Book of Dead',
      category: GameCategory.slots,
      provider: "Play'n GO",
      imageUrl: 'https://example.com/image.jpg',
    );

    const baseCopy = GameSummary(
      id: 'game-1',
      name: 'Book of Dead',
      category: GameCategory.slots,
      provider: "Play'n GO",
      imageUrl: 'https://example.com/image.jpg',
    );

    const different = GameSummary(
      id: 'game-2',
      name: 'Starburst',
      category: GameCategory.slots,
      provider: 'NetEnt',
      imageUrl: 'https://example.com/other.jpg',
    );

    test('two GameSummaries with same fields are equal', () {
      expect(base, equals(baseCopy));
    });

    test('GameSummaries with different fields are not equal', () {
      expect(base, isNot(equals(different)));
    });

    test('isNew defaults to false', () {
      expect(base.isNew, isFalse);
    });

    test('isHot defaults to false', () {
      expect(base.isHot, isFalse);
    });

    test('isNew can be set to true', () {
      const newGame = GameSummary(
        id: 'g',
        name: 'New Game',
        category: GameCategory.slots,
        provider: 'Dev',
        imageUrl: 'url',
        isNew: true,
      );
      expect(newGame.isNew, isTrue);
    });

    test('isHot can be set to true', () {
      const hotGame = GameSummary(
        id: 'g',
        name: 'Hot Game',
        category: GameCategory.slots,
        provider: 'Dev',
        imageUrl: 'url',
        isHot: true,
      );
      expect(hotGame.isHot, isTrue);
    });

    test('hashCode is equal for two equal GameSummaries', () {
      expect(base.hashCode, equals(baseCopy.hashCode));
    });
  });
}
