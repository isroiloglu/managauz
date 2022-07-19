// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'foto_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FotoHiveModelAdapter extends TypeAdapter<FotoHiveModel> {
  @override
  final int typeId = 1;

  @override
  FotoHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FotoHiveModel(
      id: fields[0] as int?,
      images: fields[1] as String?,
      type: fields[2] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, FotoHiveModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.images)
      ..writeByte(2)
      ..write(obj.type);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FotoHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
