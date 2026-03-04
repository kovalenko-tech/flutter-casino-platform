import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_casino_platform/core/mock/mock_games.dart';
import 'package:flutter_casino_platform/features/home/domain/entities/game_summary.dart';

part 'games_state.dart';

/// Manages the games catalogue filtering by search query.
class GamesCubit extends Cubit<GamesState> {
  GamesCubit() : super(GamesState(games: MockGames.summaries));

  void search(String query) {
    if (query.isEmpty) {
      emit(GamesState(games: MockGames.summaries));
      return;
    }
    final q = query.toLowerCase();
    final filtered = MockGames.summaries
        .where(
          (g) =>
              g.name.toLowerCase().contains(q) ||
              g.provider.toLowerCase().contains(q),
        )
        .toList();
    emit(GamesState(games: filtered, query: query));
  }
}
