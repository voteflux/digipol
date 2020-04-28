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

  Future getIssue(String issueId) async {
    setState(ViewState.Busy);
    print(issueId);
    // get bill data
    issue = await _api.getIssue(issueId);

    //block chain call, currently calling shitchain
    billChainData = await _api.getBlockChainData(issueId); 

    billVoteResult  = await _api.getBillResults(issueId); 

    setState(ViewState.Idle);
  }
}