import 'package:voting_app/core/enums/viewstate.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:voting_app/core/models/bill.dart';
import 'package:http/http.dart' as http;
import 'package:voting_app/core/models/bill_vote.dart';
import 'package:voting_app/core/models/bill_vote_success.dart';
import 'package:voting_app/core/services/api.dart';
import 'package:voting_app/locator.dart';

import 'base_model.dart';

class BillVoteModel extends BaseModel {
  Api _api = locator<Api>();

  BillVoteSuccess success;

  Future<BillVoteSuccess> postVote(BillVote vote) async {
    print('vote start');
    final http.Response response = await http.post(
      'https://1j56c60pb0.execute-api.ap-southeast-2.amazonaws.com/dev/shitchain/',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "pub_key": vote.pubKey,
        "ballot_id": vote.ballotId,
        "ballotspec_hash": vote.ballotSpecHash,
        "constituency": vote.constituency,
        "vote": vote.vote
      }),
    );
    print(response);
    if (response.statusCode == 200) {
      print(BillVoteSuccess.fromJson(json.decode(response.body)));
      return BillVoteSuccess.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed cast vote');
    }
  }
}