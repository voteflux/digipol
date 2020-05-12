import 'package:hive/hive.dart';
import 'package:voting_app/core/enums/viewstate.dart';
import 'package:voting_app/core/models/block_chain_data.dart';
import 'package:voting_app/core/services/api.dart';
import 'package:voting_app/locator.dart';
import 'package:voting_app/core/services/auth_service.dart';

import 'base_model.dart';

class BillsModel extends BaseModel {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  Api _api = locator<Api>();

  List<BlockChainData> blockChainList;
  List<BlockChainData> filteredbills;
  List<BlockChainData> get billList => filteredbills;
  Box<BlockChainData> blockChainData =
      Hive.box<BlockChainData>("block_chain_data");

  Future getBills() async {
    setState(ViewState.Busy);

    // get only bills from blockchain data
    List list =
        blockChainData.values.where((bill) => bill.id.startsWith('r')).toList();

    blockChainList = list;
    filteredbills = list;

    print('Bills on BlockChain: ' + blockChainList.length.toString());
    setState(ViewState.Idle);
  }

  void searchBills(String value) {
    filteredbills = blockChainList
        .where((text) =>
            text.shortTitle.toLowerCase().contains(value.toLowerCase()))
        .toList();
    notifyListeners();
  }
}
