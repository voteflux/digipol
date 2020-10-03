import 'dart:core';
import 'dart:typed_data';

import 'package:convert/convert.dart' as convert;
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:voting_app/core/funcs/null_stuff.dart';
import 'package:voting_app/core/models/bill_vote.dart';
import 'package:voting_app/core/models/bill_vote_success.dart';
import 'package:voting_app/core/services/wallet.dart';
import 'package:web3dart/web3dart.dart';

import '../consts.dart';

const ABI_PATH = 'assets/contracts/voting.abi';
const DEFAULT_VOTING_CONTRACT_ADDR =
    '0xca733a39b72DA72078DBc1c642e6C3836C5b424E'; //'0x7B8068D32AA298158E838Fcd9a324B9810AE8333';
const VOTE_YES = 'yes';
const VOTE_NO = 'no';

@lazySingleton
class VotingService {
  WalletService walletService;
  String _contractAddress = DEFAULT_VOTING_CONTRACT_ADDR;

  String get contractAddress => _contractAddress;
  void set contractAddress(String _c) {
    contractAddress = _c;
  }

  VotingService({@required this.walletService}) {}

  Future<DeployedContract> _getVotingContract() async {
    var abi = await _getAbi();
    return DeployedContract(ContractAbi.fromJson(abi, 'Voting'),
        EthereumAddress.fromHex(this.contractAddress));
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

    return walletService.sendTransaction(
        contract, voteFn, [specHash] as List<dynamic>);
  }

  Future<BillVoteSuccess> postVote(BillVote vote) async {
    Box<BillVote> billVoteBox = Hive.box<BillVote>(HIVE_BILL_VOTE_BOX);

    var ethAddr = await this.walletService.ethereumAddress();

    // to delete
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(vote.ballotId, vote.vote);

    var _bsh = nullToE(
        vote.ballotSpecHash, "BallotSpecHash is null (and shouldn't be).");
    var _vv = nullToE(vote.vote, "Vote object is null (and shouldn't be)");
    var afterTx = await Either.sequenceFuture(_bsh
        .bind((String bsh) => _vv.map((vv) => Tuple2(bsh, vv) as TxInputs))
        .map(this.sendTxAndGetHash));
    var atx2 = afterTx.bind((e) => e).map((var t3) async {
      await billVoteBox.add(BillVote(
          id: billVoteBox.length.toString(),
          ballotId: vote.ballotId,
          vote: t3.value2,
          ballotSpecHash: t3.value1,
          ethAddrHex: ethAddr,
          constituency: vote.constituency));
      return t3;
    });
    return (await Either.sequenceFuture(atx2)).fold(
        (l) => throw Exception("Vote broadcast failed. Error: ${l}"),
        (r) => BillVoteSuccess(ballotspecHash: r.value1));
  }

  Future<Either<String, AfterTx>> sendTxAndGetHash<T>(TxInputs t2) async {
    String txHash = await submitVoteTransaction(t2.value1, t2.value2);
    if (txHash == "") {
      return Left("txHash was empty when submitting vote transaction!");
    }
    return Right(Tuple3(t2.value1, t2.value2, txHash) as AfterTx);
  }
}

mixin ToAlias {}

class TxInputs = Tuple2<String, String> with ToAlias;
class AfterTx = Tuple3<String, String, String> with ToAlias;
