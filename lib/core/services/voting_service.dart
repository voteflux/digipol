import 'dart:io';
import 'dart:typed_data';
import 'dart:core';

import 'package:convert/convert.dart' as convert;
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:voting_app/core/models/bill_vote.dart';
import 'package:voting_app/core/models/bill_vote_success.dart';
import 'package:web3dart/web3dart.dart';
import 'package:voting_app/core/services/wallet.dart';

const ABI_PATH = './assets/contracts/voting.abi';
const CONTRACT_ADDRESS = '0x7B8068D32AA298158E838Fcd9a324B9810AE8333';
const VOTE_YES = 'yes';
const VOTE_NO = 'no';

class VotingService {
  WalletService walletService;

  VotingService({this.walletService});

  Future<DeployedContract> _getVotingContract() async {
    var abi = await _getAbi();
    return DeployedContract(ContractAbi.fromJson(abi, 'Voting'),
        EthereumAddress.fromHex(CONTRACT_ADDRESS));
  }

  Future<String> _getAbi() async {
    var abiFile = File(ABI_PATH);
    return (abiFile.readAsStringSync());
  }

  /*WalletService _getWalletService() {
    return WalletService('.');
  }*/

  Future<String> submitVoteTransaction(String specHashStr, String value) async {
    var contract = await _getVotingContract();
    var list = convert.hex.decode(specHashStr);
    Uint8List specHash = Uint8List.fromList(list);
    print(list.length);
    print(specHash.lengthInBytes);

    var proposalIdResult = await walletService.call(
      contract,
      contract.function('getProposalId'),
      [specHash],
    );
    BigInt proposalId;
    if (proposalIdResult.length == 1) {
      proposalId = proposalIdResult[0];
    } else {
      throw Exception("No proposal ID found");
    }
    print("ProposalID " + proposalId.toString());

    ContractFunction voteFn;
    if (value.toLowerCase() == VOTE_YES) {
      voteFn = contract.function('voteYes');
    } else if (value.toLowerCase() == VOTE_NO) {
      voteFn = contract.function('noteNo');
    } else {
      throw Exception("Invalid vote value");
    }

    return walletService.sendTransaction(contract, voteFn, [proposalId]);
  }

  Future<BillVoteSuccess> postVote(BillVote vote) async {
    //Box userBox = Hive.box("user_box");
    Box<BillVote> billVoteBox = Hive.box<BillVote>("bill_vote_box");
    //final ethereumAddress = userBox.get('ethereumAddress') ?? null;

    // to delete
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(vote.ballotId, vote.vote);

    /*var body = json.encode(<String, dynamic>{
      "pub_key": ethereumAddress,
      "ballot_id": vote.ballotId,
      "ballotspec_hash": vote.ballotSpecHash,
      "constituency": vote.constituency,
      "vote": vote.vote,
    });*/

    var txHash = await submitVoteTransaction(vote.ballotSpecHash, vote.vote);

    /*final http.Response response = await http.post(
      'https://1j56c60pb0.execute-api.ap-southeast-2.amazonaws.com/dev/shitchain/',
      headers: <String, String>{
        'Content-Type': 'application/json',
        "accept": "application/json",
      },
      body: body,
    );*/

    if (txHash != "") {
      print("Transaction hash " + txHash);
      billVoteBox.add(BillVote(ballotId: vote.ballotId, vote: vote.vote));
      //print(billVoteBox.getAt(0).ballotId.toString());
      return BillVoteSuccess(ballotspecHash: vote.ballotSpecHash);
    } else {
      throw Exception('Failed cast vote');
    }
  }
}
