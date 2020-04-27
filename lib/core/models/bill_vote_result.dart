class BillVoteResult {
  String id;
  String constituency;
  int no;
  int yes;

  BillVoteResult({
    this.id,
    this.constituency,
    this.yes, this.no,
  });

  BillVoteResult.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    constituency = json['data']['constituency'];
    yes = json['data']['yes'];
    no = json['data']['no'];
  }
}
