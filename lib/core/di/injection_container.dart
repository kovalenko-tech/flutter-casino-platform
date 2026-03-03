import 'package:get_it/get_it.dart';
import 'package:isar/isar.dart';

import '../constants/app_constants.dart';
import '../../features/auth/data/datasources/auth_local_datasource.dart';
import '../../features/auth/data/models/user_model.dart';
import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/auth/domain/usecases/login_usecase.dart';
import '../../features/auth/domain/usecases/register_usecase.dart';
import '../../features/auth/presentation/bloc/auth_bloc.dart';
import '../../features/home/presentation/bloc/home_bloc.dart';
import '../../features/games/presentation/bloc/game_detail_bloc.dart';
import '../../features/profile/presentation/bloc/profile_bloc.dart';

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
