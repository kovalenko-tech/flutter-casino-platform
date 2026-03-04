import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:flutter_casino_platform/features/auth/data/models/user_model.dart';
import 'package:sqflite/sqflite.dart';

// ── Contract ─────────────────────────────────────────────────────────────────

/// Local data-source contract for player account persistence.
abstract interface class AuthLocalDatasource {
  Future<UserModel?> findByEmail(String email);
  Future<UserModel> save(UserModel model);
  Future<UserModel?> getFirst();
  Future<void> deleteAll();
  Future<void> logout();
  Future<void> setLoggedIn(String email);
  Future<void> updatePassword(String email, String hash, String salt);
}

// ── SQLite implementation ─────────────────────────────────────────────────────

/// SQLite-backed [AuthLocalDatasource] via the sqflite package.
///
/// A single `users` table holds all player rows. Passwords are never stored
/// in plain text — only the SHA-256 hash and its random salt are persisted.
class AuthLocalDatasourceImpl implements AuthLocalDatasource {
  final Database _db;

  const AuthLocalDatasourceImpl(this._db);

  static const _table = 'users';

  /// Called once when [Database] is first opened.
  static Future<void> onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $_table (
        id           INTEGER PRIMARY KEY AUTOINCREMENT,
        uid          TEXT    NOT NULL UNIQUE,
        name         TEXT    NOT NULL,
        email        TEXT    NOT NULL UNIQUE,
        password_hash TEXT   NOT NULL,
        salt         TEXT    NOT NULL,
        member_since INTEGER NOT NULL,
        account_id   TEXT    NOT NULL,
        logged_in    INTEGER NOT NULL DEFAULT 1
      )
    ''');
  }

  @override
  Future<UserModel?> findByEmail(String email) async {
    final rows = await _db.query(
      _table,
      where: 'LOWER(email) = LOWER(?)',
      whereArgs: [email],
      limit: 1,
    );
    if (rows.isEmpty) return null;
    return UserModel.fromMap(rows.first);
  }

  @override
  Future<UserModel> save(UserModel model) async {
    final id = await _db.insert(
      _table,
      model.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    // Return model with the assigned rowid
    return UserModel(
      id: id,
      uid: model.uid,
      name: model.name,
      email: model.email,
      passwordHash: model.passwordHash,
      salt: model.salt,
      memberSince: model.memberSince,
      accountId: model.accountId,
    );
  }

  @override
  Future<UserModel?> getFirst() async {
    final rows = await _db.query(
      _table,
      where: 'logged_in = 1',
      limit: 1,
      orderBy: 'id ASC',
    );
    if (rows.isEmpty) return null;
    return UserModel.fromMap(rows.first);
  }

  @override
  Future<void> deleteAll() => _db.delete(_table);

  @override
  Future<void> logout() async {
    await _db.update(_table, {'logged_in': 0}, where: 'logged_in = 1');
  }

  @override
  Future<void> setLoggedIn(String email) async {
    await _db.update(
      _table,
      {'logged_in': 1},
      where: 'LOWER(email) = LOWER(?)',
      whereArgs: [email],
    );
  }

  @override
  Future<void> updatePassword(String email, String hash, String salt) async {
    await _db.update(
      _table,
      {'password_hash': hash, 'salt': salt},
      where: 'LOWER(email) = LOWER(?)',
      whereArgs: [email],
    );
  }
}

// ── Password utilities ────────────────────────────────────────────────────────

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
