import 'package:get_it/get_it.dart';

import 'package:flutter_casino_platform/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:flutter_casino_platform/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:flutter_casino_platform/features/auth/domain/repositories/auth_repository.dart';
import 'package:flutter_casino_platform/features/auth/domain/usecases/login_usecase.dart';
import 'package:flutter_casino_platform/features/auth/domain/usecases/register_usecase.dart';
import 'package:flutter_casino_platform/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:flutter_casino_platform/features/games/data/repositories/mock_games_repository.dart';
import 'package:flutter_casino_platform/features/games/domain/repositories/games_repository.dart';
import 'package:flutter_casino_platform/features/games/domain/usecases/get_game_detail_usecase.dart';
import 'package:flutter_casino_platform/features/games/presentation/bloc/game_detail_bloc.dart';
import 'package:flutter_casino_platform/features/home/data/repositories/mock_home_repository.dart';
import 'package:flutter_casino_platform/features/home/domain/repositories/home_repository.dart';
import 'package:flutter_casino_platform/features/home/domain/usecases/get_banners_usecase.dart';
import 'package:flutter_casino_platform/features/home/domain/usecases/get_games_usecase.dart';
import 'package:flutter_casino_platform/features/home/presentation/bloc/home_bloc.dart';
import 'package:flutter_casino_platform/features/profile/presentation/bloc/profile_bloc.dart';

final GetIt sl = GetIt.instance;

Future<void> initDependencies() async {
  // ── Auth: data sources ────────────────────────────────────────────────────
  sl.registerLazySingleton<AuthLocalDatasource>(
    () => AuthLocalDatasourceImpl(),
  );

  // ── Auth: repository ──────────────────────────────────────────────────────
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(sl<AuthLocalDatasource>()),
  );

  // ── Auth: use cases ───────────────────────────────────────────────────────
  sl.registerLazySingleton(() => LoginUseCase(sl<AuthRepository>()));
  sl.registerLazySingleton(() => RegisterUseCase(sl<AuthRepository>()));

  // ── Home: repository ──────────────────────────────────────────────────────
  sl.registerLazySingleton<HomeRepository>(
    () => const MockHomeRepository(),
  );

  // ── Home: use cases ───────────────────────────────────────────────────────
  sl.registerLazySingleton(() => GetBannersUseCase(sl<HomeRepository>()));
  sl.registerLazySingleton(() => GetGamesUseCase(sl<HomeRepository>()));

  // ── Games: repository ─────────────────────────────────────────────────────
  sl.registerLazySingleton<GamesRepository>(
    () => const MockGamesRepository(),
  );

  // ── Games: use cases ──────────────────────────────────────────────────────
  sl.registerLazySingleton(() => GetGameDetailUseCase(sl<GamesRepository>()));

  // ── BLoCs ─────────────────────────────────────────────────────────────────
  sl.registerFactory(
    () => AuthBloc(
      loginUseCase: sl<LoginUseCase>(),
      registerUseCase: sl<RegisterUseCase>(),
      authRepository: sl<AuthRepository>(),
    ),
  );

  sl.registerFactory(
    () => HomeBloc(
      getBanners: sl<GetBannersUseCase>(),
      getGames: sl<GetGamesUseCase>(),
    ),
  );

  sl.registerFactory(
    () => GameDetailBloc(getGameDetail: sl<GetGameDetailUseCase>()),
  );

  sl.registerFactory(
    () => ProfileBloc(authRepository: sl<AuthRepository>()),
  );
}
