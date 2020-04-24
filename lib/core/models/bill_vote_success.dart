class BillVoteSuccess {
  String hash;

  BillVoteSuccess(
      {this.hash});

  BillVoteSuccess.fromJson(Map<String, dynamic> json) {
    hash = json['hash'];
  }
}
