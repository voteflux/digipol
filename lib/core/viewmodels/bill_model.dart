import 'package:shared_preferences/shared_preferences.dart';
import 'package:voting_app/core/enums/viewstate.dart';
import 'package:voting_app/core/models/bill.dart';
import 'package:voting_app/core/models/bill_chain_data.dart';
import 'package:voting_app/core/models/bill_vote_result.dart';
import 'package:voting_app/core/services/api.dart';
import 'package:voting_app/locator.dart';

import 'base_model.dart';

class BillModel extends BaseModel {
  Api _api = locator<Api>();

  Bill bill;
  BillChainData billChainData;
  BillVoteResult billVoteResult;

  String _vote;
  String get getVote => _vote;

  Future getBill(String billID) async {
    setState(ViewState.Busy);
    
    // get bill data
    bill = await _api.getBill(billID);

    //block chain call, currently calling shitchain
    billChainData = await _api.getBlockChainData(billID); 

    billVoteResult  = await _api.getBillResults(billID);

    hasVoted(billID);

    setState(ViewState.Idle);
  }

  Future hasVoted(String ballotId) async {
    final prefs = await SharedPreferences.getInstance();
    final vote = prefs.getString(ballotId) ?? null;
    _vote = vote;
    return vote;
  }
}