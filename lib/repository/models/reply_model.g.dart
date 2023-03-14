// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reply_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ReplyModelAdapter extends TypeAdapter<ReplyModel> {
  @override
  final int typeId = 1;

  @override
  ReplyModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ReplyModel(
      dataReply: fields[0] as String,
      ownerId: fields[1] as String,
      timeStamp: fields[2] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, ReplyModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.dataReply)
      ..writeByte(1)
      ..write(obj.ownerId)
      ..writeByte(2)
      ..write(obj.timeStamp);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ReplyModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
