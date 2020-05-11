// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'issue.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class IssueAdapter extends TypeAdapter<Issue> {
  @override
  final typeId = 3;

  @override
  Issue read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Issue(
      chamber: fields[0] as String,
      shortTitle: fields[1] as String,
      startDate: fields[2] as String,
      endDate: fields[3] as String,
      id: fields[4] as String,
      question: fields[5] as String,
      description: fields[6] as String,
      sponsor: fields[7] as String,
      yes: fields[8] as int,
      no: fields[9] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Issue obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.chamber)
      ..writeByte(1)
      ..write(obj.shortTitle)
      ..writeByte(2)
      ..write(obj.startDate)
      ..writeByte(3)
      ..write(obj.endDate)
      ..writeByte(4)
      ..write(obj.id)
      ..writeByte(5)
      ..write(obj.question)
      ..writeByte(6)
      ..write(obj.description)
      ..writeByte(7)
      ..write(obj.sponsor)
      ..writeByte(8)
      ..write(obj.yes)
      ..writeByte(9)
      ..write(obj.no);
  }
}
