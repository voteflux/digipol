import 'dart:convert';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:voting_app/core/models/bill_vote.dart';
import 'package:voting_app/core/models/bill_vote_success.dart';
import 'package:voting_app/core/models/user.dart';

class VotingService {
  Future<BillVoteSuccess> postVote(BillVote vote) async {
    

    Box<User> userBox = Hive.box<User>("user_box");
    Box<BillVote> billVoteBox = Hive.box<BillVote>("bill_vote_box");
    final ethereumAddress = userBox.getAt(0).ethereumAddress.toString() ?? null;

    // to delete
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(vote.ballotId, vote.vote);

    var body = json.encode(<String, dynamic>{
      "pub_key": ethereumAddress,
      "ballot_id": vote.ballotId,
      "ballotspec_hash": vote.ballotSpecHash,
      "constituency": vote.constituency,
      "vote": vote.vote
    });

    final http.Response response = await http.post(
      'https://1j56c60pb0.execute-api.ap-southeast-2.amazonaws.com/dev/shitchain/',
      headers: <String, String>{
        'Content-Type': 'application/json',
        "accept": "application/json",
      },
      body: body,
    );

    if (response.statusCode == 200) {
      billVoteBox.add(BillVote(ballotId: vote.ballotId, vote: vote.vote));
      print(billVoteBox.getAt(0).ballotId.toString());
      return BillVoteSuccess.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed cast vote');
    }
  }
}