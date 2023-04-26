import 'package:firebase_database/firebase_database.dart';

class HomeDisplay  {
  String? keyId;
  final String displayData;
  final String ownerId;
  final DateTime timeStamp;

  HomeDisplay({
    this.keyId,
    required this.displayData,
    required this.ownerId,
    required this.timeStamp,
  });

  HomeDisplay copyWith({
    String? keyId,
    String? displayData,
    String? ownerId,
    DateTime? timeStamp,
  }) {
    return HomeDisplay(
      keyId: keyId ?? this.keyId,
      displayData: displayData ?? this.displayData,
      ownerId: ownerId ?? this.ownerId,
      timeStamp: timeStamp ?? this.timeStamp
    );
  }

  factory HomeDisplay.fromSnapshot(DataSnapshot snapshot) {
    final data = snapshot.value as Map?;
    final intTimestamp = data?['time_stamp'] as int?;
    final timestamp = intTimestamp != null && intTimestamp.abs() <= 8640000000000000
      ? DateTime.fromMillisecondsSinceEpoch(intTimestamp) 
      : null;

    return HomeDisplay(
      keyId: snapshot.key,
      displayData: data?['display_data'] as String? ?? '',
      ownerId: data?['owner_id'] as String? ?? '',
      timeStamp: timestamp ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["display_data"] = displayData;
    data["owner_id"] = ownerId;
    data["time_stamp"] = timeStamp;
    return data;
  }
}