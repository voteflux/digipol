import 'package:hive/hive.dart';
import 'package:voting_app/core/enums/viewstate.dart';
import 'package:voting_app/core/models/bill_vote.dart';
import 'package:voting_app/core/models/block_chain_data.dart';
import 'base_model.dart';

class BillsModel extends BaseModel {
  List<BlockChainData> blockChainList;
  List<BlockChainData> filteredbills;
  List<BlockChainData> get billList => filteredbills;
  Box<BlockChainData> blockChainData =
      Hive.box<BlockChainData>("block_chain_data");
  Box<BillVote> billVoteBox = Hive.box<BillVote>("bill_vote_box");
  Box userPreferencesBox = Hive.box("user_preferences");

  bool onlyVotedBills = false;
  bool get getOnlyVotedBills => onlyVotedBills;

  bool removeVotedBills = false;
  bool get getRemoveVotedBills => removeVotedBills;

  Future getBills() async {
    setState(ViewState.Busy);
    List list = blockChainData.values
        .where((bill) => bill.id.startsWith(RegExp(r'[s+r]')))
        .toList();

    blockChainList = list;
    filteredbills = list;

    // set voting prefs
    bool onlyVotedPref =
        userPreferencesBox.get('onlyVotedBills', defaultValue: false);
    onlyVoted(onlyVotedPref);

    bool removeVotedPref =
        userPreferencesBox.get('removeVotedBills', defaultValue: false);
    removeVoted(removeVotedPref);

    print('Bills on BlockChain: ' + blockChainList.length.toString());
    setState(ViewState.Idle);
  }

  //
  // search bills
  //
  void searchBills(String value) {
    filteredbills = blockChainList
        .where((text) =>
            text.shortTitle.toLowerCase().contains(value.toLowerCase()))
        .toList();
    notifyListeners();
  }

  //
  // only voted switch methods
  //
  // saves pref in hive
  void onlyVotedSearchSave(bool value) {
    userPreferencesBox.put('onlyVotedBills', value);
    onlyVoted(value);
    print(userPreferencesBox.get('onlyVotedBills'));
  }

  // filters list
  void onlyVoted(bool value) {
    this.onlyVotedBills = value;
    if (value) {
      List list = billVoteBox.values.map((el) => el.ballotId).toList();
      filteredbills =
          blockChainList.where((bill) => list.contains(bill.id)).toList();
    } else {
      filteredbills = blockChainList;
    }
    notifyListeners();
  }

  //
  // remove voted switch methods
  //
  // filters list

  void removeVotedSearchSave(bool value) {
    userPreferencesBox.put('removeVotedBills', value);
    removeVoted(value);
    print(userPreferencesBox.get('removeVotedBills'));
  }

  void removeVoted(bool value) {
    this.removeVotedBills = value;
    if (value) {
      List list = billVoteBox.values.map((el) => el.ballotId).toList();
      List<BlockChainData> filtered = [];

      blockChainList.forEach((element) {
        if (list.contains(element.id)) {
          print('inn' + element.id.toString());
        } else {
          filtered.add(element);
        }
      });
      filteredbills = filtered;
    } else {
      filteredbills = blockChainList;
    }
    notifyListeners();
  }
}
