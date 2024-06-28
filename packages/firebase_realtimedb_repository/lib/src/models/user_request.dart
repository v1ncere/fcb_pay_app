class UserRequest {
  const UserRequest({
    this.keyId,
    required this.dataRequest,
    required this.extraData,
    required this.ownerId,
    required this.timeStamp
  });
  final String? keyId;
  final String dataRequest;
  final String? extraData;
  final String ownerId;
  final DateTime timeStamp;

  UserRequest copyWith({
    String? keyId,
    String? dataRequest,
    String? extraData,
    String? ownerId,
    DateTime? timeStamp,
  }) {
    return UserRequest(
      keyId: keyId ?? this.keyId,
      dataRequest: dataRequest ?? this.dataRequest,
      extraData: extraData ?? this.extraData,
      ownerId: ownerId ?? this.ownerId,
      timeStamp: timeStamp ?? this.timeStamp,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['data_request'] = dataRequest;
    data['extra_data'] = extraData;
    data['owner_id'] = ownerId;
    data['time_stamp'] = timeStamp.millisecondsSinceEpoch;
    return data;
  }
}