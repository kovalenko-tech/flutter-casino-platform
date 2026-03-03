import 'package:get_it/get_it.dart';
import 'package:isar/isar.dart';

import 'package:flutter_casino_platform/core/constants/app_constants.dart';
import 'package:flutter_casino_platform/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:flutter_casino_platform/features/auth/data/models/user_model.dart';
import 'package:flutter_casino_platform/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:flutter_casino_platform/features/auth/domain/repositories/auth_repository.dart';
import 'package:flutter_casino_platform/features/auth/domain/usecases/login_usecase.dart';
import 'package:flutter_casino_platform/features/auth/domain/usecases/register_usecase.dart';
import 'package:flutter_casino_platform/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:flutter_casino_platform/features/home/presentation/bloc/home_bloc.dart';
import 'package:flutter_casino_platform/features/games/presentation/bloc/game_detail_bloc.dart';
import 'package:flutter_casino_platform/features/profile/presentation/bloc/profile_bloc.dart';

final GetIt sl = GetIt.instance;

/// Bootstraps all service locator registrations.
///
/// Must be called once — after Isar is opened — before [runApp].
Future<void> initDependencies() async {
  // ── Isar ──────────────────────────────────────────────────────────────────
  final isar = await Isar.open(
    [UserModelSchema],
    name: AppConstants.isarDbName,
  );
  sl.registerSingleton<Isar>(isar);

  // ── Data sources ──────────────────────────────────────────────────────────
  sl.registerLazySingleton<AuthLocalDatasource>(
    () => AuthLocalDatasourceImpl(sl<Isar>()),
  );

  // ── Repositories ──────────────────────────────────────────────────────────
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(sl<AuthLocalDatasource>()),
  );

  // ── Use cases ─────────────────────────────────────────────────────────────
  sl.registerLazySingleton(() => LoginUseCase(sl<AuthRepository>()));
  sl.registerLazySingleton(() => RegisterUseCase(sl<AuthRepository>()));

  // ── BLoCs (factories — one instance per page push) ─────────────────────
  sl.registerFactory(() => AuthBloc(
        loginUseCase: sl<LoginUseCase>(),
        registerUseCase: sl<RegisterUseCase>(),
        authRepository: sl<AuthRepository>(),
      ));
  sl.registerFactory(() => HomeBloc());
  sl.registerFactory(() => GameDetailBloc());
  sl.registerFactory(() => ProfileBloc(authRepository: sl<AuthRepository>()));
}
