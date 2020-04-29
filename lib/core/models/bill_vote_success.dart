class BillVoteSuccess {
  String ballotspecHash;

  BillVoteSuccess({this.ballotspecHash});

  factory BillVoteSuccess.fromJson(Map<String, dynamic> json) {
    return BillVoteSuccess(ballotspecHash: json['data']['ballotspec_hash']);
  }
}
