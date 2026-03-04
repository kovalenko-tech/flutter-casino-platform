import 'package:flutter_casino_platform/core/errors/failures.dart';
import 'package:flutter_casino_platform/core/types/either.dart';
import 'package:flutter_casino_platform/features/auth/domain/entities/user.dart';

/// Abstract contract for all authentication data operations.
///
/// The domain layer depends on this interface; the data layer provides
/// the concrete [AuthRepositoryImpl].
abstract interface class AuthRepository {
  /// Finds a user by email. Returns [NotFoundFailure] if absent.
  Future<Either<Failure, User>> findByEmail(String email);

  /// Persists a new user model (password hash + salt included).
  Future<Either<Failure, User>> save({
    required User user,
    required String passwordHash,
    required String salt,
  });

  /// Returns the first stored user (session lookup).
  Future<Either<Failure, User?>> getCurrentUser();

  /// Verifies [password] against stored hash for [email].
  Future<Either<Failure, User>> verifyCredentials({
    required String email,
    required String password,
  });

  /// Removes all user records (logout / account wipe).
  Future<Either<Failure, void>> deleteAll();

  /// Logs out the current user (clears session flag).
  Future<Either<Failure, void>> logout();

  /// Marks the user with [email] as logged in.
  Future<Either<Failure, void>> setLoggedIn(String email);

  /// Changes the password for the user with [email].
  /// Verifies [oldPassword] before applying [newPassword].
  Future<Either<Failure, void>> changePassword({
    required String email,
    required String oldPassword,
    required String newPassword,
  });
}
