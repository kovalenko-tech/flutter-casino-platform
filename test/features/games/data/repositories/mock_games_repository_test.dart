import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_casino_platform/core/errors/failures.dart';
import 'package:flutter_casino_platform/features/games/data/repositories/mock_games_repository.dart';

void main() {
  late MockGamesRepository repo;

  setUp(() => repo = const MockGamesRepository());

  group('MockGamesRepository', () {
    group('getAllGames', () {
      test('returns right with non-empty list of games', () async {
        final result = await repo.getAllGames();

        expect(result.isRight, isTrue);
        expect(result.rightValue, isNotEmpty);
      });

      test('all returned games have non-empty ids and names', () async {
        final result = await repo.getAllGames();

        expect(result.isRight, isTrue);
        for (final game in result.rightValue) {
          expect(game.id, isNotEmpty);
          expect(game.name, isNotEmpty);
        }
      });
    });

    group('getGameById', () {
      test('returns correct game for known id "book-of-dead"', () async {
        final result = await repo.getGameById('book-of-dead');

        expect(result.isRight, isTrue);
        expect(result.rightValue.id, equals('book-of-dead'));
        expect(result.rightValue.name, equals('Book of Dead'));
      });

      test('returns NotFoundFailure for unknown id', () async {
        final result = await repo.getGameById('non-existent-game');

        expect(result.isLeft, isTrue);
        expect(result.leftValue, isA<NotFoundFailure>());
      });

      test('NotFoundFailure message contains the missing id', () async {
        const missingId = 'totally-fake-game';
        final result = await repo.getGameById(missingId);

        expect(result.isLeft, isTrue);
        expect(result.leftValue.message, contains(missingId));
      });

      test('returns a different game for another known id', () async {
        final allResult = await repo.getAllGames();
        expect(allResult.isRight, isTrue);

        final firstId = allResult.rightValue.first.id;
        final detailResult = await repo.getGameById(firstId);

        expect(detailResult.isRight, isTrue);
        expect(detailResult.rightValue.id, equals(firstId));
      });
    });
  });
}
