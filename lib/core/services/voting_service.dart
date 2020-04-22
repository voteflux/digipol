import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:voting_app/core/models/bill_vote.dart';

Future submitBillVote(BillVote vote) async {
  final http.Response response = await http.post(
    'http://localhost:3000/dev/shitchain/',
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
  if (response.statusCode == 201) {
    return print(response);
  } else {
    throw Exception('Failed cast vote');
  }
}
