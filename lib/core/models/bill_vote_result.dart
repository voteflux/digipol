import 'package:flutter/foundation.dart';

class BillVoteResult {
  String id;
  String constituency;
  int no;
  int yes;

  BillVoteResult({
    @required this.id,
    @required this.constituency,
    @required this.yes,
    @required this.no,
  });

  factory BillVoteResult.fromJson(Map<String, dynamic> json) {
    return BillVoteResult(
      id: json['_id'] as String,
      constituency: json['data']['constituency'] as String,
      yes: json['data']['yes'] as int,
      no: json['data']['no'] as int,
    );
  }
}
