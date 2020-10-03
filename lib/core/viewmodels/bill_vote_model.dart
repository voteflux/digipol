import 'package:injectable/injectable.dart';
import 'package:voting_app/core/models/bill_vote.dart';
import 'package:voting_app/core/models/bill_vote_success.dart';
import 'package:voting_app/core/services/voting_service.dart';
import 'package:voting_app/locator.dart';

import 'base_model.dart';

@injectable
class BillVoteModel extends BaseModel {
  final VotingService _votingService = locator<VotingService>();

  Future<BillVoteSuccess> postVote(BillVote vote) async {
    BillVoteSuccess billVoteSuccess = await _votingService.postVote(vote);
    return billVoteSuccess;
  }
}
