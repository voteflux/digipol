import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:voting_app/core/enums/viewstate.dart';
import 'package:voting_app/core/models/bill.dart';
import 'package:voting_app/core/models/bill_vote.dart';
import 'package:voting_app/core/models/block_chain_data.dart';

import '../consts.dart';
import 'base_model.dart';

@injectable
class BillsModel extends BaseModel {
  /*late*/ List<Bill> blockChainList;
  /*late*/ List<Bill> filteredbills;
  List<Bill> get billList => filteredbills;
  final Box<BlockChainData> blockChainData =
      Hive.box<BlockChainData>(HIVE_BLOCKCHAIN_DATA);
  final Box<Bill> billsBox = Hive.box<Bill>(HIVE_BILLS);

  final Box<BillVote> billVoteBox = Hive.box<BillVote>(HIVE_BILL_VOTE_BOX);
  final Box<bool> userPrefsBool = Hive.box<bool>(HIVE_USER_PREFS_BOOLS);

  bool onlyVotedBills = false;
  bool get getOnlyVotedBills => onlyVotedBills;

  bool removeVotedBills = false;
  bool get getRemoveVotedBills => removeVotedBills;

  bool filterByDate = false;
  bool get getfilterByDate => filterByDate;

  bool removeClosedBills = false;
  bool get getRemoveClosedBills => removeClosedBills;

  BillsModel();

  @factoryMethod
  static BillsModel mkBillsModel() {
    return BillsModel();
  }

  Future getBills() async {
    setState(ViewState.Busy);

    var billOnChain = blockChainData.values.map((el) => el.id).toList();

    var bills =
        billsBox.values.where((bill) => billOnChain.contains(bill.id)).toList();

    bills.sort((a, b) => b.startDate.compareTo(a.startDate));

    blockChainList = bills;
    filteredbills = bills;

    // set voting prefs
    bool onlyVotedPref =
        userPrefsBool.get('onlyVotedBills', defaultValue: false);
    onlyVoted(onlyVotedPref);

    bool removeVotedPref =
        userPrefsBool.get('removeVotedBills', defaultValue: false);
    removeVoted(removeVotedPref);

    // bool dateRangeVotingPref =
    //     userPreferencesBox.get('filterByDate', defaultValue: true);
    // filterByDateTime(dateRangeVotingPref);

    bool removeCloseBillsPref =
        userPrefsBool.get('removeClosedBills', defaultValue: true);
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
    userPrefsBool.put('onlyVotedBills', value);
    onlyVoted(value);
    print("onlyVotedBills: ${userPrefsBool.get('onlyVotedBills')}");
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
    userPrefsBool.put('removeVotedBills', value);
    removeVoted(value);
    print("removeVotedBills: ${userPrefsBool.get('removeVotedBills')}");
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
    userPrefsBool.put('removeClosedBills', value);
    removeClosedBillsFunction(value);
    print("removeVotedBills: ${userPrefsBool.get('removeVotedBills')}");
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
