import 'package:firebase_database/firebase_database.dart';

class AdditionalWidget {
  AdditionalWidget({
    this.keyId,
    this.content,
    required this.dataType,
    required this.ownerId,
    required this.title,
    required this.widget
  });
  final String? keyId;
  final String? content; // content can be nullable/empty
  final String dataType;
  final String ownerId; // id of the owner
  final String title;
  final String widget;

  AdditionalWidget copyWith({
    String? keyId,
    String? content,
    String? dataType,
    String? ownerId,
    String? title,
    String? widget
  }) {
    return AdditionalWidget(
      keyId: keyId ?? this.keyId,
      content: content ?? this.content,
      dataType: dataType ?? this.dataType,
      ownerId: ownerId ?? this.ownerId,
      title: title ?? this.title,
      widget: widget ?? this.widget
    );
  }

  factory AdditionalWidget.fromSnapshot(DataSnapshot snapshot) {
    final data = snapshot.value as Map?;

    return AdditionalWidget(
      keyId: snapshot.key,
      content: data?['content'] as String? ?? '',
      dataType: data?['data_type'] as String? ?? '',
      ownerId: data?['owner_id'] as String? ?? '',
      title: data?['title'] as String? ?? '',
      widget: data?['widget'] as String? ?? ''
    );
  }
}