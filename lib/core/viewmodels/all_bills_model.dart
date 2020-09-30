import 'package:hive/hive.dart';
import 'package:voting_app/core/enums/viewstate.dart';
import 'package:voting_app/core/models/bill.dart';
import 'package:voting_app/core/models/bill_vote.dart';
import 'package:voting_app/core/models/block_chain_data.dart';

import '../consts.dart';
import 'base_model.dart';

class BillsModel extends BaseModel {
  List<Bill> blockChainList;
  List<Bill> filteredbills;
  List<Bill> get billList => filteredbills;
  Box<BlockChainData> blockChainData =
      Hive.box<BlockChainData>(HIVE_BLOCKCHAIN_DATA);
  Box<Bill> billsBox = Hive.box<Bill>(HIVE_BILLS);

  Box<BillVote> billVoteBox = Hive.box<BillVote>(HIVE_BILL_VOTE_BOX);
  Box userPreferencesBox = Hive.box<BillVote>(HIVE_USER_PREFS);

  bool onlyVotedBills = false;
  bool get getOnlyVotedBills => onlyVotedBills;

  bool removeVotedBills = false;
  bool get getRemoveVotedBills => removeVotedBills;

  bool filterByDate = false;
  bool get getfilterByDate => filterByDate;

  bool removeClosedBills = false;
  bool get getRemoveClosedBills => removeClosedBills;

  Future getBills() async {
    setState(ViewState.Busy);

    List billOnChain = blockChainData.values.map((el) => el.id).toList();

    List list =
        billsBox.values.where((bill) => billOnChain.contains(bill.id)).toList();

    list.sort((a, b) => b.startDate.compareTo(a.startDate));

    blockChainList = list;
    filteredbills = list;

    // set voting prefs
    bool onlyVotedPref =
        userPreferencesBox.get('onlyVotedBills', defaultValue: false);
    onlyVoted(onlyVotedPref);

    bool removeVotedPref =
        userPreferencesBox.get('removeVotedBills', defaultValue: false);
    removeVoted(removeVotedPref);

    // bool dateRangeVotingPref =
    //     userPreferencesBox.get('filterByDate', defaultValue: true);
    // filterByDateTime(dateRangeVotingPref);

    bool removeCloseBillsPref =
        userPreferencesBox.get('removeClosedBills', defaultValue: true);
    removeClosedBillsFunction(removeCloseBillsPref);

    print('Bills on BlockChain: ' + blockChainList.length.toString());
    setState(ViewState.Idle);
  }

  //
  // search bills
  //
  void searchBills(String value) {
    filteredbills = blockChainList
        .where((text) =>
            text.shortTitle.toLowerCase().contains(value.toLowerCase()) ||
            text.summary.toLowerCase().contains(value.toLowerCase()))
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
      this.removeVotedBills = !value;
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
      this.onlyVotedBills = !value;

      List list = billVoteBox.values.map((el) => el.ballotId).toList();
      List<Bill> filtered = [];

      blockChainList.forEach((element) {
        if (list.contains(element.id)) {
          print('voted: ' + element.id.toString());
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

  // // filter by date
  // void filterByDateSave(bool value) {
  //   userPreferencesBox.put('filterByDate', value);
  //   filterByDateTime(value);
  //   print(userPreferencesBox.get('filterByDate'));
  // }

  // void filterByDateTime(bool value) {
  //   this.filterByDate = value;
  //   if (value) {
  //     filteredbills.sort((a, b) => b.startDate.compareTo(a.startDate));
  //   } else {
  //     filteredbills.sort((a, b) => a.shortTitle.compareTo(b.shortTitle));
  //   }
  //   notifyListeners();
  // }

  // remove closed bills

  void removeClosedBillsFunctionSave(bool value) {
    userPreferencesBox.put('removeClosedBills', value);
    removeClosedBillsFunction(value);
    print(userPreferencesBox.get('removeClosedBills'));
  }

  void removeClosedBillsFunction(bool value) {
    this.removeClosedBills = value;
    if (value) {
      filteredbills = filteredbills.where((i) => i.assentDate == '').toList();
    } else {
      filteredbills = blockChainList;
    }
    notifyListeners();
  }
}
