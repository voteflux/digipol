import 'dart:async';
import 'dart:convert';
import 'package:hive/hive.dart';
import 'package:voting_app/core/models/bill.dart';
import 'package:http/http.dart' as http;
import 'package:voting_app/core/models/bill_vote_result.dart';
import 'package:voting_app/core/models/block_chain_data.dart';
import 'package:voting_app/core/models/issue.dart';

// The service responsible for networking requests
class Api {
  var client = new http.Client();
  var endpoint = 'https://1j56c60pb0.execute-api.ap-southeast-2.amazonaws.com';

  Box<BlockChainData> blockChainData =
      Hive.box<BlockChainData>("block_chain_data");
  Box<Bill> billsBox = Hive.box<Bill>("bills");
  Box<Issue> issuesBox = Hive.box<Issue>("issues");

  // get bills
  Future syncData() async {
    // clear box on startup and reSync
    blockChainData.clear();
    billsBox.clear();
    issuesBox.clear();

    // populate boxes
    await getBlockChainData();
    await getIssues();
    await getBills();

    return print("synced Blockchain, Bills, Issues");
  }

  //
  // get data from BlockChain and store in box
  //
  Future getBlockChainData() async {
    var response = await client.get(endpoint + '/dev/shitchain');
    var parsed = json.decode(response.body) as List<dynamic>;

    for (var bill in parsed) {
      blockChainData.add(BlockChainData.fromJson(bill));
    }

    return print(
        blockChainData.values.length.toString() + " ballotspecs in box");
  }

  //
  // get & parse bills
  //
  Future getBills() async {
    var response = await client.get(endpoint + '/dev/bill');
    var parsed = json.decode(response.body) as List<dynamic>;

    for (var bill in parsed) {
      billsBox.add(Bill.fromJson(bill));
    }

    return print(billsBox.values.length.toString() + " bills put in Box");
  }

  //
  // get & parse issues
  //
  Future getIssues() async {
    var response = await client.get(endpoint + '/dev/issue');
    var parsed = json.decode(response.body) as List<dynamic>;

    for (var issue in parsed) {
      issuesBox.add(Issue.fromJson(issue));
    }

    return print(issuesBox.values.length.toString() + " issues put in Box");
  }

  //
  // get vote data, will replace with function with actual blockchain call once ready
  //
  Future<BillVoteResult> getBillResults(String id) async {
    var response = await client.get(endpoint + '/dev/result/' + id);
    //var response = await rootBundle.loadString('assets/data/sample_bill.json');

    // parse into List
    var parsed = json.decode(response.body) as Map<String, dynamic>;

    return BillVoteResult.fromJson(parsed);
  }
}
