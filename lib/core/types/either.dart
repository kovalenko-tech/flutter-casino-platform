/// Lightweight Either monad — avoids pulling in dartz for this project.
library;

/// Internal class — use the [Either] typedef and [left]/[right] constructors.
class _Either<L, R> {
  final L? _l;
  final R? _r;
  final bool _isRight;

  const _Either._left(L value)
      : _l = value,
        _r = null,
        _isRight = false;

  const _Either._right(R value)
      : _l = null,
        _r = value,
        _isRight = true;
}

/// Public alias — use `Either<Failure, T>` throughout the codebase.
typedef Either<L, R> = _Either<L, R>;

extension EitherX<L, R> on Either<L, R> {
  bool get isLeft => !_isRight;
  bool get isRight => _isRight;
  L get leftValue => _l as L;
  R get rightValue => _r as R;

  T fold<T>(T Function(L) onLeft, T Function(R) onRight) =>
      isLeft ? onLeft(leftValue) : onRight(rightValue);
}

/// Wraps a success value.
Either<L, R> right<L, R>(R value) => _Either._right(value);

/// Wraps a failure value.
Either<L, R> left<L, R>(L value) => _Either._left(value);
