import 'package:equatable/equatable.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:hive_flutter/adapters.dart';

part 'reply_model.g.dart';

@HiveType(typeId: 1)
class ReplyModel extends Equatable {
  @HiveField(0)
  final String dataReply;
  @HiveField(1)
  final String ownerId;
  @HiveField(2)
  final DateTime timeStamp;

  const ReplyModel({
    required this.dataReply,
    required this.ownerId,
    required this.timeStamp,
  });

  ReplyModel copyWith({
    String? dataReply,
    String? ownerId,
    DateTime? timeStamp
  }) {
    return ReplyModel(
      dataReply: dataReply ?? this.dataReply,
      ownerId: ownerId ?? this.ownerId,
      timeStamp: timeStamp ?? this.timeStamp,
    );
  }

  ReplyModel.fromDataSnapshot(DataSnapshot snapshot)
    : dataReply = (snapshot.value as Map?)?["data_reply"] as String? ?? "",
      ownerId = (snapshot.value as Map?)?["owner_id"] as String? ?? "",
      timeStamp = (snapshot.value as Map?)?["time_stamp"] as DateTime? ?? DateTime.now();

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic> {};
      data["data_reply"] = dataReply;
      data["owner_id"] = ownerId;
      data["time_stamp"] = timeStamp;
    return data;
  }
  
  @override
  List<Object> get props => [dataReply, ownerId, timeStamp];
}