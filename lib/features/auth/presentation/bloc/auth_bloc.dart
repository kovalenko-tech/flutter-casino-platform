import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/register_usecase.dart';

part 'auth_event.dart';
part 'auth_state.dart';

/// Manages the authentication state machine.
///
/// State flow:
///   AuthInitial → AuthLoading → Authenticated | Unauthenticated | AuthError
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase _loginUseCase;
  final RegisterUseCase _registerUseCase;
  final AuthRepository _authRepository;

  AuthBloc({
    required LoginUseCase loginUseCase,
    required RegisterUseCase registerUseCase,
    required AuthRepository authRepository,
  })  : _loginUseCase = loginUseCase,
        _registerUseCase = registerUseCase,
        _authRepository = authRepository,
        super(AuthInitial()) {
    on<CheckAuthRequested>(_onCheckAuth);
    on<LoginRequested>(_onLogin);
    on<RegisterRequested>(_onRegister);
    on<LogoutRequested>(_onLogout);
  }

  Future<void> _onCheckAuth(
    CheckAuthRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    final result = await _authRepository.getCurrentUser();
    if (result.isRight && result.rightValue != null) {
      emit(Authenticated(result.rightValue!));
    } else {
      emit(Unauthenticated());
    }
  }

  Future<void> _onLogin(
    LoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    final result = await _loginUseCase(
      email: event.email,
      password: event.password,
    );
    if (result.isRight) {
      emit(Authenticated(result.rightValue));
    } else {
      emit(AuthError(result.leftValue.message));
    }
  }

  Future<void> _onRegister(
    RegisterRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    final result = await _registerUseCase(
      name: event.name,
      email: event.email,
      password: event.password,
    );
    if (result.isRight) {
      emit(Authenticated(result.rightValue));
    } else {
      emit(AuthError(result.leftValue.message));
    }
  }

  Future<void> _onLogout(
    LogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    await _authRepository.deleteAll();
    emit(Unauthenticated());
  }
}
