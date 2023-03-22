import 'package:equatable/equatable.dart';
import 'package:firebase_database/firebase_database.dart';

class UserRequest extends Equatable{
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

  UserRequest.fromDataSnapshot(DataSnapshot snapshot)
    : dataRequest = (snapshot.value as Map?)?["data_request"] as String? ?? "",
      ownerId = (snapshot.value as Map?)?["owner_id"] as String? ?? "",
      timeStamp = (snapshot.value as Map?)?["time_stamp"] as DateTime? ?? DateTime.now();

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["data_request"] = dataRequest;
    data["owner_id"] = ownerId;
    data["time_stamp"] = timeStamp;
    return data;
  }
  
  @override
  List<Object?> get props => [dataRequest, ownerId, timeStamp];
}