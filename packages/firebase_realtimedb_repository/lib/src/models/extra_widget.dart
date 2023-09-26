import 'package:firebase_database/firebase_database.dart';

class ExtraWidget {
  ExtraWidget({
    this.keyId,
    this.content,
    required this.dataType,
    required this.owner,
    required this.position,
    required this.timeStamp,
    required this.title,
    required this.widget
  });
  final String? keyId;
  final String? content; // content can be nullable/empty
  final String dataType;
  final String owner; // id of the owner
  final int position;
  final DateTime timeStamp;
  final String title;
  final String widget;

  ExtraWidget copyWith({
    String? keyId,
    String? content,
    String? dataType,
    String? owner,
    int? position,
    DateTime? timeStamp,
    String? title,
    String? widget
  }) {
    return ExtraWidget(
      keyId: keyId ?? this.keyId,
      content: content ?? this.content,
      dataType: dataType ?? this.dataType,
      owner: owner ?? this.owner,
      position: position ?? this.position,
      timeStamp: timeStamp ?? this.timeStamp,
      title: title ?? this.title,
      widget: widget ?? this.widget
    );
  }

  factory ExtraWidget.fromSnapshot(DataSnapshot snapshot) {
    final data = snapshot.value as Map?;
    final intTimeStamp = data?['time_stamp'] as int?;
    final timestamp = intTimeStamp != null && intTimeStamp.abs() <= 9999999999999
    ? DateTime.fromMillisecondsSinceEpoch(intTimeStamp)
    : DateTime.now();

    return ExtraWidget(
      keyId: snapshot.key,
      content: data?['content'] as String? ?? '',
      dataType: data?['data_type'] as String? ?? '',
      owner: data?['owner'] as String? ?? '',
      position: data?['position'] as int? ?? 0,
      timeStamp: timestamp,
      title: data?['title'] as String? ?? '',
      widget: data?['widget'] as String? ?? ''
    );
  }
}