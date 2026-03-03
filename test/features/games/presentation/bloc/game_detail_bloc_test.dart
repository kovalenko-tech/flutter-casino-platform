import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:flutter_casino_platform/core/errors/failures.dart';
import 'package:flutter_casino_platform/core/types/either.dart';
import 'package:flutter_casino_platform/features/games/domain/entities/game_detail.dart';
import 'package:flutter_casino_platform/features/games/domain/usecases/get_game_detail_usecase.dart';
import 'package:flutter_casino_platform/features/games/presentation/bloc/game_detail_bloc.dart';
import 'package:flutter_casino_platform/features/home/domain/entities/game_category.dart';

class MockGetGameDetailUseCase extends Mock implements GetGameDetailUseCase {}

void main() {
  late MockGetGameDetailUseCase mockUseCase;

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
    mockUseCase = MockGetGameDetailUseCase();
  });

  group('GameDetailBloc', () {
    test('initial state is GameDetailLoading', () {
      final bloc = GameDetailBloc(getGameDetail: mockUseCase);
      expect(bloc.state, isA<GameDetailLoading>());
      bloc.close();
    });

    blocTest<GameDetailBloc, GameDetailState>(
      'emits [GameDetailLoading, GameDetailLoaded] on LoadGameDetail success',
      build: () {
        when(
          () => mockUseCase('book-of-dead'),
        ).thenAnswer((_) async => right(testGame));
        return GameDetailBloc(getGameDetail: mockUseCase);
      },
      act: (bloc) => bloc.add(const LoadGameDetail('book-of-dead')),
      expect: () => [isA<GameDetailLoading>(), GameDetailLoaded(testGame)],
    );

    blocTest<GameDetailBloc, GameDetailState>(
      'emits [GameDetailLoading, GameDetailError] on NotFoundFailure',
      build: () {
        when(() => mockUseCase('bad-id')).thenAnswer(
          (_) async => left(const NotFoundFailure('Game not found: bad-id')),
        );
        return GameDetailBloc(getGameDetail: mockUseCase);
      },
      act: (bloc) => bloc.add(const LoadGameDetail('bad-id')),
      expect: () => [isA<GameDetailLoading>(), isA<GameDetailError>()],
    );

    blocTest<GameDetailBloc, GameDetailState>(
      'GameDetailError contains failure message',
      build: () {
        when(() => mockUseCase(any())).thenAnswer(
          (_) async => left(const NotFoundFailure('Game not found: xyz')),
        );
        return GameDetailBloc(getGameDetail: mockUseCase);
      },
      act: (bloc) => bloc.add(const LoadGameDetail('xyz')),
      expect:
          () => [
            isA<GameDetailLoading>(),
            isA<GameDetailError>().having(
              (s) => s.message,
              'message',
              equals('Game not found: xyz'),
            ),
          ],
    );

    blocTest<GameDetailBloc, GameDetailState>(
      'GameDetailLoaded contains correct game',
      build: () {
        when(() => mockUseCase(any())).thenAnswer((_) async => right(testGame));
        return GameDetailBloc(getGameDetail: mockUseCase);
      },
      act: (bloc) => bloc.add(const LoadGameDetail('book-of-dead')),
      expect:
          () => [
            isA<GameDetailLoading>(),
            isA<GameDetailLoaded>().having(
              (s) => s.game,
              'game',
              equals(testGame),
            ),
          ],
    );

    blocTest<GameDetailBloc, GameDetailState>(
      'calls use case with the id from LoadGameDetail event',
      build: () {
        when(
          () => mockUseCase('specific-id'),
        ).thenAnswer((_) async => right(testGame));
        return GameDetailBloc(getGameDetail: mockUseCase);
      },
      act: (bloc) => bloc.add(const LoadGameDetail('specific-id')),
      verify: (_) {
        verify(() => mockUseCase('specific-id')).called(1);
      },
    );
  });
}
