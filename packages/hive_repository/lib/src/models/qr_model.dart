import 'dart:convert';

import 'package:hive_flutter/hive_flutter.dart';

part 'qr_model.g.dart';

@HiveType(typeId: 1)
class QRModel {
  const QRModel({
    required this.id,
    required this.title,
    required this.data,
    required this.widget
  });
  @HiveField(0)
  final String id;
  
  @HiveField(1)
  final String title;

  @HiveField(2)
  final String data;

  @HiveField(3)
  final String widget;

  QRModel copyWith({
    String? id,
    String? title,
    String? data,
    String? widget
  }) {
    return QRModel(
      id: id ?? this.id,
      title: title ?? this.title,
      data: data ?? this.data,
      widget: widget ?? this.widget
    );
  }

  static const empty = QRModel(id: '', title: '', data: '', widget: '');

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'data': data,
      'widget': widget,
    };
  }

  factory QRModel.fromMap(Map<String, dynamic> map) {
    return QRModel(
      id: map['id'] as String,
      title: map['title'] as String,
      data: map['data'] as String,
      widget: map['widget'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory QRModel.fromJson(String source) => QRModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
