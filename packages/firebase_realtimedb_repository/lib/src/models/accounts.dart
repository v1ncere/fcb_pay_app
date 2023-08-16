import 'package:firebase_database/firebase_database.dart';

class Accounts {
  Accounts({
    this.keyId,
    required this.displayData,
    required this.ownerId,
    required this.timeStamp,
  });

  String? keyId;
  final String displayData;
  final String ownerId;
  final DateTime timeStamp;

  Accounts copyWith({
    String? keyId,
    String? displayData,
    String? ownerId,
    DateTime? timeStamp,
  }) {
    return Accounts(
      keyId: keyId ?? this.keyId,
      displayData: displayData ?? this.displayData,
      ownerId: ownerId ?? this.ownerId,
      timeStamp: timeStamp ?? this.timeStamp
    );
  }

  factory Accounts.fromSnapshot(DataSnapshot snapshot) {
    final data = snapshot.value as Map?;
    final intTimestamp = data?['time_stamp'] as int?;
    final timestamp = intTimestamp != null && intTimestamp.abs() <= 9999999999999
    ? DateTime.fromMillisecondsSinceEpoch(intTimestamp)
    : null;

    return Accounts(
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