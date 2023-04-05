import 'package:firebase_database/firebase_database.dart';

class HomeDisplay  {
  final String displayData;
  final String ownerId;
  final DateTime timeStamp;

  const HomeDisplay({
    required this.displayData,
    required this.ownerId,
    required this.timeStamp,
  });

  HomeDisplay copyWith({
    String? displayData,
    String? ownerId,
    DateTime? timeStamp,
  }) {
    return HomeDisplay(
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