import 'package:firebase_database/firebase_database.dart';

class HomeButton {
  const HomeButton({
    this.keyId,
    required this.title,
    required this.icon,
    required this.timeStamp
  });
  final String? keyId;
  final String title;
  final String icon;
  final DateTime timeStamp;

  HomeButton copyWith({
    String? keyId,
    String? title,
    String? icon,
    DateTime? timeStamp
  }) {
    return HomeButton(
      keyId: keyId ?? this.keyId,
      title: title ?? this.title,
      icon: icon ?? this.icon,
      timeStamp: timeStamp ?? this.timeStamp
    );
  }

  factory HomeButton.fromSnapShot(DataSnapshot dataSnapshot){
    final data = dataSnapshot.value as Map?;
    final intTimeStamp = data?['time_stamp'] as int?;
    final dateStamp = intTimeStamp != null && intTimeStamp.abs() <= 9999999999999
    ? DateTime.fromMillisecondsSinceEpoch(intTimeStamp)
    : null;

    return HomeButton(
      keyId: dataSnapshot.key,
      title: data?['title'] as String? ?? '',
      icon: data?['icon'] as String? ?? '',
      timeStamp: dateStamp ?? DateTime.now()
    );
  }
}