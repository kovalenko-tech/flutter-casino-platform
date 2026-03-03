part of 'game_detail_bloc.dart';

sealed class GameDetailState extends Equatable {
  const GameDetailState();

  @override
  List<Object?> get props => [];
}

class GameDetailLoading extends GameDetailState {}

class GameDetailLoaded extends GameDetailState {
  final GameDetail game;

  const GameDetailLoaded(this.game);

  @override
  List<Object?> get props => [game];
}

class GameDetailError extends GameDetailState {
  final String message;

  const GameDetailError(this.message);

  @override
  List<Object?> get props => [message];
}
