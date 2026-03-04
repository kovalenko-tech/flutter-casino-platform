/// Sealed failure hierarchy used across the data/domain boundary.
///
/// Every repository method that can fail returns `Either<Failure, T>`.
/// Keeping failures as typed objects (not raw exceptions) makes BLoC
/// error-handling explicit and testable.
abstract class Failure {
  final String message;
  const Failure(this.message);

  @override
  String toString() => '$runtimeType: $message';
}

/// Covers login / register / logout / session-check failures.
class AuthFailure extends Failure {
  const AuthFailure(super.message);
}

/// Covers SQLite read/write/delete failures.
class StorageFailure extends Failure {
  const StorageFailure(super.message);
}

/// Raised when a requested record does not exist in the local DB.
class NotFoundFailure extends Failure {
  const NotFoundFailure(super.message);
}

/// Generic validation failure — e.g. weak password, mismatched fields.
class ValidationFailure extends Failure {
  const ValidationFailure(super.message);
}
