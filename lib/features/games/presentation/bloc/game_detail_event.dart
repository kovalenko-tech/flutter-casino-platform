part of 'game_detail_bloc.dart';

sealed class GameDetailEvent extends Equatable {
  const GameDetailEvent();

  @override
  List<Object?> get props => [];
}

class LoadGameDetail extends GameDetailEvent {
  final String id;

  const LoadGameDetail(this.id);

  @override
  List<Object?> get props => [id];
}
