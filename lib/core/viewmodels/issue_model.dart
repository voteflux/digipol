import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:voting_app/core/enums/viewstate.dart';
import 'package:voting_app/core/models/bill_vote_result.dart';
import 'package:voting_app/core/models/issue.dart';
import 'package:voting_app/core/services/api.dart';
import 'package:voting_app/locator.dart';

import 'base_model.dart';

@injectable
class IssueModel extends BaseModel {
  final Api _api = locator<Api>();

  /*late*/ Issue issue;
  /*late*/ BillVoteResult billVoteResult;

  /*late*/ String _vote;
  String get getVote => _vote;

  IssueModel();
  // this.issue, this.billVoteResult, this._vote

  Future getIssue(String issueId) async {
    setState(ViewState.Busy);
    print(issueId);
    billVoteResult = await _api.getBillResults(issueId);
    hasVoted(issueId);
    setState(ViewState.Idle);
  }

  Future hasVoted(String ballotId) async {
    final prefs = await SharedPreferences.getInstance();
    final vote = prefs.getString(ballotId);
    this._vote = vote;
    return vote;
  }
}
