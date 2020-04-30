import 'package:shared_preferences/shared_preferences.dart';
import 'package:voting_app/core/enums/viewstate.dart';
import 'package:voting_app/core/models/bill.dart';
import 'package:voting_app/core/models/bill_chain_data.dart';
import 'package:voting_app/core/models/bill_vote_result.dart';
import 'package:voting_app/core/models/issue.dart';
import 'package:voting_app/core/services/api.dart';
import 'package:voting_app/locator.dart';

import 'base_model.dart';

class IssueModel extends BaseModel {
  Api _api = locator<Api>();

  Issue issue;
  BillChainData billChainData;
  BillVoteResult billVoteResult;

  String _vote;
  String get getVote => _vote;

  Future getIssue(String issueId) async {
    setState(ViewState.Busy);
    print(issueId);
    // get bill data
    issue = await _api.getIssue(issueId);

    //block chain call, currently calling shitchain
    billChainData = await _api.getBlockChainData(issueId);

    billVoteResult = await _api.getBillResults(issueId);

    hasVoted(issueId);

    setState(ViewState.Idle);
  }

  Future hasVoted(String ballotId) async {
    final prefs = await SharedPreferences.getInstance();
    final vote = prefs.getString(ballotId) ?? null;
    _vote = vote;
    return vote;
  }
}
