class BillChainData {
  String id;
  String question;
  String shortTitle;
  String ballotSpecHash;

  BillChainData({
    this.id,
    this.question,
    this.shortTitle,
    this.ballotSpecHash,
  });

  BillChainData.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    question = json['data']['question'];
    shortTitle = json['data']['short_title'];
    ballotSpecHash = json['ballotspec_hash'];
  }
}
