import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_casino_platform/features/auth/domain/entities/user.dart';

void main() {
  final memberSince = DateTime(2024, 1, 15);

  final userA = User(
    uid: 'uid-1',
    name: 'Alice',
    email: 'alice@example.com',
    memberSince: memberSince,
    accountId: 'ACC-00001',
  );

  final userACopy = User(
    uid: 'uid-1',
    name: 'Alice',
    email: 'alice@example.com',
    memberSince: memberSince,
    accountId: 'ACC-00001',
  );

  final userB = User(
    uid: 'uid-2',
    name: 'Bob',
    email: 'bob@example.com',
    memberSince: memberSince,
    accountId: 'ACC-00002',
  );

  group('User', () {
    test('two Users with same fields are equal', () {
      expect(userA, equals(userACopy));
    });

    test('Users with different uid are not equal', () {
      expect(userA, isNot(equals(userB)));
    });

    test('props list includes all fields', () {
      expect(
        userA.props,
        equals([
          userA.uid,
          userA.name,
          userA.email,
          userA.memberSince,
          userA.accountId,
        ]),
      );
    });

    test('hashCode is equal for two equal Users', () {
      expect(userA.hashCode, equals(userACopy.hashCode));
    });
  });
}
