import 'dart:io';
import 'dart:convert';
//import 'dart:html';
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
//import 'package:connectivity/connectivity.dart';

/// Function to fetch the issues from the API
///
/// Returns a list of bill dicts
///
/// Usage:
///
/// `var b = await fetchIssues();`
Future<List> fetchIssues() async {
  final response = await http.get(
      'https://2hqxgjv66f.execute-api.ap-southeast-2.amazonaws.com/dev/bills');
  if (response.statusCode == 200) {
    final List listOfIssues = json.decode(response.body);
    return listOfIssues;
  } else {
    throw Exception('Failed to load issues');
  }
}

/// This is the Dev version of fetchIssues() while the CORS issue still needs to be fixed
Future<List> fetchIssuesDev() async {
  return ([
    {
      "Chamber": "Public",
      "Short Title": "Closing of Travel from Coronavirus Countries",
      "Start Date": "2019-07-22",
      "End Date": "2020-04-30",
      "id": "i0001",
      "Summary":
          "Should the Australian government look to limit travel from countries affected by Coronavirus?",
      "Description":
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
      "Sponsor": "Alexanda Great",
      "Yes": 9004,
      "No": 400,
    },
    {
      "Chamber": "Public",
      "Short Title": "GST on Sanitary Items",
      "Start Date": "2019-09-24",
      "End Date": "2020-07-30",
      "id": "i0001",
      "Summary":
          "Should the Australian government legislate to excluse Sanitary and Health items from the GST?",
      "Description":
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
      "Sponsor": "Health Lobby Group",
      "Yes": 8004,
      "No": 2070,
    },
    {
      "Chamber": "Public",
      "Short Title": "Legalise Weed",
      "Start Date": "2019-05-06",
      "End Date": "2020-08-30",
      "id": "i0001",
      "Summary":
          "Should the Australian government legalise recreational marijuana nationally?",
      "Description":
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
      "Sponsor": "Weed Lobby Group",
      "Yes": 5888,
      "No": 5123,
    },
    {
      "Chamber": "Public",
      "Short Title": "Independent Anti-corruption Commsion",
      "Start Date": "2019-05-01",
      "End Date": "2020-05-30",
      "id": "i0001",
      "Summary": "Should an independent Federal ICAC be created?",
      "Description":
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
      "Sponsor": "Freedom Lobby Group",
      "Yes": 9900,
      "No": 100,
    },
  ]);
}
