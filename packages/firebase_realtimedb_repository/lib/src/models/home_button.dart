import 'package:firebase_database/firebase_database.dart';

class HomeButton {
  const HomeButton({
    this.keyId,
    required this.title,
    required this.titleColor,
    required this.timeStamp,
    required this.bgColor,
    required this.icon,
    required this.iconColor,
  });
  final String? keyId;
  final String title;
  final int titleColor;
  final String icon;
  final int iconColor;
  final int bgColor;
  final DateTime timeStamp;

  HomeButton copyWith({
    String? keyId,
    String? title,
    int? titleColor,
    String? icon,
    int? iconColor,
    int? bgColor,
    DateTime? timeStamp
  }) {
    return HomeButton(
      keyId: keyId ?? this.keyId,
      title: title ?? this.title,
      titleColor: titleColor ?? this.titleColor,
      icon: icon ?? this.icon,
      iconColor: iconColor ?? this.iconColor,
      bgColor: bgColor ?? this.bgColor,
      timeStamp: timeStamp ?? this.timeStamp,
    );
  }

  factory HomeButton.fromSnapShot(DataSnapshot dataSnapshot) {
    final data = dataSnapshot.value as Map?;
    final intTimeStamp = data?['time_stamp'] as int?;
    final dateStamp = intTimeStamp != null && intTimeStamp.abs() <= 9999999999999
    ? DateTime.fromMillisecondsSinceEpoch(intTimeStamp)
    : null;

    return HomeButton(
      keyId: dataSnapshot.key,
      title: data?['title'] as String? ?? '',
      titleColor: data?['title_color'] as int,
      icon: data?['icon'] as String? ?? '',
      iconColor: data?['icon_color'] as int,
      bgColor: data?['bg_color'] as int,
      timeStamp: dateStamp ?? DateTime.now()
    );
  }
}