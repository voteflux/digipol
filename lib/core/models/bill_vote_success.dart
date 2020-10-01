import 'package:flutter/foundation.dart';

class BillVoteSuccess {
  String ballotspecHash;

  BillVoteSuccess({@required this.ballotspecHash});

  factory BillVoteSuccess.fromJson(Map<String, dynamic> json) {
    var val = json['data']['ballotspec_hash'] as String;
    return BillVoteSuccess(ballotspecHash: val);
  }
}
