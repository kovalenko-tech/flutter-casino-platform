import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:flutter_casino_platform/core/errors/failures.dart';
import 'package:flutter_casino_platform/core/types/either.dart';
import 'package:flutter_casino_platform/features/home/domain/entities/game_category.dart';
import 'package:flutter_casino_platform/features/home/domain/entities/game_summary.dart';
import 'package:flutter_casino_platform/features/home/domain/repositories/home_repository.dart';
import 'package:flutter_casino_platform/features/home/domain/usecases/get_games_usecase.dart';

class MockHomeRepository extends Mock implements HomeRepository {}

void main() {
  late MockHomeRepository mockRepo;
  late GetGamesUseCase useCase;

  const allGames = [
    GameSummary(
      id: 'g1',
      name: 'Book of Dead',
      category: GameCategory.slots,
      provider: "Play'n GO",
      imageUrl: 'url1',
    ),
    GameSummary(
      id: 'g2',
      name: 'Lightning Roulette',
      category: GameCategory.live,
      provider: 'Evolution',
      imageUrl: 'url2',
    ),
  ];

  const slotGames = [
    GameSummary(
      id: 'g1',
      name: 'Book of Dead',
      category: GameCategory.slots,
      provider: "Play'n GO",
      imageUrl: 'url1',
    ),
  ];

  setUpAll(() {
    registerFallbackValue(GameCategory.all);
  });

  setUp(() {
    mockRepo = MockHomeRepository();
    useCase = GetGamesUseCase(mockRepo);
  });

  group('GetGamesUseCase', () {
    test('returns all games when called with default category (all)', () async {
      when(
        () => mockRepo.getGames(category: GameCategory.all),
      ).thenAnswer((_) async => right(allGames));

      final result = await useCase();

      expect(result.isRight, isTrue);
      expect(result.rightValue, equals(allGames));
    });

    test(
      'passes slots category to repository and returns filtered games',
      () async {
        when(
          () => mockRepo.getGames(category: GameCategory.slots),
        ).thenAnswer((_) async => right(slotGames));

        final result = await useCase(category: GameCategory.slots);

        expect(result.isRight, isTrue);
        expect(result.rightValue, equals(slotGames));
        verify(() => mockRepo.getGames(category: GameCategory.slots)).called(1);
      },
    );

    test('passes live category to repository', () async {
      when(
        () => mockRepo.getGames(category: GameCategory.live),
      ).thenAnswer((_) async => right(const []));

      await useCase(category: GameCategory.live);

      verify(() => mockRepo.getGames(category: GameCategory.live)).called(1);
    });

    test('propagates StorageFailure from repository', () async {
      when(
        () => mockRepo.getGames(category: any(named: 'category')),
      ).thenAnswer((_) async => left(const StorageFailure('read error')));

      final result = await useCase();

      expect(result.isLeft, isTrue);
      expect(result.leftValue, isA<StorageFailure>());
    });

    test('delegates exactly one call to repository', () async {
      when(
        () => mockRepo.getGames(category: GameCategory.all),
      ).thenAnswer((_) async => right(allGames));

      await useCase();

      verify(() => mockRepo.getGames(category: GameCategory.all)).called(1);
      verifyNoMoreInteractions(mockRepo);
    });
  });
}
