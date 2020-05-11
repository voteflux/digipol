import 'package:hive/hive.dart';
import 'package:voting_app/core/enums/viewstate.dart';
import 'package:voting_app/core/models/block_chain_data.dart';
import 'package:voting_app/core/models/issue.dart';
import 'package:voting_app/core/services/api.dart';
import 'package:voting_app/locator.dart';

import 'base_model.dart';

class IssuesModel extends BaseModel {
  Api _api = locator<Api>();

  List<BlockChainData> filteredIssues;
  List<BlockChainData> get issueList => filteredIssues;
  List<BlockChainData> blockChainList;
  Box<BlockChainData> blockChainData =
      Hive.box<BlockChainData>("block_chain_data");

  Future getIssues() async {
    setState(ViewState.Busy);

    List list =
        blockChainData.values.where((bill) => bill.id.startsWith('i')).toList();

    blockChainList = list;
    filteredIssues = list;
    print('all_issues');
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
