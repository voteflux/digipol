class BillChainData {
  String id;
  String question;
  String shortTitle;
  String ballotSpecHash;

  BillChainData({
    required this.id,
    required this.question,
    required this.shortTitle,
    required this.ballotSpecHash,
  });

  factory BillChainData.fromJson(Map<String, dynamic> json) {
    return BillChainData(
      id: json['_id'] as String,
      question: json['data']['question'] as String,
      shortTitle: json['data']['short_title'] as String,
      ballotSpecHash: json['ballotspec_hash'] as String,
    );
  }
}
