// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'block_chain_data.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BlockChainDataAdapter extends TypeAdapter<BlockChainData> {
  @override
  final typeId = 1;

  @override
  BlockChainData read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BlockChainData(
      id: fields[0] as String,
      question: fields[1] as String,
      shortTitle: fields[2] as String,
      ballotSpecHash: fields[5] as String,
      chamber: fields[3] as String,
      sponsor: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, BlockChainData obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.question)
      ..writeByte(2)
      ..write(obj.shortTitle)
      ..writeByte(3)
      ..write(obj.chamber)
      ..writeByte(4)
      ..write(obj.sponsor)
      ..writeByte(5)
      ..write(obj.ballotSpecHash);
  }
}
