import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:flutter_casino_platform/core/errors/failures.dart';
import 'package:flutter_casino_platform/core/types/either.dart';
import 'package:flutter_casino_platform/features/home/domain/entities/game_category.dart';
import 'package:flutter_casino_platform/features/home/domain/entities/game_summary.dart';
import 'package:flutter_casino_platform/features/home/domain/entities/promo_banner.dart';
import 'package:flutter_casino_platform/features/home/domain/usecases/get_banners_usecase.dart';
import 'package:flutter_casino_platform/features/home/domain/usecases/get_games_usecase.dart';
import 'package:flutter_casino_platform/features/home/presentation/bloc/home_bloc.dart';

class MockGetBannersUseCase extends Mock implements GetBannersUseCase {}

class MockGetGamesUseCase extends Mock implements GetGamesUseCase {}

void main() {
  late MockGetBannersUseCase mockGetBanners;
  late MockGetGamesUseCase mockGetGames;

  final testBanners = [
    const PromoBanner(
      id: 'b1',
      title: 'Welcome',
      subtitle: 'Get 200% bonus',
      ctaLabel: 'Claim',
      imageUrl: 'https://example.com/banner.jpg',
    ),
  ];

  final testGames = [
    const GameSummary(
      id: 'g1',
      name: 'Book of Dead',
      category: GameCategory.slots,
      provider: "Play'n GO",
      imageUrl: 'https://example.com/bod.jpg',
    ),
    const GameSummary(
      id: 'g2',
      name: 'Lightning Roulette',
      category: GameCategory.live,
      provider: 'Evolution',
      imageUrl: 'https://example.com/roulette.jpg',
    ),
  ];

  final slotGames = [testGames.first];

  setUpAll(() {
    registerFallbackValue(GameCategory.all);
  });

  setUp(() {
    mockGetBanners = MockGetBannersUseCase();
    mockGetGames = MockGetGamesUseCase();

    when(() => mockGetBanners()).thenAnswer((_) async => right(testBanners));
    when(
      () => mockGetGames(category: any(named: 'category')),
    ).thenAnswer((_) async => right(testGames));
  });

  group('HomeBloc', () {
    test('initial state is HomeLoading', () {
      final bloc = HomeBloc(getBanners: mockGetBanners, getGames: mockGetGames);
      expect(bloc.state, equals(const HomeLoading()));
      bloc.close();
    });

    blocTest<HomeBloc, HomeState>(
      'emits [HomeLoading, HomeLoaded] when LoadHomeData succeeds',
      build: () => HomeBloc(getBanners: mockGetBanners, getGames: mockGetGames),
      act: (bloc) => bloc.add(const LoadHomeData()),
      expect:
          () => [
            const HomeLoading(),
            HomeLoaded(
              banners: testBanners,
              games: testGames,
              allGames: testGames,
              selectedCategory: GameCategory.all,
            ),
          ],
    );

    blocTest<HomeBloc, HomeState>(
      'emits [HomeLoading, HomeError] when getBanners fails',
      build: () {
        when(() => mockGetBanners()).thenAnswer(
          (_) async => left(const StorageFailure('banner read failed')),
        );
        return HomeBloc(getBanners: mockGetBanners, getGames: mockGetGames);
      },
      act: (bloc) => bloc.add(const LoadHomeData()),
      expect: () => [const HomeLoading(), isA<HomeError>()],
    );

    blocTest<HomeBloc, HomeState>(
      'emits [HomeLoading, HomeError] when getGames fails',
      build: () {
        when(() => mockGetGames(category: any(named: 'category'))).thenAnswer(
          (_) async => left(const StorageFailure('games read failed')),
        );
        return HomeBloc(getBanners: mockGetBanners, getGames: mockGetGames);
      },
      act: (bloc) => bloc.add(const LoadHomeData()),
      expect: () => [const HomeLoading(), isA<HomeError>()],
    );

    blocTest<HomeBloc, HomeState>(
      'HomeError contains message from failure',
      build: () {
        when(
          () => mockGetBanners(),
        ).thenAnswer((_) async => left(const StorageFailure('db unavailable')));
        return HomeBloc(getBanners: mockGetBanners, getGames: mockGetGames);
      },
      act: (bloc) => bloc.add(const LoadHomeData()),
      expect:
          () => [
            const HomeLoading(),
            isA<HomeError>().having(
              (s) => s.message,
              'message',
              equals('db unavailable'),
            ),
          ],
    );

    blocTest<HomeBloc, HomeState>(
      'FilterByCategory calls getGames with new category and updates state',
      build: () {
        when(
          () => mockGetGames(category: GameCategory.slots),
        ).thenAnswer((_) async => right(slotGames));
        return HomeBloc(getBanners: mockGetBanners, getGames: mockGetGames);
      },
      seed:
          () => HomeLoaded(
            banners: testBanners,
            games: testGames,
            allGames: testGames,
            selectedCategory: GameCategory.all,
          ),
      act: (bloc) => bloc.add(const FilterByCategory(GameCategory.slots)),
      expect:
          () => [
            isA<HomeLoaded>().having(
              (s) => s.selectedCategory,
              'selectedCategory',
              GameCategory.slots,
            ),
          ],
    );

    blocTest<HomeBloc, HomeState>(
      'FilterByCategory(all) restores full game list without re-fetching',
      build: () => HomeBloc(getBanners: mockGetBanners, getGames: mockGetGames),
      seed:
          () => HomeLoaded(
            banners: testBanners,
            games: slotGames,
            allGames: testGames,
            selectedCategory: GameCategory.slots,
          ),
      act: (bloc) => bloc.add(const FilterByCategory(GameCategory.all)),
      expect:
          () => [
            isA<HomeLoaded>()
                .having(
                  (s) => s.selectedCategory,
                  'selectedCategory',
                  GameCategory.all,
                )
                .having(
                  (s) => s.games.length,
                  'games count',
                  equals(testGames.length),
                ),
          ],
    );

    blocTest<HomeBloc, HomeState>(
      'FilterByCategory does nothing when state is not HomeLoaded',
      build: () => HomeBloc(getBanners: mockGetBanners, getGames: mockGetGames),
      // Default seed is HomeLoading
      act: (bloc) => bloc.add(const FilterByCategory(GameCategory.slots)),
      expect: () => [],
    );
  });
}
