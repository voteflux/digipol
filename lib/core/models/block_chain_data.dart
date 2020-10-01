import 'dart:core';

import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:voting_app/core/models/bill_chain_data.dart';

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
      {@required this.id,
      @required this.question,
      @required this.shortTitle,
      @required this.ballotSpecHash,
      @required this.chamber,
      @required this.sponsor,
      @required this.startDate});

  BillChainData toBillChainData() {
    return BillChainData(
        id: this.id,
        ballotSpecHash: this.ballotSpecHash,
        question: this.question,
        shortTitle: this.shortTitle);
  }

  factory BlockChainData.fromJson(Map<String, dynamic> json) {
    return BlockChainData(
      id: json['_id'] as String,
      question: json['data']['question'] as String,
      shortTitle: json['data']['short_title'] as String,
      chamber: json['data']['chamber'] as String,
      sponsor: json['data']['sponsor'] as String,
      startDate: json['data']['start_date'] as String,
      ballotSpecHash: json['ballotspec_hash'] as String,
    );
  }
}
