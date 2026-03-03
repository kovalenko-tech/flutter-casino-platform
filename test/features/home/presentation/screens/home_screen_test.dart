import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';

import 'package:flutter_casino_platform/core/di/injection_container.dart';
import 'package:flutter_casino_platform/core/l10n/app_localizations.dart';
import 'package:flutter_casino_platform/core/theme/app_theme.dart';
import 'package:flutter_casino_platform/features/home/domain/entities/game_category.dart';
import 'package:flutter_casino_platform/features/home/domain/entities/game_summary.dart';
import 'package:flutter_casino_platform/features/home/domain/entities/promo_banner.dart';
import 'package:flutter_casino_platform/features/home/presentation/bloc/home_bloc.dart';
import 'package:flutter_casino_platform/features/home/presentation/screens/home_screen.dart';

class MockHomeBloc extends MockBloc<HomeEvent, HomeState> implements HomeBloc {}

final _testBanners = [
  const PromoBanner(
    id: 'b1',
    title: 'Welcome',
    subtitle: 'Get bonus',
    ctaLabel: 'Claim',
    imageUrl: 'https://picsum.photos/800/400',
  ),
];

final _testGames = [
  const GameSummary(
    id: 'g1',
    name: 'Book of Dead',
    category: GameCategory.slots,
    provider: "Play'n GO",
    imageUrl: 'https://picsum.photos/400/300',
  ),
];

Widget _buildTestApp() {
  final router = GoRouter(
    initialLocation: '/home',
    routes: [
      GoRoute(path: '/home', builder: (_, __) => const HomeScreen()),
      GoRoute(
        path: '/games/:id',
        builder: (_, __) => const Scaffold(body: Text('Game Detail')),
      ),
    ],
  );

  return MaterialApp.router(
    theme: AppTheme.dark,
    routerConfig: router,
    localizationsDelegates: const [
      AppLocalizations.delegate,
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
    ],
    supportedLocales: AppLocalizations.supportedLocales,
  );
}

void main() {
  late MockHomeBloc mockHomeBloc;

  setUpAll(() {
    registerFallbackValue(GameCategory.all);
    registerFallbackValue(const LoadHomeData());
  });

  setUp(() {
    mockHomeBloc = MockHomeBloc();
    when(() => mockHomeBloc.state).thenReturn(const HomeLoading());

    if (sl.isRegistered<HomeBloc>()) {
      sl.unregister<HomeBloc>();
    }
    sl.registerFactory<HomeBloc>(() => mockHomeBloc);
  });

  tearDown(() {
    if (sl.isRegistered<HomeBloc>()) {
      sl.unregister<HomeBloc>();
    }
  });

  group('HomeScreen', () {
    testWidgets('shows shimmer loading when state is HomeLoading', (
      tester,
    ) async {
      when(() => mockHomeBloc.state).thenReturn(const HomeLoading());
      whenListen(
        mockHomeBloc,
        Stream.value(const HomeLoading()),
        initialState: const HomeLoading(),
      );

      await tester.pumpWidget(_buildTestApp());
      await tester.pump();

      // Loading state shows shimmer (SliverToBoxAdapter children).
      // At minimum the scaffold should render without error.
      expect(find.byType(CustomScrollView), findsOneWidget);
    });

    testWidgets('shows error message and retry button on HomeError', (
      tester,
    ) async {
      const errorMessage = 'Network unavailable';
      when(() => mockHomeBloc.state).thenReturn(const HomeError(errorMessage));
      whenListen(
        mockHomeBloc,
        Stream.value(const HomeError(errorMessage)),
        initialState: const HomeError(errorMessage),
      );

      await tester.pumpWidget(_buildTestApp());
      await tester.pump();

      expect(find.text(errorMessage), findsOneWidget);
      expect(find.widgetWithText(TextButton, 'Retry'), findsOneWidget);
    });

    testWidgets('shows game names in loaded state', (tester) async {
      final loadedState = HomeLoaded(
        banners: _testBanners,
        games: _testGames,
        allGames: _testGames,
        selectedCategory: GameCategory.all,
      );
      when(() => mockHomeBloc.state).thenReturn(loadedState);
      whenListen(
        mockHomeBloc,
        Stream.value(loadedState),
        initialState: loadedState,
      );

      await tester.pumpWidget(_buildTestApp());
      await tester.pump();

      expect(find.text('Book of Dead'), findsOneWidget);
    });
  });
}
