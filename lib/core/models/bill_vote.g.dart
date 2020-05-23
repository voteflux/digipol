// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bill_vote.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BillVoteAdapter extends TypeAdapter<BillVote> {
  @override
  final typeId = 5;

  @override
  BillVote read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BillVote(
      id: fields[0] as String,
      pubKey: fields[1] as String,
      ballotId: fields[2] as String,
      ballotSpecHash: fields[3] as String,
      constituency: fields[4] as String,
      vote: fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, BillVote obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.pubKey)
      ..writeByte(2)
      ..write(obj.ballotId)
      ..writeByte(3)
      ..write(obj.ballotSpecHash)
      ..writeByte(4)
      ..write(obj.constituency)
      ..writeByte(5)
      ..write(obj.vote);
  }
}
