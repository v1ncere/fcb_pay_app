import 'package:firebase_database/firebase_database.dart';

class Button {
  const Button({
    this.keyId,
    required this.title,
    required this.titleColor,
    required this.icon,
    required this.iconColor,
    required this.type,
    this.position,
    required this.bgColor,
    this.timeStamp
  });
  final String? keyId;
  final String title;
  final String titleColor;
  final String type;
  final int? position;
  final String icon;
  final String iconColor;
  final String bgColor;
  final DateTime? timeStamp;

  Button copyWith({
    String? keyId,
    String? title,
    String? titleColor,
    String? type,
    int? position,
    String? icon,
    String? iconColor,
    String? bgColor,
    DateTime? timeStamp
  }) {
    return Button(
      keyId: keyId ?? this.keyId,
      title: title ?? this.title,
      titleColor: titleColor ?? this.titleColor,
      type: type ?? this.type,
      position: position ?? this.position,
      icon: icon ?? this.icon,
      iconColor: iconColor ?? this.iconColor,
      bgColor: bgColor ?? this.bgColor,
      timeStamp: timeStamp ?? this.timeStamp
    );
  }

  static const empty = Button(bgColor: '', title: '', titleColor: '', icon: '', iconColor: '', type: '');
  bool get isEmpty => this == Button.empty;
  bool get isNotEmpty => this != Button.empty;

  factory Button.fromSnapShot(DataSnapshot dataSnapshot) {
    final data = dataSnapshot.value as Map?;
    final intTimeStamp = data?['time_stamp'] as int?;
    final timeStamp = intTimeStamp != null && intTimeStamp.abs() <= 9999999999999
    ? DateTime.fromMillisecondsSinceEpoch(intTimeStamp)
    : null;

    final position = data?['position'];
    final intPosition = position is int ? position : null;

    return Button(
      keyId: dataSnapshot.key,
      title: data?['title'] as String? ?? '',
      titleColor: data?['title_color'] as String? ?? '',
      type: data?['type'] as String? ?? '',
      icon: data?['icon'] as String? ?? '',
      position: intPosition,
      iconColor: data?['icon_color'] as String? ?? '',
      bgColor: data?['bg_color'] as String? ?? '',
      timeStamp: timeStamp ?? DateTime.now()
    );
  }
}