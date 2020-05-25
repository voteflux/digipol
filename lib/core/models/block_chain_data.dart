import 'package:hive/hive.dart';
part 'block_chain_data.g.dart';

@HiveType(typeId: 1)
class BlockChainData {
  @HiveField(0)
  String id;
  @HiveField(1)
  String question;
  @HiveField(2)
  String shortTitle;
  @HiveField(3)
  String chamber;
  @HiveField(4)
  String sponsor;
  @HiveField(5)
  String ballotSpecHash;
  @HiveField(6)
  String startDate;

  BlockChainData(
      {this.id,
      this.question,
      this.shortTitle,
      this.ballotSpecHash,
      this.chamber,
      this.sponsor,
      this.startDate});

  BlockChainData.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    question = json['data']['question'];
    shortTitle = json['data']['short_title'];
    chamber = json['data']['chamber'];
    sponsor = json['data']['sponsor'];
    startDate = json['data']['start_date'];
    ballotSpecHash = json['ballotspec_hash'];
  }
}
