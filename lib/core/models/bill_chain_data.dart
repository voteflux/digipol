class BillChainData {
  String id;
  String shortTitle;
  String ballotSpecHash;

  BillChainData({
    this.id,
    this.shortTitle,
    this.ballotSpecHash,
  });

  BillChainData.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    shortTitle = json['data']['short_title'];
    ballotSpecHash = json['ballotspec_hash'];
  }
}
