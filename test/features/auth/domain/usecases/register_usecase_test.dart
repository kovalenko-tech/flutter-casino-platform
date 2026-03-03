import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:flutter_casino_platform/core/errors/failures.dart';
import 'package:flutter_casino_platform/core/types/either.dart';
import 'package:flutter_casino_platform/features/auth/domain/entities/user.dart';
import 'package:flutter_casino_platform/features/auth/domain/repositories/auth_repository.dart';
import 'package:flutter_casino_platform/features/auth/domain/usecases/register_usecase.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late MockAuthRepository mockRepo;
  late RegisterUseCase useCase;

  final testUser = User(
    uid: 'uid-new',
    name: 'Bob',
    email: 'bob@example.com',
    memberSince: DateTime(2024, 6, 1),
    accountId: 'ACC-BOB01',
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
    useCase = RegisterUseCase(mockRepo);
  });

  group('RegisterUseCase', () {
    test('returns newly created User on success', () async {
      // No existing account found for this email.
      when(
        () => mockRepo.findByEmail('bob@example.com'),
      ).thenAnswer((_) async => left(const NotFoundFailure('not found')));

      when(
        () => mockRepo.save(
          user: any(named: 'user'),
          passwordHash: any(named: 'passwordHash'),
          salt: any(named: 'salt'),
        ),
      ).thenAnswer((_) async => right(testUser));

      final result = await useCase(
        name: 'Bob',
        email: 'bob@example.com',
        password: 'securePass1',
      );

      expect(result.isRight, isTrue);
      expect(result.rightValue.email, equals('bob@example.com'));
      expect(result.rightValue.name, equals('Bob'));
    });

    test('propagates AuthFailure when email already exists', () async {
      // Email already taken.
      when(
        () => mockRepo.findByEmail('alice@example.com'),
      ).thenAnswer((_) async => right(testUser));

      final result = await useCase(
        name: 'Alice2',
        email: 'alice@example.com',
        password: 'pass123',
      );

      expect(result.isLeft, isTrue);
      expect(result.leftValue, isA<AuthFailure>());
      expect(result.leftValue.message, contains('already exists'));
    });

    test('does not call save when email is already taken', () async {
      when(
        () => mockRepo.findByEmail(any()),
      ).thenAnswer((_) async => right(testUser));

      await useCase(name: 'Dup', email: 'dup@example.com', password: 'pass');

      verifyNever(
        () => mockRepo.save(
          user: any(named: 'user'),
          passwordHash: any(named: 'passwordHash'),
          salt: any(named: 'salt'),
        ),
      );
    });

    test('calls findByEmail once with the provided email', () async {
      when(
        () => mockRepo.findByEmail(any()),
      ).thenAnswer((_) async => left(const NotFoundFailure('not found')));
      when(
        () => mockRepo.save(
          user: any(named: 'user'),
          passwordHash: any(named: 'passwordHash'),
          salt: any(named: 'salt'),
        ),
      ).thenAnswer((_) async => right(testUser));

      await useCase(
        name: 'Charlie',
        email: 'charlie@example.com',
        password: 'pass123',
      );

      verify(() => mockRepo.findByEmail('charlie@example.com')).called(1);
    });
  });
}
