// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bill_vote.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BillVoteAdapter extends TypeAdapter<BillVote> {
  @override
  final int typeId = 5;

  @override
  BillVote read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BillVote(
      id: fields[0] as String,
      ethAddrHex: fields[1] as EthereumAddress,
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
      ..write(obj.ethAddrHex)
      ..writeByte(2)
      ..write(obj.ballotId)
      ..writeByte(3)
      ..write(obj.ballotSpecHash)
      ..writeByte(4)
      ..write(obj.constituency)
      ..writeByte(5)
      ..write(obj.vote);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BillVoteAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
