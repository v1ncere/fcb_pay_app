import 'package:equatable/equatable.dart';

class User extends Equatable {
  const User({
    required this.id,
    this.email,
  });

  final String? email;
  final String id;

  User copyWith({
    String? id,
    String? email,
  }) {
    return User(
      id: id ?? this.id,
      email: email ?? this.email,
    );
  }

  static const empty = User(id: '');
  bool get isEmpty => this == User.empty;
  bool get isNotEmpty => this != User.empty;

  @override
  List<Object?> get props => [email, id];
}
