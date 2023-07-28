import 'package:equatable/equatable.dart';

class User extends Equatable {
  const User({
    required this.uid,
    this.email,
    this.isVerified
  });

  final String? uid;
  final String? email;
  final bool? isVerified;

  User copyWith({
    String? id,
    String? email,
    bool? verify
  }) {
    return User(
      uid: id ?? this.uid,
      email: email ?? this.email,
      isVerified: verify ?? this.isVerified
    );
  }

  static const empty = User(uid: "");
  bool get isEmpty => this == User.empty;
  bool get isNotEmpty => this != User.empty;

  @override
  List<Object?> get props => [email, uid, isVerified];
}
