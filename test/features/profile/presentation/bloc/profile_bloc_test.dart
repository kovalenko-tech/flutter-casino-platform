import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:flutter_casino_platform/core/errors/failures.dart';
import 'package:flutter_casino_platform/core/types/either.dart';
import 'package:flutter_casino_platform/features/auth/domain/entities/user.dart';
import 'package:flutter_casino_platform/features/auth/domain/repositories/auth_repository.dart';
import 'package:flutter_casino_platform/features/profile/domain/entities/profile.dart';
import 'package:flutter_casino_platform/features/profile/presentation/bloc/profile_bloc.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late MockAuthRepository mockAuthRepository;

  final memberSince = DateTime(2024, 1, 15);

  final testUser = User(
    uid: 'uid-1',
    name: 'Alice Smith',
    email: 'alice@example.com',
    memberSince: memberSince,
    accountId: 'ACC-00001',
  );

  final testProfile = Profile.fromUser(testUser);

  setUp(() {
    mockAuthRepository = MockAuthRepository();
  });

  ProfileBloc buildBloc() =>
      ProfileBloc(authRepository: mockAuthRepository);

  group('ProfileBloc', () {
    test('initial state is ProfileLoading', () {
      final bloc = buildBloc();
      expect(bloc.state, isA<ProfileLoading>());
      bloc.close();
    });

    group('LoadProfile', () {
      blocTest<ProfileBloc, ProfileState>(
        'emits [ProfileLoading, ProfileLoaded] when user is found',
        build: () {
          when(() => mockAuthRepository.getCurrentUser())
              .thenAnswer((_) async => right(testUser));
          return buildBloc();
        },
        act: (bloc) => bloc.add(const LoadProfile()),
        expect: () => [
          isA<ProfileLoading>(),
          ProfileLoaded(testProfile),
        ],
      );

      blocTest<ProfileBloc, ProfileState>(
        'ProfileLoaded contains profile with correct name',
        build: () {
          when(() => mockAuthRepository.getCurrentUser())
              .thenAnswer((_) async => right(testUser));
          return buildBloc();
        },
        act: (bloc) => bloc.add(const LoadProfile()),
        expect: () => [
          isA<ProfileLoading>(),
          isA<ProfileLoaded>().having(
            (s) => s.profile.name,
            'profile.name',
            equals('Alice Smith'),
          ),
        ],
      );

      blocTest<ProfileBloc, ProfileState>(
        'emits [ProfileLoading, ProfileError] when user is null',
        build: () {
          when(() => mockAuthRepository.getCurrentUser())
              .thenAnswer((_) async => right(null));
          return buildBloc();
        },
        act: (bloc) => bloc.add(const LoadProfile()),
        expect: () => [
          isA<ProfileLoading>(),
          isA<ProfileError>(),
        ],
      );

      blocTest<ProfileBloc, ProfileState>(
        'emits [ProfileLoading, ProfileError] on StorageFailure',
        build: () {
          when(() => mockAuthRepository.getCurrentUser()).thenAnswer(
            (_) async => left(const StorageFailure('db error')),
          );
          return buildBloc();
        },
        act: (bloc) => bloc.add(const LoadProfile()),
        expect: () => [
          isA<ProfileLoading>(),
          isA<ProfileError>(),
        ],
      );
    });

    group('LogoutRequested', () {
      blocTest<ProfileBloc, ProfileState>(
        'emits [ProfileLoading, ProfileLoggedOut] after logout',
        build: () {
          when(() => mockAuthRepository.deleteAll())
              .thenAnswer((_) async => right(null));
          return buildBloc();
        },
        act: (bloc) => bloc.add(const LogoutRequested()),
        expect: () => [
          isA<ProfileLoading>(),
          isA<ProfileLoggedOut>(),
        ],
      );

      blocTest<ProfileBloc, ProfileState>(
        'calls repository.deleteAll() on logout',
        build: () {
          when(() => mockAuthRepository.deleteAll())
              .thenAnswer((_) async => right(null));
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
