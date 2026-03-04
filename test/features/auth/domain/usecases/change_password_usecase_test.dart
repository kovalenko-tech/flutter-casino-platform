import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:flutter_casino_platform/core/errors/failures.dart';
import 'package:flutter_casino_platform/core/types/either.dart';
import 'package:flutter_casino_platform/features/auth/domain/repositories/auth_repository.dart';
import 'package:flutter_casino_platform/features/auth/domain/usecases/change_password_usecase.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late MockAuthRepository mockRepo;
  late ChangePasswordUseCase useCase;

  setUp(() {
    mockRepo = MockAuthRepository();
    useCase = ChangePasswordUseCase(mockRepo);
  });

  group('ChangePasswordUseCase', () {
    test('returns Right(void) on success', () async {
      when(
        () => mockRepo.changePassword(
          email: 'alice@example.com',
          oldPassword: 'OldPass1',
          newPassword: 'NewPass1',
        ),
      ).thenAnswer((_) async => right(null));

      final result = await useCase(
        email: 'alice@example.com',
        oldPassword: 'OldPass1',
        newPassword: 'NewPass1',
      );

      expect(result.isRight, isTrue);
    });

    test('returns AuthFailure when old password is wrong', () async {
      when(
        () => mockRepo.changePassword(
          email: any(named: 'email'),
          oldPassword: any(named: 'oldPassword'),
          newPassword: any(named: 'newPassword'),
        ),
      ).thenAnswer(
        (_) async => left(const AuthFailure('Current password is incorrect.')),
      );

      final result = await useCase(
        email: 'alice@example.com',
        oldPassword: 'wrong',
        newPassword: 'NewPass1',
      );

      expect(result.isLeft, isTrue);
      expect(result.leftValue, isA<AuthFailure>());
      expect(result.leftValue.message, 'Current password is incorrect.');
    });

    test('delegates to repository with correct arguments', () async {
      when(
        () => mockRepo.changePassword(
          email: 'bob@example.com',
          oldPassword: 'Old123',
          newPassword: 'New456',
        ),
      ).thenAnswer((_) async => right(null));

      await useCase(
        email: 'bob@example.com',
        oldPassword: 'Old123',
        newPassword: 'New456',
      );

      verify(
        () => mockRepo.changePassword(
          email: 'bob@example.com',
          oldPassword: 'Old123',
          newPassword: 'New456',
        ),
      ).called(1);
    });
  });
}
