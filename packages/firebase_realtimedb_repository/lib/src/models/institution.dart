import 'package:firebase_database/firebase_database.dart';

class Institution {
  const Institution({
    this.keyId,
    this.id,
    required this.name,
    required this.timeStamp
  });

  final String? keyId;
  final String? id;
  final String name;
  
  final DateTime timeStamp;

  Institution copyWith({
    String? keyId,
    String? id,
    String? name,
    DateTime? timeStamp
  }) {
    return Institution(
      keyId: keyId ?? this.keyId,
      id: id ?? this.id,
      name: name ?? this.name,
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
      timeStamp: timestamp ?? DateTime.now()
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["name"] = name;
    data["time_stamp"] = timeStamp.millisecondsSinceEpoch;
    return data;
  }
}