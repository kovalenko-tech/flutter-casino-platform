import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:flutter_casino_platform/core/errors/failures.dart';
import 'package:flutter_casino_platform/core/types/either.dart';
import 'package:flutter_casino_platform/features/games/domain/entities/game_detail.dart';
import 'package:flutter_casino_platform/features/games/domain/repositories/games_repository.dart';
import 'package:flutter_casino_platform/features/games/domain/usecases/get_game_detail_usecase.dart';
import 'package:flutter_casino_platform/features/home/domain/entities/game_category.dart';

class MockGamesRepository extends Mock implements GamesRepository {}

void main() {
  late MockGamesRepository mockRepo;
  late GetGameDetailUseCase useCase;

  const testGame = GameDetail(
    id: 'book-of-dead',
    name: 'Book of Dead',
    category: GameCategory.slots,
    provider: "Play'n GO",
    description: 'An iconic slot game set in ancient Egypt.',
    rtp: 96.21,
    volatility: Volatility.high,
    imageUrl: 'https://example.com/bod.jpg',
    isNew: false,
    isHot: true,
  );

  setUp(() {
    mockRepo = MockGamesRepository();
    useCase = GetGameDetailUseCase(mockRepo);
  });

  group('GetGameDetailUseCase', () {
    test('returns GameDetail on success', () async {
      when(
        () => mockRepo.getGameById('book-of-dead'),
      ).thenAnswer((_) async => right(testGame));

      final result = await useCase('book-of-dead');

      expect(result.isRight, isTrue);
      expect(result.rightValue, equals(testGame));
      expect(result.rightValue.id, equals('book-of-dead'));
    });

    test('propagates NotFoundFailure for unknown id', () async {
      when(
        () => mockRepo.getGameById('bad-id'),
      ).thenAnswer((_) async => left(const NotFoundFailure('not found')));

      final result = await useCase('bad-id');

      expect(result.isLeft, isTrue);
      expect(result.leftValue, isA<NotFoundFailure>());
      expect(result.leftValue.message, equals('not found'));
    });

    test('delegates call to repository with correct id', () async {
      when(
        () => mockRepo.getGameById(any()),
      ).thenAnswer((_) async => right(testGame));

      await useCase('book-of-dead');

      verify(() => mockRepo.getGameById('book-of-dead')).called(1);
    });

    test('delegates exactly one call to repository', () async {
      when(
        () => mockRepo.getGameById(any()),
      ).thenAnswer((_) async => right(testGame));

      await useCase('book-of-dead');

      verify(() => mockRepo.getGameById('book-of-dead')).called(1);
      verifyNoMoreInteractions(mockRepo);
    });
  });
}
