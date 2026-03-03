import 'package:uuid/uuid.dart';

import 'package:flutter_casino_platform/features/auth/domain/entities/user.dart';
import 'package:flutter_casino_platform/features/auth/domain/repositories/auth_repository.dart';
import 'package:flutter_casino_platform/features/core/errors/failures.dart';
import 'package:flutter_casino_platform/features/auth/data/datasources/auth_local_datasource.dart';

/// Registers a new player account.
///
/// Steps:
/// 1. Check that email is not already taken.
/// 2. Generate a random salt.
/// 3. Hash the password with SHA-256(password + salt).
/// 4. Persist the new [User] via the repository.
class RegisterUseCase {
  final AuthRepository _repository;
  static const _uuid = Uuid();

  const RegisterUseCase(this._repository);

  Future<Either<Failure, User>> call({
    required String name,
    required String email,
    required String password,
  }) async {
    // Ensure the email is not already taken.
    final existing = await _repository.findByEmail(email);
    if (existing.isRight) {
      return left(const AuthFailure('An account with that email already exists.'));
    }

    final salt = generateSalt();
    final hash = hashPassword(password, salt);

    final user = User(
      uid: _uuid.v4(),
      name: name,
      email: email,
      memberSince: DateTime.now(),
      accountId: 'ACC-${_uuid.v4().substring(0, 5).toUpperCase()}',
    );

    return _repository.save(user: user, passwordHash: hash, salt: salt);
  }
}
