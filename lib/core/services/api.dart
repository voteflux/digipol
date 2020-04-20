import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:voting_app/core/models/bill.dart';
import 'package:http/http.dart' as http;
import 'package:voting_app/core/models/issue.dart';
import 'package:voting_app/core/models/user.dart';

/// The service responsible for networking requests
class Api {
  var client = new http.Client();

  // get bills
  Future<List<Bill>> getBills() async {
    var bills = List<Bill>();

    //var response = await client.get('http://localhost:3000/dev/bill');
    var response = await rootBundle.loadString('assets/data/sample_bills.json');

    // parse into List
    var parsed = json.decode(response) as List<dynamic>;

    // loop and convert each item to bill
    for (var bill in parsed) {
      bills.add(Bill.fromJson(bill));
    }
    return bills;
  }

  // get bill
  Future<Bill> getBill() async {
    
    //var response = await client.get('http://localhost:3000/dev/bill');
    var response = await rootBundle.loadString('assets/data/sample_bill.json');

    // parse into List
    var parsed = json.decode(response) as Bill;

    // loop and convert each item to bill
    return parsed;
  }

  // get issues
  Future<List<Issue>> getIssues() async {
    var issues = List<Issue>();

    var response = await rootBundle.loadString('assets/data/sample_issues.json');

    var parsed = json.decode(response) as List<dynamic>;

    // loop and convert each item to issue
    for (var issue in parsed) {
      issues.add(Issue.fromJson(issue));
    }

    print('complete issues');
    return issues;    
  }

  // user login
  Future<User> getUser() async {
    var response = await rootBundle.loadString('assets/data/sample_user.json');

    print('complete user');
    return User.fromJson(json.decode(response));    
  }
}
