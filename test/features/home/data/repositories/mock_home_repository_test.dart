import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_casino_platform/features/home/data/repositories/mock_home_repository.dart';
import 'package:flutter_casino_platform/features/home/domain/entities/game_category.dart';
import 'package:flutter_casino_platform/core/types/either.dart';

void main() {
  late MockHomeRepository repo;

  setUp(() => repo = const MockHomeRepository());

  group('MockHomeRepository', () {
    group('getBanners', () {
      test('returns right with non-empty list', () async {
        final result = await repo.getBanners();

        expect(result.isRight, isTrue);
        expect(result.rightValue, isNotEmpty);
      });

      test('returns PromoBanner objects with non-empty ids', () async {
        final result = await repo.getBanners();

        expect(result.isRight, isTrue);
        for (final banner in result.rightValue) {
          expect(banner.id, isNotEmpty);
          expect(banner.title, isNotEmpty);
        }
      });
    });

    group('getGames', () {
      test('getGames(all) returns right with more than 10 games', () async {
        final result = await repo.getGames();

        expect(result.isRight, isTrue);
        expect(result.rightValue.length, greaterThan(10));
      });

      test('getGames(all) is the default behaviour', () async {
        final resultDefault = await repo.getGames();
        final resultAll = await repo.getGames(category: GameCategory.all);

        expect(resultDefault.rightValue.length,
            equals(resultAll.rightValue.length));
      });

      test('getGames(slots) returns only slot games', () async {
        final result = await repo.getGames(category: GameCategory.slots);

        expect(result.isRight, isTrue);
        expect(result.rightValue, isNotEmpty);
        expect(
          result.rightValue.every((g) => g.category == GameCategory.slots),
          isTrue,
        );
      });

      test('getGames(live) returns only live games', () async {
        final result = await repo.getGames(category: GameCategory.live);

        expect(result.isRight, isTrue);
        expect(result.rightValue, isNotEmpty);
        expect(
          result.rightValue.every((g) => g.category == GameCategory.live),
          isTrue,
        );
      });

      test('getGames(table) returns only table games', () async {
        final result = await repo.getGames(category: GameCategory.table);

        expect(result.isRight, isTrue);
        expect(
          result.rightValue.every((g) => g.category == GameCategory.table),
          isTrue,
        );
      });

      test('getGames(jackpot) returns only jackpot games', () async {
        final result = await repo.getGames(category: GameCategory.jackpot);

        expect(result.isRight, isTrue);
        expect(
          result.rightValue.every((g) => g.category == GameCategory.jackpot),
          isTrue,
        );
      });
    });
  });
}
