import 'package:hive/hive.dart';
import 'package:web3dart/web3dart.dart';

part 'bill_vote.g.dart';

@HiveType(typeId: 5)
class BillVote {
  @HiveField(0)
  String id;
  @HiveField(1)
  EthereumAddress ethAddrHex;
  @HiveField(2)
  String ballotId;
  @HiveField(3)
  String ballotSpecHash;
  @HiveField(4)
  String constituency;
  @HiveField(5)
  String vote;

  BillVote(
      {required this.id,
      required this.ethAddrHex,
      required this.ballotId,
      required this.ballotSpecHash,
      required this.constituency,
      required this.vote});

  factory BillVote.fromJson(Map<String, dynamic> json) {
    return BillVote(
      id: json['_id'] as String,
      ethAddrHex: EthereumAddress.fromHex(json['ethAddrHex'] as String,
          enforceEip55: true),
      ballotId: json['ballotId'] as String,
      ballotSpecHash: json['ballotSpecHash'] as String,
      constituency: json['constituency'] as String,
      vote: json['vote'] as String,
    );
  }
}
