part of 'home_bloc.dart';

sealed class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object?> get props => [];
}

class LoadHomeData extends HomeEvent {
  const LoadHomeData();
}

class FilterByCategory extends HomeEvent {
  final GameCategory category;

  const FilterByCategory(this.category);

  @override
  List<Object?> get props => [category];
}
