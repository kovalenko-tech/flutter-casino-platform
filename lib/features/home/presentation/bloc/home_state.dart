part of 'home_bloc.dart';

sealed class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object?> get props => [];
}

class HomeLoading extends HomeState {
  const HomeLoading();
}

class HomeLoaded extends HomeState {
  final List<PromoBanner> banners;

  /// The currently displayed list — may be filtered.
  final List<GameSummary> games;

  /// Full unfiltered catalogue — kept for client-side filtering without
  /// re-fetching from the repository on every category switch.
  final List<GameSummary> allGames;

  final GameCategory selectedCategory;

  const HomeLoaded({
    required this.banners,
    required this.games,
    required this.allGames,
    required this.selectedCategory,
  });

  HomeLoaded copyWith({
    List<PromoBanner>? banners,
    List<GameSummary>? games,
    List<GameSummary>? allGames,
    GameCategory? selectedCategory,
  }) {
    return HomeLoaded(
      banners: banners ?? this.banners,
      games: games ?? this.games,
      allGames: allGames ?? this.allGames,
      selectedCategory: selectedCategory ?? this.selectedCategory,
    );
  }

  @override
  List<Object?> get props => [banners, games, allGames, selectedCategory];
}

class HomeError extends HomeState {
  final String message;

  const HomeError(this.message);

  @override
  List<Object?> get props => [message];
}
