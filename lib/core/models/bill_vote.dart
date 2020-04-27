class BillVote {
  String id;
  String pubKey;
  String ballotId;
  String ballotSpecHash;
  String constituency;
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
