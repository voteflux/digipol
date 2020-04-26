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

  Future getBill(String billID) async {
    setState(ViewState.Busy);
    
    // get bill data
    bill = await _api.getBill(billID);

    //block chain call, currently calling shitchain
    billChainData = await _api.getBlockChainData(billID); 

    billVoteResult  = await _api.getBillResults(billID); 

    setState(ViewState.Idle);
  }
}