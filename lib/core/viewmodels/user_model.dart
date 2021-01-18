import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:voting_app/core/consts.dart';
import 'package:voting_app/core/enums/viewstate.dart';
import 'package:voting_app/core/models/bill.dart';
import 'package:voting_app/core/models/bill_vote.dart';
import 'package:voting_app/core/models/block_chain_data.dart';
import 'package:voting_app/core/services/auth_service.dart';
import 'package:voting_app/locator.dart';

import '../router.gr.dart';
import 'base_model.dart';

@injectable
class UserModel extends BaseModel {
  List<Bill> blockChainList;
  List<Bill> filteredBills;
  List<Bill> get billList => filteredBills;
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  /*late*/ String user;
  String get getUser => user;
  String pincode;
  bool wrongPin = false;
  bool isUser = false;
  //HIVE BOXES
  final Box<BlockChainData> blockChainData =
      Hive.box<BlockChainData>(HIVE_BLOCKCHAIN_DATA);
  final Box<Bill> billsBox = Hive.box<Bill>(HIVE_BILLS);
  final Box<BillVote> billVoteBox = Hive.box<BillVote>(HIVE_BILL_VOTE_BOX);
  final Box<bool> userPrefsBool = Hive.box<bool>(HIVE_USER_PREFS_BOOLS);
  final Box<String> userPrefsString = Hive.box<String>(HIVE_USER_PREFS_STR);
  final Box<List> userPrefsList = Hive.box<List>(HIVE_USER_PREFS_LIST);
  final NavigationService _navigationService = locator<NavigationService>();

  bool onlyWatchedBills = false;
  bool get getonlyWatchedBills => onlyWatchedBills;
  bool onlyVotedBills = false;
  bool get getOnlyVotedBills => onlyVotedBills;

  UserModel();

  Future getBills() async {
    setState(ViewState.Busy);
    updateLists();
    filteredBills = blockChainList;
    showOnlyWatchedBills(true);
    onlyVoted(true);
    setState(ViewState.Idle);
  }

  void updateLists() {
    var billOnChain = blockChainData.values.map((el) => el.id).toList();

    var bills =
        billsBox.values.where((bill) => billOnChain.contains(bill.id)).toList();

    blockChainList = bills;
    filteredBills = bills;
  }

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

  //
  // only voted switch methods
  //
  void onlyVoted(bool value) {
    this.onlyVotedBills = value;
    if (value) {
      List list = billVoteBox.values.map((el) => el.ballotId).toList();
      filteredBills =
          blockChainList.where((bill) => list.contains(bill.id)).toList();
    }
    notifyListeners();
  }

  Future<String> start() async {
    setState(ViewState.Busy);

    var name = await _authenticationService.getUser();
    if (name != null) {
      user = name;
      isUser = true;
    }

    setState(ViewState.Idle);
    return name;
  }

  Future<String> login(String pincode) async {
    var userPincode = await _authenticationService.getUserPin();
    print(userPincode);
    if (userPincode == pincode) {
      await _navigationService.replaceWith(Routes.mainScreen);
    } else {
      wrongPin = true;
      print('incorrect pin');
      notifyListeners();
    }
  }

  Future create(String name, String pincode) async {
    if (pincode != null) {
      setState(ViewState.Busy);
      user = await _authenticationService.createUser(name, pincode);
      await _navigationService.replaceWith(Routes.onBoardingView);
      setState(ViewState.Idle);
    } else {
      wrongPin = true;
      notifyListeners();
    }
  }
}
