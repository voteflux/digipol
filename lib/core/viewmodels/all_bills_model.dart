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
  //VARS
  List<Bill> blockChainList;
  List<Bill> filteredBills;
  String dropdownValue = FILTER_NEWEST;

  List<Bill> get billList => filteredBills;
  bool onlyVotedBills = false;
  bool get getOnlyVotedBills => onlyVotedBills;

  bool removeVotedBills = false;
  bool get getRemoveVotedBills => removeVotedBills;

  bool filterByDate = false;
  bool get getfilterByDate => filterByDate;

  bool removeClosedBills = false;
  bool get getRemoveClosedBills => removeClosedBills;

  //HIVE BOXES
  final Box<BlockChainData> blockChainData =
      Hive.box<BlockChainData>(HIVE_BLOCKCHAIN_DATA);
  final Box<Bill> billsBox = Hive.box<Bill>(HIVE_BILLS);
  final Box<BillVote> billVoteBox = Hive.box<BillVote>(HIVE_BILL_VOTE_BOX);
  final Box<bool> userPrefsBool = Hive.box<bool>(HIVE_USER_PREFS_BOOLS);
  final Box<String> userPrefsString = Hive.box<String>(HIVE_USER_PREFS_STR);
  final Box<List> userPrefsList = Hive.box<List>(HIVE_USER_PREFS_LIST);

  BillsModel([this.blockChainList, this.filteredBills]);

  @factoryMethod
  static BillsModel mkBillsModel() {
    return BillsModel();
  }

  Future getBills() async {
    setState(ViewState.Busy);

    updateLists();

    // set voting prefs according to HIVE storage
    bool onlyVotedPref =
        userPrefsBool.get(ONLY_VOTED_BILLS, defaultValue: false);
    onlyVoted(onlyVotedPref);

    bool removeVotedPref =
        userPrefsBool.get(REMOVE_VOTED_BILLS, defaultValue: false);
    removeVoted(removeVotedPref);

    // bool dateRangeVotingPref =
    //     userPreferencesBox.get('filterByDate', defaultValue: true);
    // filterByDateTime(dateRangeVotingPref);

    bool removeCloseBillsPref =
        userPrefsBool.get(REMOVE_CLOSED_BILLS, defaultValue: true);
    removeClosedBillsFunction(removeCloseBillsPref);

    print('Bills on BlockChain: ' + blockChainList.length.toString());

    setState(ViewState.Idle);
  }

  void updateLists() {
    var billOnChain = blockChainData.values.map((el) => el.id).toList();

    var bills =
        billsBox.values.where((bill) => billOnChain.contains(bill.id)).toList();

    //bills.sort((a, b) => b.startDate.compareTo(a.startDate));

    blockChainList = bills;
    filteredBills = bills;
  }

  //
  // search bills
  //
  void searchBills(String value) {
    filteredBills = blockChainList
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
    userPrefsBool.put(ONLY_VOTED_BILLS, value);
    onlyVoted(value);
    print("onlyVotedBills: ${userPrefsBool.get(ONLY_VOTED_BILLS)}");
  }

  // filters list
  void onlyVoted(bool value) {
    List<Bill> filteredBillsState = filteredBills;
    this.onlyVotedBills = value;
    if (value) {
      this.removeVotedBills = !value;
      List list = billVoteBox.values.map((el) => el.ballotId).toList();
      filteredBills =
          blockChainList.where((bill) => list.contains(bill.id)).toList();
    } else {
      filteredBills = filteredBillsState;
    }
    notifyListeners();
  }

  //
  // remove voted switch methods
  //
  // filters list

  void removeVotedSearchSave(bool value) {
    userPrefsBool.put(REMOVE_VOTED_BILLS, value);
    removeVoted(value);
    print("removeVotedBills: ${userPrefsBool.get(REMOVE_VOTED_BILLS)}");
  }

  void removeVoted(bool value) {
    this.removeVotedBills = value;
    List<Bill> filteredBillsState = filteredBills;
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
      filteredBills = filtered;
    } else {
      filteredBills = filteredBillsState;
    }
    notifyListeners();
  }

  // filter by date
  // void filterByDateSave(bool value) {
  //   userPrefsBool.put('filterByDate', value);
  //   filterByDateTime(value);
  //   print(userPrefsBool.get('filterByDate'));
  // }

  void dropDownFilter(String value) {
    this.dropdownValue = value;
    if (value == FILTER_NEWEST) {
      filteredBills.sort((a, b) => b.startDate.compareTo(a.startDate));
    } else if (value == FILTER_OLDEST) {
      filteredBills.sort((a, b) => a.startDate.compareTo(b.startDate));
    } else if (value == FILTER_A_TO_Z) {
      filteredBills.sort((a, b) => a.shortTitle.compareTo(b.shortTitle));
    }
    notifyListeners();
  }

  // remove closed bills

  void removeClosedBillsFunctionSave(bool value) {
    userPrefsBool.put(REMOVE_CLOSED_BILLS, value);
    removeClosedBillsFunction(value);
    print("removeVotedBills: ${userPrefsBool.get(REMOVE_VOTED_BILLS)}");
  }

  void removeClosedBillsFunction(bool value) {
    List<Bill> filteredBillsState = filteredBills;
    this.removeClosedBills = value;
    if (value) {
      filteredBills = filteredBills.where((i) => i.assentDate == '').toList();
    } else {
      filteredBills = filteredBillsState;
    }
    notifyListeners();
  }

  void refineByTopics() {
    List<Bill> filteredBillsState = filteredBills;
    List<String> blankTags = [];
    List<String> tags =
        userPrefsList.get('tags', defaultValue: blankTags).cast<String>();
    List<Bill> filtered = [];

    if (tags.length > 0) {
      filteredBills.forEach((bill) {
        bill.topics.forEach((topic) {
          if (tags.contains(topic)) {
            filtered.add(bill);
          } else {
            print('does not contain');
          }
        });
      });

      filteredBills = filtered;
    } else {
      filteredBills = filteredBillsState;
    }

    notifyListeners();
    print(tags);
  }
}
