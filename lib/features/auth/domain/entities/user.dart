import 'package:equatable/equatable.dart';

/// Core domain entity for a registered player.
///
/// Pure Dart — no framework annotations, no JSON serialisation.
/// All persistence concerns live in the data layer.
class User extends Equatable {
  final String uid;
  final String name;
  final String email;
  final DateTime memberSince;
  final String accountId;

  const User({
    required this.uid,
    required this.name,
    required this.email,
    required this.memberSince,
    required this.accountId,
  });

  @override
  List<Object?> get props => [uid, name, email, memberSince, accountId];
}
