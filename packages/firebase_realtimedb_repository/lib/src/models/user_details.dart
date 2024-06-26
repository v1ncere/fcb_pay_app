import 'package:firebase_database/firebase_database.dart';
import '../utils/utils.dart';

class UserDetails {
  const UserDetails({
    this.key,
    required this.email,
    required this.firstName,
    required this.lastName,
    this.mobile,
    required this.userImageUrl,
    this.timeStamp,
  });
  final String? key;
  final String email;
  final String firstName;
  final String lastName;
  final int? mobile;
  final String userImageUrl;
  final DateTime? timeStamp;

  UserDetails copyWith({
    String? key,
    String? email,
    String? firstName,
    String? lastName,
    int? mobile,
    String? userImageUrl,
    DateTime? timeStamp,
  }) {
    return UserDetails(
      key: key ?? this.key,
      email: email ?? this.email,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      mobile: mobile ?? this.mobile,
      userImageUrl: userImageUrl ?? this.userImageUrl,
      timeStamp: timeStamp ?? this.timeStamp
    );
  }

  static const empty = UserDetails(email: '', firstName: '', lastName: '', userImageUrl: '');
  bool get isEmpty => this == UserDetails.empty;
  bool get isNotEmpty => this != UserDetails.empty;

  factory UserDetails.fromSnapshot(DataSnapshot snapshot) {
    final data = snapshot.value as Map?;
    final intTimeStamp = data?['time_stamp'] as int?;
    
    return UserDetails(
      key: snapshot.key,
      email: data?['email'] as String? ?? '',
      firstName: data?['first_name'] as String? ?? '',
      lastName: data?['last_name'] as String? ?? '',
      mobile: data?['mobile'] as int?,
      userImageUrl: data?['user_image_url'] as String? ?? '',
      timeStamp: millisConverter(intTimeStamp) ?? DateTime.now()
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['email'] = email;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['mobile'] = mobile;
    data['user_image_url'] = userImageUrl;
    data['time_stamp'] = timeStamp!.millisecondsSinceEpoch;
    return data;
  }
}