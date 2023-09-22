import 'package:firebase_database/firebase_database.dart';

class PageWidget {
  const PageWidget({
    this.keyId,
    required this.additional,
    this.content,
    required this.dataType,
    required this.node,
    required this.owner,
    required this.timeStamp,
    required this.title,
    required this.widget
  });
  final String? keyId;
  final bool additional;
  final String? content;
  final String dataType;
  final String node;
  final String owner;
  final DateTime timeStamp;
  final String title;
  final String widget;

  PageWidget copyWith({
    String? keyId,
    bool? additional,
    String? content,
    String? dataType,
    String? node,
    String? owner,
    DateTime? timeStamp,
    String? title,
    String? widget
  }) {
    return PageWidget(
      keyId: keyId ?? this.keyId,
      additional: additional ?? this.additional,
      content: content ?? this.content,
      dataType: dataType ?? this.dataType,
      node: node ?? this.node,
      owner: owner ?? this.owner,
      timeStamp: timeStamp ?? this.timeStamp,
      title: title ?? this.title,
      widget: widget ?? this.widget
    );
  }

  factory PageWidget.fromSnapshot(DataSnapshot dataSnapshot) {
    final data = dataSnapshot.value as Map?;  // convert dataSnapshot object into Map<dynamic, dynamic>? 
    final intTimeStamp = data?['time_stamp'] as int?;
    final dateStamp = intTimeStamp != null && intTimeStamp.abs() <= 9999999999999
    ? DateTime.fromMillisecondsSinceEpoch(intTimeStamp)
    : null;

    return PageWidget(
      keyId: dataSnapshot.key,
      additional: data?['additional'] as bool? ?? false,
      content: data?['content'] as String? ?? '',
      dataType: data?['data_type'] as String? ?? '',
      node: data?['node'] as String? ?? '',
      owner: data?['owner'] as String? ?? '',
      timeStamp: dateStamp ?? DateTime.now(),
      title: data?['title'] as String? ?? '',
      widget: data?['widget'] as String? ?? ''
    );
  }
}