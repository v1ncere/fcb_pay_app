// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'server_reply.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ServerReplyAdapter extends TypeAdapter<ServerReply> {
  @override
  final int typeId = 1;

  @override
  ServerReply read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ServerReply(
      dataReply: fields[0] as String,
      ownerId: fields[1] as String,
      tag: fields[2] as String,
      timeStamp: fields[3] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, ServerReply obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.dataReply)
      ..writeByte(1)
      ..write(obj.ownerId)
      ..writeByte(2)
      ..write(obj.tag)
      ..writeByte(3)
      ..write(obj.timeStamp);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ServerReplyAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
