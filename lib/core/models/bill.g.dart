// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bill.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BillAdapter extends TypeAdapter<Bill> {
  @override
  final int typeId = 2;

  @override
  Bill read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Bill(
      id: fields[0] as String,
      chamber: fields[1] as String,
      shortTitle: fields[2] as String,
      question: fields[3] as String,
      introHouse: fields[4] as String,
      passedHouse: fields[5] as String,
      introSenate: fields[6] as String,
      passedSenate: fields[7] as String,
      assentDate: fields[8] as String,
      actNo: fields[9] as String,
      url: fields[10] as String,
      summary: fields[11] as String,
      sponsor: fields[12] as String,
      textLinkDoc: fields[13] as String,
      textLinkPdf: fields[14] as String,
      emLinkPdf: fields[15] as String,
      emLinkHtml: fields[16] as String,
      yes: fields[17] as int,
      no: fields[18] as int,
      portfolio: fields[19] as String,
      startDate: fields[20] as String,
      topics: (fields[21] as List)?.cast<dynamic>(),
    );
  }

  @override
  void write(BinaryWriter writer, Bill obj) {
    writer
      ..writeByte(22)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.chamber)
      ..writeByte(2)
      ..write(obj.shortTitle)
      ..writeByte(3)
      ..write(obj.question)
      ..writeByte(4)
      ..write(obj.introHouse)
      ..writeByte(5)
      ..write(obj.passedHouse)
      ..writeByte(6)
      ..write(obj.introSenate)
      ..writeByte(7)
      ..write(obj.passedSenate)
      ..writeByte(8)
      ..write(obj.assentDate)
      ..writeByte(9)
      ..write(obj.actNo)
      ..writeByte(10)
      ..write(obj.url)
      ..writeByte(11)
      ..write(obj.summary)
      ..writeByte(12)
      ..write(obj.sponsor)
      ..writeByte(13)
      ..write(obj.textLinkDoc)
      ..writeByte(14)
      ..write(obj.textLinkPdf)
      ..writeByte(15)
      ..write(obj.emLinkPdf)
      ..writeByte(16)
      ..write(obj.emLinkHtml)
      ..writeByte(17)
      ..write(obj.yes)
      ..writeByte(18)
      ..write(obj.no)
      ..writeByte(19)
      ..write(obj.portfolio)
      ..writeByte(20)
      ..write(obj.startDate)
      ..writeByte(21)
      ..write(obj.topics);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BillAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
