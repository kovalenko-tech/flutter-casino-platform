import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/mock/mock_banners.dart';
import '../../../../core/mock/mock_games.dart';
import '../../domain/entities/game_category.dart';
import '../../domain/entities/game_summary.dart';

part 'home_event.dart';
part 'home_state.dart';

/// Manages the home screen's data lifecycle.
///
/// Loads the full game catalogue and banner list on startup,
/// then applies category filters client-side for instant response.
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeLoading()) {
    on<LoadHomeData>(_onLoad);
    on<FilterByCategory>(_onFilter);
  }

  Future<void> _onLoad(LoadHomeData event, Emitter<HomeState> emit) async {
    emit(HomeLoading());
    try {
      // Simulate a brief async load (would be a network call in production).
      await Future.delayed(const Duration(milliseconds: 300));
      emit(HomeLoaded(
        banners: MockBanners.all,
        games: MockGames.summaries,
        selectedCategory: GameCategory.all,
      ));
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }

  void _onFilter(FilterByCategory event, Emitter<HomeState> emit) {
    final current = state;
    if (current is! HomeLoaded) return;

    final filtered = event.category == GameCategory.all
        ? MockGames.summaries
        : MockGames.summaries
            .where((g) => g.category == event.category)
            .toList();

    emit(HomeLoaded(
      banners: current.banners,
      games: filtered,
      selectedCategory: event.category,
    ));
  }
}
