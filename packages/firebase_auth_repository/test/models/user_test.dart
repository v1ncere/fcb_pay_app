import 'package:firebase_auth_repository/firebase_auth_repository.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('User', () {
    const id = 'mock-id';
    const email = 'mock-email';

    test('uses value equality', () {
      expect(
        User(email: email, uid: id),
        equals(User(email: email, uid: id)),
      );
    });

    test('isEmpty returns true for empty user', () {
      expect(User.empty.isEmpty, isTrue);
    });

    test('isEmpty returns false for non-empty user', () {
      final user = User(email: email, uid: id);
      expect(user.isEmpty, isFalse);
    });

    test('isNotEmpty returns false for empty user', () {
      expect(User.empty.isNotEmpty, isFalse);
    });

    test('isNotEmpty returns true for non-empty user', () {
      final user = User(email: email, uid: id);
      expect(user.isNotEmpty, isTrue);
    });
  });
}