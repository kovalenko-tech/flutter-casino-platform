import 'package:flutter_casino_platform/features/auth/domain/entities/user.dart';

/// SQLite row representation of a player account.
///
/// Separated from the domain [User] entity so persistence details
/// (column names, serialization) stay out of the domain layer.
class UserModel {
  final int? id; // SQLite auto-increment PK (null before first insert)
  final String uid;
  final String name;
  final String email;

  /// SHA-256(password + salt), stored as lowercase hex.
  final String passwordHash;

  /// Random 16-byte hex salt generated at registration time.
  final String salt;

  final DateTime memberSince;

  /// Human-readable account reference, e.g. "ACC-7A3F9".
  final String accountId;

  final bool loggedIn;

  const UserModel({
    this.id,
    required this.uid,
    required this.name,
    required this.email,
    required this.passwordHash,
    required this.salt,
    required this.memberSince,
    required this.accountId,
    this.loggedIn = true,
  });

  // ── SQLite serialization ──────────────────────────────────────────────────

  Map<String, Object?> toMap() => {
        if (id != null) 'id': id,
        'uid': uid,
        'name': name,
        'email': email,
        'password_hash': passwordHash,
        'salt': salt,
        'member_since': memberSince.millisecondsSinceEpoch,
        'account_id': accountId,
        'logged_in': loggedIn ? 1 : 0,
      };

  factory UserModel.fromMap(Map<String, Object?> map) => UserModel(
        id: map['id'] as int?,
        uid: map['uid'] as String,
        name: map['name'] as String,
        email: map['email'] as String,
        passwordHash: map['password_hash'] as String,
        salt: map['salt'] as String,
        memberSince: DateTime.fromMillisecondsSinceEpoch(
          map['member_since'] as int,
        ),
        accountId: map['account_id'] as String,
        loggedIn: (map['logged_in'] as int?) == 1,
      );

  // ── Domain mappers ────────────────────────────────────────────────────────

  User toDomain() => User(
        uid: uid,
        name: name,
        email: email,
        memberSince: memberSince,
        accountId: accountId,
      );

  UserModel copyWith({bool? loggedIn}) => UserModel(
        id: id,
        uid: uid,
        name: name,
        email: email,
        passwordHash: passwordHash,
        salt: salt,
        memberSince: memberSince,
        accountId: accountId,
        loggedIn: loggedIn ?? this.loggedIn,
      );

  static UserModel fromDomain(User user, String passwordHash, String salt) =>
      UserModel(
        uid: user.uid,
        name: user.name,
        email: user.email,
        passwordHash: passwordHash,
        salt: salt,
        memberSince: user.memberSince,
        accountId: user.accountId,
      );
}
