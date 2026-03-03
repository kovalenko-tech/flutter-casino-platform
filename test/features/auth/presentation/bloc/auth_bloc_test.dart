import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:flutter_casino_platform/core/errors/failures.dart';
import 'package:flutter_casino_platform/core/types/either.dart';
import 'package:flutter_casino_platform/features/auth/domain/entities/user.dart';
import 'package:flutter_casino_platform/features/auth/domain/repositories/auth_repository.dart';
import 'package:flutter_casino_platform/features/auth/domain/usecases/login_usecase.dart';
import 'package:flutter_casino_platform/features/auth/domain/usecases/register_usecase.dart';
import 'package:flutter_casino_platform/features/auth/presentation/bloc/auth_bloc.dart';

class MockLoginUseCase extends Mock implements LoginUseCase {}

class MockRegisterUseCase extends Mock implements RegisterUseCase {}

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late MockLoginUseCase mockLoginUseCase;
  late MockRegisterUseCase mockRegisterUseCase;
  late MockAuthRepository mockAuthRepository;

  final testUser = User(
    uid: 'uid-1',
    name: 'Alice',
    email: 'alice@example.com',
    memberSince: DateTime(2024, 1, 1),
    accountId: 'ACC-00001',
  );

  setUpAll(() {
    registerFallbackValue(
      User(
        uid: '',
        name: '',
        email: '',
        memberSince: DateTime(2020),
        accountId: '',
      ),
    );
  });

  setUp(() {
    mockLoginUseCase = MockLoginUseCase();
    mockRegisterUseCase = MockRegisterUseCase();
    mockAuthRepository = MockAuthRepository();
  });

  AuthBloc buildBloc() => AuthBloc(
        loginUseCase: mockLoginUseCase,
        registerUseCase: mockRegisterUseCase,
        authRepository: mockAuthRepository,
      );

  group('AuthBloc', () {
    test('initial state is AuthInitial', () {
      expect(buildBloc().state, isA<AuthInitial>());
    });

    group('CheckAuthRequested', () {
      blocTest<AuthBloc, AuthState>(
        'emits [AuthLoading, Authenticated] when user session exists',
        build: () {
          when(
            () => mockAuthRepository.getCurrentUser(),
          ).thenAnswer((_) async => right(testUser));
          return buildBloc();
        },
        act: (bloc) => bloc.add(const CheckAuthRequested()),
        expect: () => [isA<AuthLoading>(), Authenticated(testUser)],
      );

      blocTest<AuthBloc, AuthState>(
        'emits [AuthLoading, Unauthenticated] when no session exists',
        build: () {
          when(
            () => mockAuthRepository.getCurrentUser(),
          ).thenAnswer((_) async => right(null));
          return buildBloc();
        },
        act: (bloc) => bloc.add(const CheckAuthRequested()),
        expect: () => [isA<AuthLoading>(), isA<Unauthenticated>()],
      );
    });

    group('LoginRequested', () {
      blocTest<AuthBloc, AuthState>(
        'emits [AuthLoading, Authenticated] on successful login',
        build: () {
          when(
            () => mockLoginUseCase(
              email: 'alice@example.com',
              password: 'secret',
            ),
          ).thenAnswer((_) async => right(testUser));
          return buildBloc();
        },
        act: (bloc) => bloc.add(
          const LoginRequested(
            email: 'alice@example.com',
            password: 'secret',
          ),
        ),
        expect: () => [isA<AuthLoading>(), Authenticated(testUser)],
      );

      blocTest<AuthBloc, AuthState>(
        'emits [AuthLoading, AuthError] on wrong credentials',
        build: () {
          when(
            () => mockLoginUseCase(
              email: any(named: 'email'),
              password: any(named: 'password'),
            ),
          ).thenAnswer(
            (_) async => left(const AuthFailure('Invalid email or password.')),
          );
          return buildBloc();
        },
        act: (bloc) => bloc.add(
          const LoginRequested(
            email: 'wrong@example.com',
            password: 'badpass',
          ),
        ),
        expect: () => [
          isA<AuthLoading>(),
          isA<AuthError>().having(
            (s) => s.message,
            'message',
            equals('Invalid email or password.'),
          ),
        ],
      );
    });

    group('RegisterRequested', () {
      blocTest<AuthBloc, AuthState>(
        'emits [AuthLoading, Authenticated] on successful registration',
        build: () {
          when(
            () => mockRegisterUseCase(
              name: any(named: 'name'),
              email: any(named: 'email'),
              password: any(named: 'password'),
            ),
          ).thenAnswer((_) async => right(testUser));
          return buildBloc();
        },
        act: (bloc) => bloc.add(
          const RegisterRequested(
            name: 'Alice',
            email: 'alice@example.com',
            password: 'securePass1',
          ),
        ),
        expect: () => [isA<AuthLoading>(), Authenticated(testUser)],
      );

      blocTest<AuthBloc, AuthState>(
        'emits [AuthLoading, AuthError] when email is already taken',
        build: () {
          when(
            () => mockRegisterUseCase(
              name: any(named: 'name'),
              email: any(named: 'email'),
              password: any(named: 'password'),
            ),
          ).thenAnswer(
            (_) async => left(
              const AuthFailure('An account with that email already exists.'),
            ),
          );
          return buildBloc();
        },
        act: (bloc) => bloc.add(
          const RegisterRequested(
            name: 'Dup',
            email: 'dup@example.com',
            password: 'pass123',
          ),
        ),
        expect: () => [
          isA<AuthLoading>(),
          isA<AuthError>().having(
            (s) => s.message,
            'message',
            contains('already exists'),
          ),
        ],
      );
    });

    group('LogoutRequested', () {
      blocTest<AuthBloc, AuthState>(
        'emits [AuthLoading, Unauthenticated] after logout',
        build: () {
          when(
            () => mockAuthRepository.deleteAll(),
          ).thenAnswer((_) async => right(null));
          return buildBloc();
        },
        act: (bloc) => bloc.add(const LogoutRequested()),
        expect: () => [isA<AuthLoading>(), isA<Unauthenticated>()],
      );

      blocTest<AuthBloc, AuthState>(
        'calls repository.deleteAll() on logout',
        build: () {
          when(
            () => mockAuthRepository.deleteAll(),
          ).thenAnswer((_) async => right(null));
          return buildBloc();
        },
        act: (bloc) => bloc.add(const LogoutRequested()),
        verify: (_) {
          verify(() => mockAuthRepository.deleteAll()).called(1);
        },
      );
    });
  });
}
