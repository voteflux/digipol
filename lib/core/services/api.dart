import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:voting_app/core/models/bill.dart';
import 'package:http/http.dart' as http;
import 'package:voting_app/core/models/bill_chain_data.dart';
import 'package:voting_app/core/models/bill_vote.dart';
import 'package:voting_app/core/models/bill_vote_success.dart';
import 'package:voting_app/core/models/issue.dart';
import 'package:voting_app/core/models/user.dart';

/// The service responsible for networking requests
class Api {
  var client = new http.Client();
  var endpoint = 'https://1j56c60pb0.execute-api.ap-southeast-2.amazonaws.com/';

  // get bills
  Future<List<Bill>> getBills() async {
    var bills = List<Bill>();

    var response = await client.get(endpoint + 'dev/bill');
    //var response = await rootBundle.loadString('assets/data/sample_bills.json');

    // parse into List
    var parsed = json.decode(response.body) as List<dynamic>;

    // loop and convert each item to bill
    for (var bill in parsed) {
      bills.add(Bill.fromJson(bill));
    }
    return bills;
  }

  // get bill
  Future<Bill> getBill(String id) async {
    var response = await client.get(endpoint + 'dev/bill/' + id);
    //var response = await rootBundle.loadString('assets/data/sample_bill.json');

    // parse into List
    var parsed = json.decode(response.body) as Map<String, dynamic>;

    return Bill.fromJson(parsed);
  }

  // get block chain data, will replace with function with actual blockchain call once ready
  Future<BillChainData> getBlockChainData(String id) async {
    var response = await client.get(endpoint + 'dev/shitchain/' + id);
    //var response = await rootBundle.loadString('assets/data/sample_bill.json');

    // parse into List
    var parsed = json.decode(response.body) as Map<String, dynamic>;

    return BillChainData.fromJson(parsed);
  }

  // get issues
  Future<List<Issue>> getIssues() async {
    var issues = List<Issue>();

    var response =
        await rootBundle.loadString('assets/data/sample_issues.json');

    var parsed = json.decode(response) as List<dynamic>;

    // loop and convert each item to issue
    for (var issue in parsed) {
      issues.add(Issue.fromJson(issue));
    }

    return issues;
  }

  // user login
  Future<User> getUser() async {
    var response = await rootBundle.loadString('assets/data/sample_user.json');

    print('complete user');
    return User.fromJson(json.decode(response));
  }

  Future<BillVoteSuccess> submitBillVote(BillVote vote) async {
    final http.Response response = await http.post(
      'https://1j56c60pb0.execute-api.ap-southeast-2.amazonaws.com/dev/shitchain/',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        "pub_key": vote.pubKey,
        "ballot_id": vote.ballotId,
        "ballotspec_hash": vote.ballotSpecHash,
        "constituency": vote.constituency,
        "vote": vote.vote
      }),
    );
    print('vote success');
    print(BillVoteSuccess.fromJson(json.decode(response.body)));
    if (response.statusCode == 200) {
      print(BillVoteSuccess.fromJson(json.decode(response.body)));
      return BillVoteSuccess.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed cast vote');
    }
  }
}
