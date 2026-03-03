import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:isar/isar.dart';

import 'package:flutter_casino_platform/features/auth/data/models/user_model.dart';

/// Contract for the local Isar data source.
abstract interface class AuthLocalDatasource {
  Future<UserModel?> findByEmail(String email);
  Future<UserModel> save(UserModel model);
  Future<UserModel?> getFirst();
  Future<void> deleteAll();
}

/// Isar implementation of [AuthLocalDatasource].
class AuthLocalDatasourceImpl implements AuthLocalDatasource {
  final Isar _isar;

  const AuthLocalDatasourceImpl(this._isar);

  @override
  Future<UserModel?> findByEmail(String email) {
    return _isar.userModels.filter().emailEqualTo(email).findFirst();
  }

  @override
  Future<UserModel> save(UserModel model) async {
    await _isar.writeTxn(() => _isar.userModels.put(model));
    return model;
  }

  @override
  Future<UserModel?> getFirst() => _isar.userModels.where().findFirst();

  @override
  Future<void> deleteAll() async {
    await _isar.writeTxn(() => _isar.userModels.clear());
  }
}

// ── Password utilities ──────────────────────────────────────────────────────

/// Generates a cryptographically random 16-byte hex salt.
String generateSalt() {
  final rng = Random.secure();
  final bytes = List<int>.generate(16, (_) => rng.nextInt(256));
  return bytes.map((b) => b.toRadixString(16).padLeft(2, '0')).join();
}

/// Hashes [password] with [salt] using SHA-256.
/// Returns a lowercase hex digest string.
String hashPassword(String password, String salt) {
  final input = utf8.encode(password + salt);
  return sha256.convert(input).toString();
}

/// Constant-time comparison to prevent timing attacks.
bool verifyHash(String password, String salt, String storedHash) {
  final computed = hashPassword(password, salt);
  if (computed.length != storedHash.length) return false;
  var result = 0;
  for (var i = 0; i < computed.length; i++) {
    result |= computed.codeUnitAt(i) ^ storedHash.codeUnitAt(i);
  }
  return result == 0;
}
