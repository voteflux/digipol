// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hiveBill.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HivebillAdapter extends TypeAdapter<Hivebill> {
  @override
  final typeId = 0;

  @override
  Hivebill read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Hivebill(
      id: fields[0] as String,
      chamber: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Hivebill obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.chamber);
  }
}
