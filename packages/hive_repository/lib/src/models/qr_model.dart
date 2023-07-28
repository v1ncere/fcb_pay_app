import 'package:hive_flutter/hive_flutter.dart';

part 'qr_model.g.dart';

@HiveType(typeId: 1)
class QRModel {
  QRModel({
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
}