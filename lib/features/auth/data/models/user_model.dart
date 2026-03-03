import 'package:isar/isar.dart';

import 'package:flutter_casino_platform/features/auth/domain/entities/user.dart';

part 'user_model.g.dart';

/// Isar-persisted representation of a player account.
///
/// Separated from the domain [User] entity to keep Isar annotations
/// out of the domain layer.
@collection
class UserModel {
  Id id = Isar.autoIncrement;

  /// Logical unique identifier (UUID v4).
  @Index(unique: true)
  late String uid;

  late String name;

  @Index(unique: true)
  late String email;

  /// SHA-256(password + salt), stored as hex string.
  late String passwordHash;

  /// Random 16-byte hex salt generated at registration time.
  late String salt;

  late DateTime memberSince;

  /// Human-readable account reference, e.g. "ACC-7A3F9".
  late String accountId;

  // ── Mappers ───────────────────────────────────────────────────────────────

  User toDomain() => User(
        uid: uid,
        name: name,
        email: email,
        memberSince: memberSince,
        accountId: accountId,
      );

  static UserModel fromDomain(User user, String passwordHash, String salt) {
    final model = UserModel()
      ..uid = user.uid
      ..name = user.name
      ..email = user.email
      ..passwordHash = passwordHash
      ..salt = salt
      ..memberSince = user.memberSince
      ..accountId = user.accountId;
    return model;
  }
}
