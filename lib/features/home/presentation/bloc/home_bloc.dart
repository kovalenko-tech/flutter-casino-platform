import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_casino_platform/features/home/domain/entities/game_category.dart';
import 'package:flutter_casino_platform/features/home/domain/entities/game_summary.dart';
import 'package:flutter_casino_platform/features/home/domain/entities/promo_banner.dart';
import 'package:flutter_casino_platform/features/home/domain/usecases/get_banners_usecase.dart';
import 'package:flutter_casino_platform/features/home/domain/usecases/get_games_usecase.dart';

import 'package:flutter_casino_platform/core/types/either.dart';
part 'home_event.dart';
part 'home_state.dart';

/// Manages the home screen's data lifecycle.
///
/// Delegates all data access to [GetBannersUseCase] and [GetGamesUseCase],
/// which talk to the repository interface — never to mock classes directly.
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetBannersUseCase _getBanners;
  final GetGamesUseCase _getGames;

  HomeBloc({
    required GetBannersUseCase getBanners,
    required GetGamesUseCase getGames,
  })  : _getBanners = getBanners,
        _getGames = getGames,
        super(const HomeLoading()) {
    on<LoadHomeData>(_onLoad);
    on<FilterByCategory>(_onFilter);
  }

  Future<void> _onLoad(LoadHomeData event, Emitter<HomeState> emit) async {
    emit(const HomeLoading());

    final bannersResult = await _getBanners();
    final gamesResult = await _getGames();

    if (bannersResult.isLeft) {
      emit(HomeError(bannersResult.leftValue.message));
      return;
    }
    if (gamesResult.isLeft) {
      emit(HomeError(gamesResult.leftValue.message));
      return;
    }

    emit(HomeLoaded(
      banners: bannersResult.rightValue,
      games: gamesResult.rightValue,
      allGames: gamesResult.rightValue,
      selectedCategory: GameCategory.all,
    ));
  }

  Future<void> _onFilter(FilterByCategory event, Emitter<HomeState> emit) async {
    final current = state;
    if (current is! HomeLoaded) return;

    if (event.category == GameCategory.all) {
      emit(current.copyWith(
        games: current.allGames,
        selectedCategory: GameCategory.all,
      ));
      return;
    }

    final result = await _getGames(category: event.category);
    if (result.isLeft) return;

    emit(current.copyWith(
      games: result.rightValue,
      selectedCategory: event.category,
    ));
  }
}
