import 'package:firebase_database/firebase_database.dart';

class UserRequest {
  const UserRequest({
    this.keyId,
    required this.dataRequest,
    required this.ownerId,
    required this.timeStamp
  });
  final String? keyId;
  final String dataRequest;
  final String ownerId;
  final DateTime timeStamp;

  UserRequest copyWith({
    String? keyId,
    String? dataRequest,
    String? ownerId,
    DateTime? timeStamp,
  }) {
    return UserRequest(
      keyId: keyId ?? this.keyId,
      dataRequest: dataRequest ?? this.dataRequest,
      ownerId: ownerId ?? this.ownerId,
      timeStamp: timeStamp ?? this.timeStamp,
    );
  }

  factory UserRequest.fromSnapshot(DataSnapshot snapshot) {
    final data = snapshot.value as Map?;

    final intTimestamp = data?['time_stamp'] as int?;
    final _timeStamp = intTimestamp != null && intTimestamp.abs() <= 9999999999999
    ? DateTime.fromMillisecondsSinceEpoch(intTimestamp)
    : null;

    return UserRequest(
      keyId: snapshot.key,
      dataRequest: data?['data_request'] as String? ?? '',
      ownerId: data?['owner_id'] as String? ?? '',
      timeStamp: _timeStamp ?? DateTime.now()
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['data_request'] = dataRequest;
    data['owner_id'] = ownerId;
    data['time_stamp'] = timeStamp.millisecondsSinceEpoch;
    return data;
  }
}