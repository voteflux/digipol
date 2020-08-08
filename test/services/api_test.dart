import 'package:test/test.dart';
import 'package:voting_app/core/services/wallet.dart';
import 'package:voting_app/core/services/api.dart';
import 'package:web3dart/web3dart.dart';
import 'package:voting_app/locator.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';
import 'package:voting_app/core/models/block_chain_data.dart';
import 'package:voting_app/core/models/bill.dart';
import 'package:voting_app/core/models/issue.dart';
import 'package:voting_app/core/models/user.dart';
import 'package:voting_app/core/models/bill_vote.dart';


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
      await Hive.openBox<BlockChainData>("block_chain_data");
      await Hive.openBox<Bill>("bills");
      await Hive.openBox<Issue>("issues");
      await Hive.openBox("user_box");
      await Hive.openBox<BillVote>("bill_vote_box");
      await Hive.openBox("user_preferences");

    });

    test('test api data syncing', () async {
      await _api.syncData();
    });


  });
}