import 'package:flutter_casino_platform/features/auth/domain/entities/user.dart';
import 'package:flutter_casino_platform/features/auth/domain/repositories/auth_repository.dart';
import 'package:flutter_casino_platform/core/errors/failures.dart';

/// Validates email/password credentials against the local Isar store.
///
/// Returns the authenticated [User] on success, or an [AuthFailure]
/// if credentials are incorrect or the account does not exist.
class LoginUseCase {
  final AuthRepository _repository;

  const LoginUseCase(this._repository);

  Future<Either<Failure, User>> call({
    required String email,
    required String password,
  }) {
    return _repository.verifyCredentials(email: email, password: password);
  }
}
