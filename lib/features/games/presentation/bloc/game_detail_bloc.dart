import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_casino_platform/features/games/domain/entities/game_detail.dart';
import 'package:flutter_casino_platform/features/games/domain/usecases/get_game_detail_usecase.dart';

part 'game_detail_event.dart';
part 'game_detail_state.dart';

/// Loads the full [GameDetail] for the game detail screen.
///
/// Delegates data access to [GetGameDetailUseCase] — the BLoC has no
/// knowledge of where data comes from (mock, cache, or remote API).
class GameDetailBloc extends Bloc<GameDetailEvent, GameDetailState> {
  final GetGameDetailUseCase _getGameDetail;

  GameDetailBloc({required GetGameDetailUseCase getGameDetail})
      : _getGameDetail = getGameDetail,
        super(const GameDetailLoading()) {
    on<LoadGameDetail>(_onLoad);
  }

  Future<void> _onLoad(
    LoadGameDetail event,
    Emitter<GameDetailState> emit,
  ) async {
    emit(const GameDetailLoading());

    final result = await _getGameDetail(event.id);

    result.fold(
      (failure) => emit(GameDetailError(failure.message)),
      (game) => emit(GameDetailLoaded(game)),
    );
  }
}
