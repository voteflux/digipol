import 'dart:convert';
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:math';

Future<bool> checkVoted(
  String voteType,
  String id,
  String uid,
) async {
  print("Checking Vote");
  final Random random = new Random();
  if (random.nextInt(5) == 0) {
    return true;
  } else {
    return false;
  }
}

Future<String> makeVote(
  String voteType,
  String id,
  String uid,
) async {
  print("Vote made");
  String receipt;
  receipt = "7FN09SD8F7NSDF654N98N7F98434C98N27DJJDMAWJHCQCN48";
  Future.delayed(const Duration(milliseconds: 2000), () {
    return receipt;
  });
}

Future<String> checkVerified(String receipt) async {
  String blockHash =
      "QOLC84983J546KL6J85GHC9ERYFQIY3049F7HBC932OSKMQOWDONRTY84";
  Future.delayed(const Duration(milliseconds: 10000), () {
    return blockHash;
  });
}
