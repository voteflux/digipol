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

  bool removeOpenBills = false;
  bool get getRemoveOpenBills => removeOpenBills;

  bool onlyWatchedBills = false;
  bool get getonlyWatchedBills => onlyWatchedBills;

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

    print('getting bills....');

    updateLists();
    setSearchState();

    print('Bills on BlockChain: ' + blockChainList.length.toString());

    setState(ViewState.Idle);
  }

  void updateLists() {
    var billOnChain = blockChainData.values.map((el) => el.id).toList();

    var bills =
        billsBox.values.where((bill) => billOnChain.contains(bill.id)).toList();

    blockChainList = bills;
    filteredBills = bills;
  }

  void setBoolPreferencesOnStartup(String preference, Function function) {
    bool userPref = userPrefsBool.get(preference, defaultValue: false);
    function(userPref);
  }

  void setStringPreferencesOnStartup(String preference, Function function) {
    String userPref =
        userPrefsString.get(preference, defaultValue: FILTER_NEWEST);
    function(userPref);
  }

  void setSearchState() {
    // set voting prefs according to HIVE storage
    filteredBills = blockChainList;
    setStringPreferencesOnStartup(USER_FILTERED_PREFERENCE, dropDownFilter);
    setBoolPreferencesOnStartup(USER_WATCHED_BILLS, showOnlyWatchedBills);
    setBoolPreferencesOnStartup(ONLY_VOTED_BILLS, onlyVoted);
    setBoolPreferencesOnStartup(REMOVE_VOTED_BILLS, removeVoted);
    setBoolPreferencesOnStartup(REMOVE_CLOSED_BILLS, removeClosedBillsFunction);
    setBoolPreferencesOnStartup(REMOVE_OPEN_BILLS, removeOpenBillsFunction);

    // refine by user topics
    refineByTopics();
  }

  //
  // search bills
  //
  void searchBills(String value) {
    // search through tags/topics
    checkTags(Bill bill, String searchValue) {
      bool contains = false;
      bill.topics.forEach((topic) {
        if (topic.toLowerCase().contains(searchValue.toLowerCase())) {
          contains = true;
        }
      });
      return contains;
    }

    filteredBills = blockChainList
        .where((text) =>
            checkTags(text, value) ||
            text.shortTitle.toLowerCase().contains(value.toLowerCase()) ||
            text.summary.toLowerCase().contains(value.toLowerCase()))
        .toList();
    notifyListeners();
  }

  // helper bool save function
  void savePrefInHive(bool value, String preference, Function function) {
    userPrefsBool.put(preference, value);
    setSearchState();
    print(preference + ": " + "${userPrefsBool.get(preference)}");
  }

  // helper string save function
  void saveStringPrefInHive(
      String value, String preference, Function function) {
    userPrefsString.put(preference, value);
    setSearchState();
    print(preference + ": " + "${userPrefsString.get(preference)}");
  }

  //
  // only voted switch methods
  //
  void onlyVoted(bool value) {
    this.onlyVotedBills = value;
    if (value) {
      this.removeVotedBills = !value;
      List list = billVoteBox.values.map((el) => el.ballotId).toList();
      filteredBills =
          blockChainList.where((bill) => list.contains(bill.id)).toList();
    }
    notifyListeners();
  }

  //
  // remove voted switch methods
  //
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
      filteredBills = filtered;
    }
    notifyListeners();
  }

  //
  // Drop down filter
  //
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

  //
  // Remove closed bills
  //
  void removeClosedBillsFunction(bool value) {
    this.removeClosedBills = value;

    if (value) {
      this.removeOpenBills = !value;
      filteredBills = filteredBills.where((i) => i.assentDate == '').toList();
    }
    notifyListeners();
  }

  //
  // Remove open bills
  //
  void removeOpenBillsFunction(bool value) {
    this.removeOpenBills = value;

    if (value) {
      this.removeClosedBills = !value;
      filteredBills = filteredBills.where((i) => i.assentDate != '').toList();
    }
    notifyListeners();
  }

  //
  // Refine by topics
  //
  void refineByTopics() {
    List<String> blankTags = [];
    List<String> tags =
        userPrefsList.get(USER_TAGS, defaultValue: blankTags).cast<String>();
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
    }
    notifyListeners();
  }

  //
  // Refine by watched
  //
  void showOnlyWatchedBills(bool value) {
    this.onlyWatchedBills = value;
    List<String> blankBills = [];
    List<String> billIds = userPrefsList
        .get(USER_WATCHED_BILLS, defaultValue: blankBills)
        .cast<String>();
    List<Bill> filtered = [];

    if (value) {
      if (billIds.length > 0) {
        filteredBills.forEach((bill) {
          if (billIds.contains(bill.id)) {
            filtered.add(bill);
          } else {
            print('does not contain');
          }
        });
        filteredBills = filtered;
      }
    }

    notifyListeners();
  }
}
