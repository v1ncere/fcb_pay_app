
import 'package:firebase_database/firebase_database.dart';
import 'package:hive_flutter/adapters.dart';

part 'request_model.g.dart';

@HiveType(typeId: 2)
class RequestModel {
  @HiveField(0)
  final String dataRequest;
  @HiveField(1)
  final String ownerId;
  @HiveField(2)
  final DateTime timeStamp;

  const RequestModel({
    required this.dataRequest,
    required this.ownerId,
    required this.timeStamp
  });

  RequestModel copyWith({
    String? dataRequest,
    String? ownerId,
    DateTime? timeStamp,
  }) {
    return RequestModel(
      dataRequest: dataRequest ?? this.dataRequest,
      ownerId: ownerId ?? this.ownerId,
      timeStamp: timeStamp ?? this.timeStamp,
    );
  }

  RequestModel.fromDataSnapshot(DataSnapshot snapshot) 
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
}