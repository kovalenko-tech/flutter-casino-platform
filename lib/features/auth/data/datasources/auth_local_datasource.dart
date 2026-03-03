import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter_casino_platform/core/errors/failures.dart';
import 'package:flutter_casino_platform/core/types/either.dart';
import 'package:flutter_casino_platform/features/auth/domain/entities/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

abstract interface class AuthLocalDatasource {
  Future<Either<Failure, User>> findByEmail(String email);
  Future<Either<Failure, User>> saveUser({
    required User user,
    required String passwordHash,
    required String salt,
  });
  Future<Either<Failure, User?>> getCurrentUser();
  Future<Either<Failure, User>> verifyCredentials({
    required String email,
    required String password,
  });
  Future<Either<Failure, void>> deleteAll();
}

class AuthLocalDatasourceImpl implements AuthLocalDatasource {
  static const _keyUsers = 'auth_users';
  static const _keyCurrentUid = 'auth_current_uid';

  static String _generateSalt() {
    final bytes = List<int>.generate(16, (i) => DateTime.now().microsecondsSinceEpoch + i);
    return base64Encode(bytes);
  }

  static String hashPassword(String password, String salt) {
    final bytes = utf8.encode(password + salt);
    return sha256.convert(bytes).toString();
  }

  Future<SharedPreferences> get _prefs => SharedPreferences.getInstance();

  Future<List<Map<String, dynamic>>> _loadUsers() async {
    final prefs = await _prefs;
    final raw = prefs.getString(_keyUsers);
    if (raw == null) return [];
    final list = jsonDecode(raw) as List<dynamic>;
    return list.cast<Map<String, dynamic>>();
  }

  Future<void> _saveUsers(List<Map<String, dynamic>> users) async {
    final prefs = await _prefs;
    await prefs.setString(_keyUsers, jsonEncode(users));
  }

  @override
  Future<Either<Failure, User>> findByEmail(String email) async {
    try {
      final users = await _loadUsers();
      final match = users.where((u) => u['email'] == email.toLowerCase()).firstOrNull;
      if (match == null) return left(const NotFoundFailure('No account found with that email.'));
      return right(_mapToUser(match));
    } catch (e) {
      return left(StorageFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, User>> saveUser({
    required User user,
    required String passwordHash,
    required String salt,
  }) async {
    try {
      final users = await _loadUsers();
      users.add({
        'uid': user.id,
        'name': user.name,
        'email': user.email.toLowerCase(),
        'passwordHash': passwordHash,
        'salt': salt,
        'memberSince': user.memberSince.toIso8601String(),
        'accountId': user.accountId,
      });
      await _saveUsers(users);
      final prefs = await _prefs;
      await prefs.setString(_keyCurrentUid, user.id);
      return right(user);
    } catch (e) {
      return left(StorageFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, User?>> getCurrentUser() async {
    try {
      final prefs = await _prefs;
      final uid = prefs.getString(_keyCurrentUid);
      if (uid == null) return right(null);
      final users = await _loadUsers();
      final match = users.where((u) => u['uid'] == uid).firstOrNull;
      if (match == null) return right(null);
      return right(_mapToUser(match));
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
      final users = await _loadUsers();
      final match = users.where((u) => u['email'] == email.toLowerCase()).firstOrNull;
      if (match == null) return left(const AuthFailure('Invalid email or password.'));
      final stored = match['passwordHash'] as String;
      final salt = match['salt'] as String;
      final hash = hashPassword(password, salt);
      if (hash != stored) return left(const AuthFailure('Invalid email or password.'));
      final prefs = await _prefs;
      await prefs.setString(_keyCurrentUid, match['uid'] as String);
      return right(_mapToUser(match));
    } catch (e) {
      return left(StorageFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteAll() async {
    try {
      final prefs = await _prefs;
      await prefs.remove(_keyUsers);
      await prefs.remove(_keyCurrentUid);
      return right(null);
    } catch (e) {
      return left(StorageFailure(e.toString()));
    }
  }

  User _mapToUser(Map<String, dynamic> map) => User(
        id: map['uid'] as String,
        name: map['name'] as String,
        email: map['email'] as String,
        memberSince: DateTime.parse(map['memberSince'] as String),
        accountId: map['accountId'] as String,
      );
}
