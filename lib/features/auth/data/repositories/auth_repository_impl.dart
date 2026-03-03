import 'package:flutter_casino_platform/core/errors/failures.dart';
import 'package:flutter_casino_platform/core/types/either.dart';
import 'package:flutter_casino_platform/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:flutter_casino_platform/features/auth/domain/entities/user.dart';
import 'package:flutter_casino_platform/features/auth/domain/repositories/auth_repository.dart';
import 'package:uuid/uuid.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthLocalDatasource _datasource;
  AuthRepositoryImpl(this._datasource);

  @override
  Future<Either<Failure, User>> findByEmail(String email) =>
      _datasource.findByEmail(email);

  @override
  Future<Either<Failure, User>> save({
    required User user,
    required String passwordHash,
    required String salt,
  }) =>
      _datasource.saveUser(user: user, passwordHash: passwordHash, salt: salt);

  @override
  Future<Either<Failure, User?>> getCurrentUser() =>
      _datasource.getCurrentUser();

  @override
  Future<Either<Failure, User>> verifyCredentials({
    required String email,
    required String password,
  }) =>
      _datasource.verifyCredentials(email: email, password: password);

  @override
  Future<Either<Failure, void>> deleteAll() => _datasource.deleteAll();
}
