part of 'home_bloc.dart';

sealed class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object?> get props => [];
}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final List<PromoBanner> banners;
  final List<GameSummary> games;
  final GameCategory selectedCategory;

  const HomeLoaded({
    required this.banners,
    required this.games,
    required this.selectedCategory,
  });

  @override
  List<Object?> get props => [banners, games, selectedCategory];
}

class HomeError extends HomeState {
  final String message;

  const HomeError(this.message);

  @override
  List<Object?> get props => [message];
}
