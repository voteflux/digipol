import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:voting_app/core/models/bill.dart';
import 'package:http/http.dart' as http;
import 'package:voting_app/core/models/bill_chain_data.dart';
import 'package:voting_app/core/models/bill_vote.dart';
import 'package:voting_app/core/models/bill_vote_result.dart';
import 'package:voting_app/core/models/bill_vote_success.dart';
import 'package:voting_app/core/models/block_chain_data.dart';
import 'package:voting_app/core/models/issue.dart';
import 'package:voting_app/core/models/user.dart';

/// The service responsible for networking requests
class Api {
  var client = new http.Client();
  var endpoint = 'https://1j56c60pb0.execute-api.ap-southeast-2.amazonaws.com';

  // get bills
  Future syncData() async {
    Box<BlockChainData> blockChainData = Hive.box<BlockChainData>("block_chain_data");
    Box<Bill> billsBox = Hive.box<Bill>("bills");

    // clear box on startup and reSync
    blockChainData.clear();
    billsBox.clear();
    
    var response = await client.get(endpoint + '/dev/bill');
    var blockChainResponse = await client.get(endpoint + '/dev/shitchain');

   
    var parsed = json.decode(response.body) as List<dynamic>;
    var parsedBlockChainResponse = json.decode(blockChainResponse.body) as List<dynamic>;
    
    // parse blockchain into List
    for (var bill in parsedBlockChainResponse) {
      blockChainData.add(BlockChainData.fromJson(bill));
    }
    // parse api data into List
    for (var bill in parsed) {
      billsBox.add(Bill.fromJson(bill));
    }
   
    print(blockChainData.values.length);
    print(billsBox.values.length);
    return "bills";
  }

  // get bill
  Future<Bill> getBill(String id) async {
    var response = await client.get(endpoint + '/dev/bill/' + id);
    //var response = await rootBundle.loadString('assets/data/sample_bill.json');

    // parse into List
    var parsed = json.decode(response.body) as Map<String, dynamic>;

    return Bill.fromJson(parsed);
  }


  // get block chain data, will replace with function with actual blockchain call once ready
  Future<BillChainData> getBlockChainData(String id) async {
    var response = await client.get(endpoint + '/dev/shitchain/' + id);
    //var response = await rootBundle.loadString('assets/data/sample_bill.json');

    // parse into List
    var parsed = json.decode(response.body) as Map<String, dynamic>;

    return BillChainData.fromJson(parsed);
  }


  // get block chain data, will replace with function with actual blockchain call once ready
  Future<BillVoteResult> getBillResults(String id) async {
    var response = await client.get(endpoint + '/dev/result/' + id);
    //var response = await rootBundle.loadString('assets/data/sample_bill.json');

    // parse into List
    var parsed = json.decode(response.body) as Map<String, dynamic>;

    return BillVoteResult.fromJson(parsed);
  }


  //
  // get issues
  //
  Future<List<Issue>> getIssues() async {
    var issues = List<Issue>();

    var response = await client.get(endpoint + '/dev/issue');

    var parsed = json.decode(response.body) as List<dynamic>;

    // loop and convert each item to issue
    for (var issue in parsed) {
      issues.add(Issue.fromJson(issue));
    }

    return issues;
  }


  Future<Issue> getIssue(String id) async {

    var response = await client.get(endpoint + '/dev/issue/' + id);

    var parsed = json.decode(response.body) as Map<String, dynamic>;

    return Issue.fromJson(parsed);
  }


  //
  // user login
  //
  Future<User> getUser() async {
    var response = await rootBundle.loadString('assets/data/sample_user.json');

    print('complete user');
    return User.fromJson(json.decode(response));
  }
  
}
