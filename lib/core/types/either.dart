/// Lightweight Either monad — avoids pulling in dartz for this project.
///
/// Use [right] to wrap a success value and [left] to wrap a failure.
library;

typedef Either<L, R> = ({L? left, R? right});

extension EitherX<L, R> on Either<L, R> {
  bool get isLeft => this.left != null;
  bool get isRight => this.right != null;
  L get leftValue => this.left as L;
  R get rightValue => this.right as R;

  /// Folds the Either into a single value.
  T fold<T>(T Function(L) onLeft, T Function(R) onRight) =>
      isLeft ? onLeft(leftValue) : onRight(rightValue);
}

/// Creates a success (right) Either.
Either<L, R> right<L, R>(R value) => (left: null, right: value);

/// Creates a failure (left) Either.
Either<L, R> left<L, R>(L value) => (left: value, right: null);
