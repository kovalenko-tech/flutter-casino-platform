import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';

import 'package:flutter_casino_platform/core/di/injection_container.dart';
import 'package:flutter_casino_platform/core/l10n/app_localizations.dart';
import 'package:flutter_casino_platform/core/theme/app_theme.dart';
import 'package:flutter_casino_platform/features/games/domain/entities/game_detail.dart';
import 'package:flutter_casino_platform/features/games/presentation/bloc/game_detail_bloc.dart';
import 'package:flutter_casino_platform/features/games/presentation/screens/game_detail_screen.dart';
import 'package:flutter_casino_platform/features/home/domain/entities/game_category.dart';

class MockGameDetailBloc extends MockBloc<GameDetailEvent, GameDetailState>
    implements GameDetailBloc {}

const _testGame = GameDetail(
  id: 'book-of-dead',
  name: 'Book of Dead',
  category: GameCategory.slots,
  provider: "Play'n GO",
  description: 'An iconic slot set in ancient Egypt.',
  rtp: 96.21,
  volatility: Volatility.high,
  imageUrl: 'https://picsum.photos/seed/bookdead/400/300',
);

Widget _buildTestApp({required String gameId}) {
  final router = GoRouter(
    initialLocation: '/games/$gameId',
    routes: [
      GoRoute(
        path: '/games/:id',
        builder:
            (context, state) =>
                GameDetailScreen(gameId: state.pathParameters['id'] ?? gameId),
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
  late MockGameDetailBloc mockBloc;

  setUp(() {
    mockBloc = MockGameDetailBloc();
    when(() => mockBloc.state).thenReturn(const GameDetailLoading());

    if (sl.isRegistered<GameDetailBloc>()) {
      sl.unregister<GameDetailBloc>();
    }
    sl.registerFactory<GameDetailBloc>(() => mockBloc);
  });

  tearDown(() {
    if (sl.isRegistered<GameDetailBloc>()) {
      sl.unregister<GameDetailBloc>();
    }
  });

  group('GameDetailScreen', () {
    testWidgets('shows loading state with CustomScrollView', (tester) async {
      when(() => mockBloc.state).thenReturn(const GameDetailLoading());
      whenListen(
        mockBloc,
        Stream.value(const GameDetailLoading()),
        initialState: const GameDetailLoading(),
      );

      await tester.pumpWidget(_buildTestApp(gameId: 'book-of-dead'));
      await tester.pump();

      expect(find.byType(CustomScrollView), findsOneWidget);
    });

    testWidgets('shows game name in loaded state', (tester) async {
      const loadedState = GameDetailLoaded(_testGame);
      when(() => mockBloc.state).thenReturn(loadedState);
      whenListen(
        mockBloc,
        Stream.value(loadedState),
        initialState: loadedState,
      );

      await tester.pumpWidget(_buildTestApp(gameId: 'book-of-dead'));
      await tester.pump();

      expect(find.text('Book of Dead'), findsOneWidget);
    });

    testWidgets('shows provider name in loaded state', (tester) async {
      const loadedState = GameDetailLoaded(_testGame);
      when(() => mockBloc.state).thenReturn(loadedState);
      whenListen(
        mockBloc,
        Stream.value(loadedState),
        initialState: loadedState,
      );

      await tester.pumpWidget(_buildTestApp(gameId: 'book-of-dead'));
      await tester.pump();

      expect(find.text("Play'n GO"), findsOneWidget);
    });

    testWidgets('shows error message in error state', (tester) async {
      const errorState = GameDetailError('Game not found: bad-id');
      when(() => mockBloc.state).thenReturn(errorState);
      whenListen(mockBloc, Stream.value(errorState), initialState: errorState);

      await tester.pumpWidget(_buildTestApp(gameId: 'bad-id'));
      await tester.pump();

      expect(find.text('Game not found: bad-id'), findsOneWidget);
    });

    testWidgets('shows RTP value in loaded state', (tester) async {
      const loadedState = GameDetailLoaded(_testGame);
      when(() => mockBloc.state).thenReturn(loadedState);
      whenListen(
        mockBloc,
        Stream.value(loadedState),
        initialState: loadedState,
      );

      await tester.pumpWidget(_buildTestApp(gameId: 'book-of-dead'));
      await tester.pump();

      expect(find.text('${_testGame.rtp}%'), findsOneWidget);
    });
  });
}
