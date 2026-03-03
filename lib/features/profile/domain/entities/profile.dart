import 'package:equatable/equatable.dart';

import '../../../auth/domain/entities/user.dart';

/// Read-only view entity projected from [User] for the profile screen.
///
/// Keeping this separate means the profile screen has no direct dependency
/// on the auth domain — easier to swap the data source later.
class Profile extends Equatable {
  final String name;
  final String email;
  final DateTime memberSince;
  final String accountId;

  const Profile({
    required this.name,
    required this.email,
    required this.memberSince,
    required this.accountId,
  });

  factory Profile.fromUser(User user) => Profile(
        name: user.name,
        email: user.email,
        memberSince: user.memberSince,
        accountId: user.accountId,
      );

  /// Returns the user's initials (up to two characters) for the avatar.
  String get initials {
    final parts = name.trim().split(' ');
    if (parts.length >= 2) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    }
    return name.substring(0, name.length.clamp(0, 2)).toUpperCase();
  }

  @override
  List<Object?> get props => [name, email, memberSince, accountId];
}
