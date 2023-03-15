import 'package:equatable/equatable.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:hive_flutter/adapters.dart';

part 'server_reply.g.dart';

@HiveType(typeId: 1)
class ServerReply extends Equatable {
  @HiveField(0)
  final String dataReply;
  @HiveField(1)
  final String ownerId;
  @HiveField(2)
  final String tag;
  @HiveField(3)
  final DateTime timeStamp;

  const ServerReply({
    required this.dataReply,
    required this.ownerId,
    required this.tag,
    required this.timeStamp,
  });

  ServerReply copyWith({
    String? dataReply,
    String? ownerId,
    String? tag,
    DateTime? timeStamp
  }) {
    return ServerReply(
      dataReply: dataReply ?? this.dataReply,
      ownerId: ownerId ?? this.ownerId,
      tag: tag ?? this.tag,
      timeStamp: timeStamp ?? this.timeStamp,
    );
  }

  ServerReply.fromDataSnapshot(DataSnapshot snapshot)
    : dataReply = (snapshot.value as Map?)?["data_reply"] as String? ?? "",
      ownerId = (snapshot.value as Map?)?["owner_id"] as String? ?? "",
      tag = (snapshot.value as Map?)?["tag"] as String? ?? "",
      timeStamp = (snapshot.value as Map?)?["time_stamp"] as DateTime? ?? DateTime.now();

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic> {};
    data["data_reply"] = dataReply;
    data["owner_id"] = ownerId;
    data["tag"] = tag;
    data["time_stamp"] = timeStamp;
    return data;
  }
  
  @override
  List<Object> get props => [dataReply, ownerId, tag, timeStamp];
}