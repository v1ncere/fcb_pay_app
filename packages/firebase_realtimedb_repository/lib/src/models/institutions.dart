import 'package:firebase_database/firebase_database.dart';

class Institution {
  final String i_id;
  final String name;
  final String textField;
  final DateTime timeStamp;

  const Institution({
    required this.i_id,
    required this.name,
    required this.textField,
    required this.timeStamp
  });

  Institution copyWith({
    String? i_id,
    String? name,
    String? textField,
    DateTime? timeStamp,
  }) {
    return Institution(
      i_id: i_id ?? this.i_id,
      name: name ?? this.name,
      textField: textField ?? this.textField,
      timeStamp: timeStamp ?? this.timeStamp,
    );
  }

  factory Institution.fromSnapshot(DataSnapshot snapshot) {
    final data = snapshot.value as Map?;
    final intTimestamp = data?['time_stamp'] as int?;
    final timestamp = intTimestamp != null && intTimestamp.abs() <= 8640000000000000
      ? DateTime.fromMillisecondsSinceEpoch(intTimestamp)
      : null;

    return Institution(
      i_id: data?['i_id'] as String? ?? '',
      name: data?['name'] as String? ?? '',
      textField: data?['text_field'] as String? ?? '',
      timeStamp: timestamp ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["i_id"] = i_id;
    data["name"] = name;
    data["text_field"] = textField;
    data["time_stamp"] = timeStamp.millisecondsSinceEpoch;
    return data;
  }
}