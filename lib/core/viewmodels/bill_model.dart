import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:voting_app/core/enums/viewstate.dart';
import 'package:voting_app/core/models/bill.dart';
import 'package:voting_app/core/models/bill_chain_data.dart';
import 'package:voting_app/core/models/bill_vote.dart';
import 'package:voting_app/core/models/bill_vote_result.dart';
import 'package:voting_app/core/services/api.dart';
import 'package:voting_app/locator.dart';

import 'base_model.dart';

class BillModel extends BaseModel {
  Api _api = locator<Api>();

  Bill bill;
  BillChainData billChainData;
  BillVoteResult billVoteResult;
  Box<Bill> billsBox = Hive.box<Bill>("bills");
  Box<BillVote> billVoteBox = Hive.box<BillVote>("bill_vote_box");
  String _vote;
  String get getVote => _vote;

  Future getBill(String billID) async {
    setState(ViewState.Busy);
    billVoteResult = await _api.getBillResults(billID);
    hasVoted(billID);
    setState(ViewState.Idle);
  }

  Future hasVoted(String ballotId) async {
    List<BillVote> voteList =
        billVoteBox.values.where((bill) => bill.ballotId == ballotId).toList();

    var hasVoted;
    if(voteList.length > 0 ){
      hasVoted = voteList[0].vote;
    } else {
      hasVoted = null;
    }
    _vote = hasVoted;
    
    return hasVoted;
  }
}
