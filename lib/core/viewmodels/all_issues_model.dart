import 'package:hive/hive.dart';
import 'package:voting_app/core/enums/viewstate.dart';
import 'package:voting_app/core/models/block_chain_data.dart';
import 'package:voting_app/core/services/api.dart';
import 'package:voting_app/locator.dart';

import '../consts.dart';
import 'base_model.dart';

class IssuesModel extends BaseModel {
  Api _api = locator<Api>();

  List<BlockChainData> filteredIssues;
  List<BlockChainData> get issueList => filteredIssues;
  List<BlockChainData> blockChainList;
  Box<BlockChainData> blockChainData =
      Hive.box<BlockChainData>(HIVE_BLOCKCHAIN_DATA);

  IssuesModel(this.filteredIssues, this.blockChainList);

  Future getIssues() async {
    setState(ViewState.Busy);

    var list =
        blockChainData.values.where((bill) => bill.id.startsWith('i')).toList();

    blockChainList = list;
    filteredIssues = list;
    print('Issues on BlockChain: ' + blockChainList.length.toString());
    setState(ViewState.Idle);
  }

  void searchIssues(String value) {
    filteredIssues = blockChainList
        .where((text) =>
            text.shortTitle.toLowerCase().contains(value.toLowerCase()))
        .toList();
    notifyListeners();
  }
}
