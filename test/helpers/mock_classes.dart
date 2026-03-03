import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:flutter_casino_platform/features/auth/domain/repositories/auth_repository.dart';
import 'package:flutter_casino_platform/features/auth/domain/usecases/login_usecase.dart';
import 'package:flutter_casino_platform/features/auth/domain/usecases/register_usecase.dart';
import 'package:flutter_casino_platform/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:flutter_casino_platform/features/games/domain/repositories/games_repository.dart';
import 'package:flutter_casino_platform/features/games/domain/usecases/get_game_detail_usecase.dart';
import 'package:flutter_casino_platform/features/games/presentation/bloc/game_detail_bloc.dart';
import 'package:flutter_casino_platform/features/home/domain/repositories/home_repository.dart';
import 'package:flutter_casino_platform/features/home/domain/usecases/get_banners_usecase.dart';
import 'package:flutter_casino_platform/features/home/domain/usecases/get_games_usecase.dart';
import 'package:flutter_casino_platform/features/home/presentation/bloc/home_bloc.dart';
import 'package:flutter_casino_platform/features/profile/presentation/bloc/profile_bloc.dart';

// ── Repository mocks ─────────────────────────────────────────────────────────

/// Mock for the [AuthRepository] interface.
class MockAuthRepository extends Mock implements AuthRepository {}

/// Mock for the [HomeRepository] interface.
class MockHomeRepository extends Mock implements HomeRepository {}

/// Mock for the [GamesRepository] interface.
class MockGamesRepository extends Mock implements GamesRepository {}

// ── Use-case mocks ───────────────────────────────────────────────────────────

/// Mock for the [LoginUseCase].
class MockLoginUseCase extends Mock implements LoginUseCase {}

/// Mock for the [RegisterUseCase].
class MockRegisterUseCase extends Mock implements RegisterUseCase {}

/// Mock for the [GetBannersUseCase].
class MockGetBannersUseCase extends Mock implements GetBannersUseCase {}

/// Mock for the [GetGamesUseCase].
class MockGetGamesUseCase extends Mock implements GetGamesUseCase {}

/// Mock for the [GetGameDetailUseCase].
class MockGetGameDetailUseCase extends Mock implements GetGameDetailUseCase {}

// ── BLoC mocks ───────────────────────────────────────────────────────────────

/// Mock [AuthBloc] — use [whenListen] to control emitted states.
class MockAuthBloc extends MockBloc<AuthEvent, AuthState> implements AuthBloc {}

/// Mock [HomeBloc] — use [whenListen] to control emitted states.
class MockHomeBloc extends MockBloc<HomeEvent, HomeState> implements HomeBloc {}

/// Mock [GameDetailBloc] — use [whenListen] to control emitted states.
class MockGameDetailBloc extends MockBloc<GameDetailEvent, GameDetailState>
    implements GameDetailBloc {}

/// Mock [ProfileBloc] — use [whenListen] to control emitted states.
class MockProfileBloc extends MockBloc<ProfileEvent, ProfileState>
    implements ProfileBloc {}
