import 'package:voting_app/core/enums/viewstate.dart';
import 'package:voting_app/core/models/bill_vote.dart';
import 'package:voting_app/core/models/bill_vote_success.dart';
import 'package:voting_app/core/services/api.dart';
import 'package:voting_app/locator.dart';

import 'base_model.dart';

class BillVoteModel extends BaseModel {
  Api _api = locator<Api>();

  BillVoteSuccess success;

  Future postVote(BillVote vote) async {
    print("vote");
    setState(ViewState.Busy);
    success = await _api.submitBillVote(vote);
    print(success);
    print("vote");
    setState(ViewState.Idle);
  }
}