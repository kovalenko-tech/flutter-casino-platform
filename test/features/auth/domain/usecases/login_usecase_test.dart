import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:flutter_casino_platform/core/errors/failures.dart';
import 'package:flutter_casino_platform/core/types/either.dart';
import 'package:flutter_casino_platform/features/auth/domain/entities/user.dart';
import 'package:flutter_casino_platform/features/auth/domain/repositories/auth_repository.dart';
import 'package:flutter_casino_platform/features/auth/domain/usecases/login_usecase.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late MockAuthRepository mockRepo;
  late LoginUseCase useCase;

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
    mockRepo = MockAuthRepository();
    useCase = LoginUseCase(mockRepo);
  });

  group('LoginUseCase', () {
    test('returns authenticated User on success', () async {
      when(
        () => mockRepo.verifyCredentials(
          email: 'alice@example.com',
          password: 'password123',
        ),
      ).thenAnswer((_) async => right(testUser));

      final result = await useCase(
        email: 'alice@example.com',
        password: 'password123',
      );

      expect(result.isRight, isTrue);
      expect(result.rightValue, equals(testUser));
    });

    test('propagates AuthFailure on wrong credentials', () async {
      when(
        () => mockRepo.verifyCredentials(
          email: any(named: 'email'),
          password: any(named: 'password'),
        ),
      ).thenAnswer(
        (_) async => left(const AuthFailure('Invalid email or password')),
      );

      final result = await useCase(
        email: 'alice@example.com',
        password: 'wrongpassword',
      );

      expect(result.isLeft, isTrue);
      expect(result.leftValue, isA<AuthFailure>());
      expect(result.leftValue.message, equals('Invalid email or password'));
    });

    test('delegates call to repository with correct credentials', () async {
      when(
        () => mockRepo.verifyCredentials(
          email: 'alice@example.com',
          password: 'secret',
        ),
      ).thenAnswer((_) async => right(testUser));

      await useCase(email: 'alice@example.com', password: 'secret');

      verify(
        () => mockRepo.verifyCredentials(
          email: 'alice@example.com',
          password: 'secret',
        ),
      ).called(1);
    });
  });
}
