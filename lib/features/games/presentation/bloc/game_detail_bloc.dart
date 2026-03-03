import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_casino_platform/core/mock/mock_games.dart';
import 'package:flutter_casino_platform/features/games/domain/entities/game_detail.dart';

part 'game_detail_event.dart';
part 'game_detail_state.dart';

/// Loads the full [GameDetail] for the game detail screen.
///
/// Data is resolved from the in-memory mock catalogue; in production
/// this would call a repository method backed by a remote API + local cache.
class GameDetailBloc extends Bloc<GameDetailEvent, GameDetailState> {
  GameDetailBloc() : super(GameDetailLoading()) {
    on<LoadGameDetail>(_onLoad);
  }

  Future<void> _onLoad(
    LoadGameDetail event,
    Emitter<GameDetailState> emit,
  ) async {
    emit(GameDetailLoading());
    try {
      // Tiny delay to make the shimmer visible during development.
      await Future.delayed(const Duration(milliseconds: 200));
      final game = MockGames.findById(event.id);
      emit(GameDetailLoaded(game));
    } catch (e) {
      emit(GameDetailError(e.toString()));
    }
  }
}
