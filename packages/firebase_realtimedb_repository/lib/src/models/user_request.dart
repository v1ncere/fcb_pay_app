import 'package:firebase_database/firebase_database.dart';

class UserRequest {
  final String dataRequest;
  final String ownerId;
  final DateTime timeStamp;

  const UserRequest({
    required this.dataRequest,
    required this.ownerId,
    required this.timeStamp
  });

  UserRequest copyWith({
    String? dataRequest,
    String? ownerId,
    DateTime? timeStamp,
  }) {
    return UserRequest(
      dataRequest: dataRequest ?? this.dataRequest,
      ownerId: ownerId ?? this.ownerId,
      timeStamp: timeStamp ?? this.timeStamp,
    );
  }

  factory UserRequest.fromSnapshot(DataSnapshot snapshot) {
    final data = snapshot.value as Map?;
    final intTimestamp = data?['time_stamp'] as int?;
    final timestamp = intTimestamp != null && intTimestamp.abs() <= 8640000000000000
      ? DateTime.fromMillisecondsSinceEpoch(intTimestamp) 
      : null;

    return UserRequest(
      dataRequest: data?['data_request'] as String? ?? '',
      ownerId: data?['owner_id'] as String? ?? '',
      timeStamp: timestamp ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["data_request"] = dataRequest;
    data["owner_id"] = ownerId;
    data["time_stamp"] = timeStamp.millisecondsSinceEpoch;
    return data;
  }
}