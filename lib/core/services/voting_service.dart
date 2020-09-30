import 'dart:core';
import 'dart:typed_data';

import 'package:convert/convert.dart' as convert;
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:voting_app/core/models/bill_vote.dart';
import 'package:voting_app/core/models/bill_vote_success.dart';
import 'package:voting_app/core/services/wallet.dart';
import 'package:web3dart/web3dart.dart';

import '../consts.dart';

const ABI_PATH = 'assets/contracts/voting.abi';
const CONTRACT_ADDRESS =
    '0xca733a39b72DA72078DBc1c642e6C3836C5b424E'; //'0x7B8068D32AA298158E838Fcd9a324B9810AE8333';
const VOTE_YES = 'yes';
const VOTE_NO = 'no';

class VotingService {
  WalletService walletService;

  VotingService(walletService) {
    this.walletService = walletService;
  }

  Future<DeployedContract> _getVotingContract() async {
    var abi = await _getAbi();
    return DeployedContract(ContractAbi.fromJson(abi, 'Voting'),
        EthereumAddress.fromHex(CONTRACT_ADDRESS));
  }

  Future<String> _getAbi() async {
    var abi = await rootBundle.loadString('assets/contracts/voting.json');
    return abi;
    //var abiFile = File(abi);
    //return (abiFile.readAsStringSync());
  }

  Future<String> submitVoteTransaction(String specHashStr, String value) async {
    var contract = await _getVotingContract();
    var list = convert.hex.decode(specHashStr);
    Uint8List specHash = Uint8List.fromList(list);

    ContractFunction voteFn;
    if (value.toLowerCase() == VOTE_YES) {
      voteFn = contract.function('voteYes');
    } else if (value.toLowerCase() == VOTE_NO) {
      voteFn = contract.function('voteNo');
    } else {
      throw Exception("Invalid vote value");
    }

    return walletService.sendTransaction(contract, voteFn, [specHash]);
  }

  Future<BillVoteSuccess> postVote(BillVote vote) async {
    //Box userBox = Hive.box("user_box");
    Box<BillVote> billVoteBox = Hive.box<BillVote>(HIVE_BILL_VOTE_BOX);

    // to delete
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(vote.ballotId, vote.vote);

    var txHash = await submitVoteTransaction(vote.ballotSpecHash, vote.vote);

    if (txHash != "") {
      print("Transaction hash " + txHash);
      billVoteBox.add(BillVote(ballotId: vote.ballotId, vote: vote.vote));
      return BillVoteSuccess(ballotspecHash: txHash);
    } else {
      throw Exception('Failed cast vote');
    }
  }
}
