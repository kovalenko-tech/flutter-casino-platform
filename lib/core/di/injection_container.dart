import 'package:get_it/get_it.dart';
import 'package:path/path.dart' as path_pkg;
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import 'package:flutter_casino_platform/core/constants/app_constants.dart';
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

/// Bootstraps all service locator registrations.
///
/// Call once — before [runApp].
/// To switch from mock to real data: change the registered implementation
/// for [HomeRepository] or [GamesRepository] — BLoCs require zero changes.
Future<void> initDependencies() async {
  // ── SQLite ─────────────────────────────────────────────────────────────────
  final appDir = await getApplicationDocumentsDirectory();
  final dbPath = path_pkg.join(appDir.path, AppConstants.dbFileName);

  final db = await openDatabase(
    dbPath,
    version: 1,
    onCreate: AuthLocalDatasourceImpl.onCreate,
  );
  sl.registerSingleton<Database>(db);

  // ── Auth: data sources ─────────────────────────────────────────────────────
  sl.registerLazySingleton<AuthLocalDatasource>(
    () => AuthLocalDatasourceImpl(sl<Database>()),
  );

  // ── Auth: repository ───────────────────────────────────────────────────────
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(sl<AuthLocalDatasource>()),
  );

  // ── Auth: use cases ────────────────────────────────────────────────────────
  sl.registerLazySingleton(() => LoginUseCase(sl<AuthRepository>()));
  sl.registerLazySingleton(() => RegisterUseCase(sl<AuthRepository>()));

  // ── Home: repository (mock → swap to RealHomeRepository when ready) ────────
  sl.registerLazySingleton<HomeRepository>(
    () => const MockHomeRepository(),
  );

  // ── Home: use cases ────────────────────────────────────────────────────────
  sl.registerLazySingleton(() => GetBannersUseCase(sl<HomeRepository>()));
  sl.registerLazySingleton(() => GetGamesUseCase(sl<HomeRepository>()));

  // ── Games: repository (mock → swap to RealGamesRepository when ready) ──────
  sl.registerLazySingleton<GamesRepository>(
    () => const MockGamesRepository(),
  );

  // ── Games: use cases ───────────────────────────────────────────────────────
  sl.registerLazySingleton(
    () => GetGameDetailUseCase(sl<GamesRepository>()),
  );

  // ── BLoCs (factories — fresh instance per page push) ──────────────────────
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
