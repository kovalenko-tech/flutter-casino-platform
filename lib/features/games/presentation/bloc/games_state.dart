part of 'games_cubit.dart';

class GamesState extends Equatable {
  final List<GameSummary> games;
  final String query;

  const GamesState({required this.games, this.query = ''});

  GamesState copyWith({List<GameSummary>? games, String? query}) {
    return GamesState(
      games: games ?? this.games,
      query: query ?? this.query,
    );
  }

  @override
  List<Object?> get props => [games, query];
}
