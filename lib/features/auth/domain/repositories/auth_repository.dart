import '../entities/user.dart';
import '../../../core/errors/failures.dart';

// Simple Either-like wrapper — avoids pulling in dartz for this project.
typedef Either<L, R> = ({L? left, R? right});

extension EitherX<L, R> on Either<L, R> {
  bool get isLeft => left != null;
  bool get isRight => right != null;
  L get leftValue => left!;
  R get rightValue => right!;
}

/// Creates a successful Either value.
Either<L, R> right<L, R>(R value) => (left: null, right: value);

/// Creates a failure Either value.
Either<L, R> left<L, R>(L value) => (left: value, right: null);

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
}
