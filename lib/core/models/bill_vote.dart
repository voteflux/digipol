import 'package:hive/hive.dart';
part 'bill_vote.g.dart';

@HiveType(typeId: 5)
class BillVote {
  @HiveField(0)
  String id;
  @HiveField(1)
  String pubKey;
  @HiveField(2)
  String ballotId;
  @HiveField(3)
  String ballotSpecHash;
  @HiveField(4)
  String constituency;
  @HiveField(5)
  String vote;

  BillVote(
      {this.id,
      this.pubKey,
      this.ballotId,
      this.ballotSpecHash,
      this.constituency,
      this.vote});

  BillVote.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
  }
}
