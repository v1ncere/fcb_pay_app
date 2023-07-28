import 'package:firebase_database/firebase_database.dart';

class UserWidget {
  UserWidget({
    this.keyId,
    this.content,
    required this.dataType,
    required this.title,
    required this.widget
  });
  final String? keyId;
  final String? content;
  final String dataType;
  final String title;
  final String widget;

  UserWidget copyWith({
    String? keyId,
    String? content,
    String? dataType,
    String? title,
    String? widget
  }) {
    return UserWidget(
      keyId: keyId ?? this.keyId,
      content: content ?? this.content,
      dataType: dataType ?? this.dataType,
      title: title ?? this.title,
      widget: widget ?? this.widget
    );
  }

  factory UserWidget.fromSnapshot(DataSnapshot snapshot) {
    final data = snapshot.value as Map?;

    return UserWidget(
      keyId: snapshot.key,
      content: data?["content"] as String? ?? "",
      dataType: data?["data_type"] as String? ?? "",
      title: data?["title"] as String? ?? "",
      widget: data?["widget"] as String? ?? ""
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["content"] = content;
    data["data_type"] = dataType;
    data["title"] = title;
    data["widget"] = widget;
    return data;
  }
}