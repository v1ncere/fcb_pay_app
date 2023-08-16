import 'package:firebase_database/firebase_database.dart';

class Institution {
  const Institution({
    this.keyId,
    this.id,
    required this.name,
    required this.additionalWidget,
    required this.timeStamp
  });

  final String? keyId;
  final String? id;
  final String name;
  final String additionalWidget;
  final DateTime timeStamp;

  Institution copyWith({
    String? keyId,
    String? id,
    String? name,
    String? additionalWidget,
    DateTime? timeStamp
  }) {
    return Institution(
      keyId: keyId ?? this.keyId,
      id: id ?? this.id,
      name: name ?? this.name,
      additionalWidget: additionalWidget ?? this.additionalWidget,
      timeStamp: timeStamp ?? this.timeStamp
    );
  }

  factory Institution.fromSnapshot(DataSnapshot snapshot) {
    final data = snapshot.value as Map?;
    final intTimestamp = data?['time_stamp'] as int?;
    final timestamp = intTimestamp != null && intTimestamp.abs() <= 9999999999999
    ? DateTime.fromMillisecondsSinceEpoch(intTimestamp)
    : null;

    return Institution(
      keyId: snapshot.key,
      id: data?['id'] as String? ?? '',
      name: data?['name'] as String? ?? '',
      additionalWidget: data?['additional_widget'] as String? ?? '',
      timeStamp: timestamp ?? DateTime.now()
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["name"] = name;
    data["additional_widget"] = additionalWidget;
    data["time_stamp"] = timeStamp.millisecondsSinceEpoch;
    return data;
  }
}