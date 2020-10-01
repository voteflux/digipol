import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:test/test.dart';
import 'package:voting_app/core/consts.dart';
import 'package:voting_app/core/models/bill.dart';
import 'package:voting_app/core/models/bill_vote.dart';
import 'package:voting_app/core/models/block_chain_data.dart';
import 'package:voting_app/core/models/issue.dart';
import 'package:voting_app/core/models/user.dart';
import 'package:voting_app/core/services/api.dart';
import 'package:voting_app/locator.dart';

Api _api = locator<Api>();

void main() {
  setupLocator();
  // sync data on load

  group('api', () {
    test('Open Hive Boxes', () async {
      await Hive.initFlutter();
      Hive.registerAdapter<BlockChainData>(BlockChainDataAdapter());
      Hive.registerAdapter<Bill>(BillAdapter());
      Hive.registerAdapter<Issue>(IssueAdapter());
      Hive.registerAdapter<User>(UserAdapter());
      Hive.registerAdapter<BillVote>(BillVoteAdapter());
      await Hive.openBox<BlockChainData>(HIVE_BLOCKCHAIN_DATA);
      await Hive.openBox<Bill>(HIVE_BILLS);
      await Hive.openBox<Issue>(HIVE_ISSUES);
      await Hive.openBox<Box>(HIVE_USER_BOX);
      await Hive.openBox<BillVote>(HIVE_BILL_VOTE_BOX);
      await Hive.openBox<BillVote>(HIVE_USER_PREFS_STR);
      await Hive.openBox<BillVote>(HIVE_USER_PREFS_BOOLS);
    });

    test('test api data syncing', () async {
      await _api.syncData();
    });
  });
}
