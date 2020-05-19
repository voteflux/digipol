import 'package:hive/hive.dart';
import 'package:voting_app/core/enums/viewstate.dart';
import 'package:voting_app/core/models/block_chain_data.dart';
import 'base_model.dart';

class BillsModel extends BaseModel {

  List<BlockChainData> blockChainList;
  List<BlockChainData> filteredbills;
  List<BlockChainData> get billList => filteredbills;
  Box<BlockChainData> blockChainData =
      Hive.box<BlockChainData>("block_chain_data");
  bool excludeVoted = false; 
  bool get unvotedBills => excludeVoted;

  Future getBills() async {
    setState(ViewState.Busy);

    // get only bills from blockchain data
    List list =
        blockChainData.values.where((bill) => bill.id.startsWith(RegExp(r'[s+r]'))).toList();

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
