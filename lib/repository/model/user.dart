import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String? email;
  final String? password;
  final String? photo;
  
  const User({
    required this.id,
    this.email,
    this.password,
    this.photo,
  });

  static const empty = User(id: '');
  bool get isEmpty => this == User.empty;
  bool get isNotEmpty => this != User.empty;
  
  @override
  List<Object?> get props => [id, email, password, photo];
}
