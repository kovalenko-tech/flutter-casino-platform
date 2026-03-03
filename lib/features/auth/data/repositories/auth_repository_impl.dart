import 'package:flutter_casino_platform/features/auth/domain/entities/user.dart';
import 'package:flutter_casino_platform/features/auth/domain/repositories/auth_repository.dart';
import 'package:flutter_casino_platform/features/core/errors/failures.dart';
import 'package:flutter_casino_platform/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:flutter_casino_platform/features/auth/data/models/user_model.dart';

/// Concrete [AuthRepository] backed by Isar through [AuthLocalDatasource].
///
/// All exceptions from the data source are caught and wrapped in [Failure]
/// subtypes so the domain and presentation layers never see raw exceptions.
class AuthRepositoryImpl implements AuthRepository {
  final AuthLocalDatasource _datasource;

  const AuthRepositoryImpl(this._datasource);

  @override
  Future<Either<Failure, User>> findByEmail(String email) async {
    try {
      final model = await _datasource.findByEmail(email);
      if (model == null) {
        return left(const NotFoundFailure('No account found with that email.'));
      }
      return right(model.toDomain());
    } catch (e) {
      return left(StorageFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, User>> save({
    required User user,
    required String passwordHash,
    required String salt,
  }) async {
    try {
      final model = UserModel.fromDomain(user, passwordHash, salt);
      await _datasource.save(model);
      return right(user);
    } catch (e) {
      return left(StorageFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, User?>> getCurrentUser() async {
    try {
      final model = await _datasource.getFirst();
      return right(model?.toDomain());
    } catch (e) {
      return left(StorageFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, User>> verifyCredentials({
    required String email,
    required String password,
  }) async {
    try {
      final model = await _datasource.findByEmail(email);
      if (model == null) {
        return left(const AuthFailure('Invalid email or password.'));
      }
      final valid = verifyHash(password, model.salt, model.passwordHash);
      if (!valid) {
        return left(const AuthFailure('Invalid email or password.'));
      }
      return right(model.toDomain());
    } catch (e) {
      return left(StorageFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteAll() async {
    try {
      await _datasource.deleteAll();
      return right(null);
    } catch (e) {
      return left(StorageFailure(e.toString()));
    }
  }
}
