import 'package:firebase_database/firebase_database.dart';

class HomeButtonWidget {
  const HomeButtonWidget({
    this.keyId,
    this.content,
    this.dataType,
    this.node,
    required this.timeStamp,
    this.title,
    this.widget
  });
  final String? keyId;
  final String? content;
  final String? dataType;
  final String? node;
  final DateTime timeStamp;
  final String? title;
  final String? widget;

  HomeButtonWidget copyWith({
    String? keyId,
    String? content,
    String? dataType,
    String? node,
    DateTime? timeStamp,
    String? title,
    String? widget
  }) {
    return HomeButtonWidget(
      keyId: keyId ?? this.keyId,
      content: content ?? this.content,
      dataType: dataType ?? this.dataType,
      node: node ?? this.node,
      timeStamp: timeStamp ?? this.timeStamp,
      title: title ?? this.title,
      widget: widget ?? this.widget
    );
  }

  factory HomeButtonWidget.fromSnapshot(DataSnapshot dataSnapshot) {
    final data = dataSnapshot.value as Map?;  // convert dataSnapshot object into Map<dynamic, dynamic>? 
    final intTimeStamp = data?['time_stamp'] as int?;
    final dateStamp = intTimeStamp != null && intTimeStamp.abs() <= 9999999999999
    ? DateTime.fromMillisecondsSinceEpoch(intTimeStamp)
    : null;

    return HomeButtonWidget(
      keyId: dataSnapshot.key,
      content: data?['content'] as String? ?? '',
      dataType: data?['data_type'] as String? ?? '',
      node: data?['node'] as String? ?? '',
      timeStamp: dateStamp ?? DateTime.now(),
      title: data?['title'] as String? ?? '',
      widget: data?['widget'] as String? ?? ''
    );
  }
}