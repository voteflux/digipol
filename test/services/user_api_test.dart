import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:logger/logger.dart';
import 'package:voting_app/core/services/user_api.dart';
import 'package:voting_app/core/services/voting_service.dart';
import 'package:voting_app/core/services/wallet.dart';

import '../setup/test_helpers.dart';

final Logger log = Logger();

void main() {
  Logger.level = Level.warning;

  log.i("user_api_test main starting");
  TestWidgetsFlutterBinding.ensureInitialized();
  log.i("called TestWidgetsFlutterBinding.ensureInitialized");

  // mock filesystem stuff in tests
  const MethodChannel channel =
      MethodChannel('plugins.flutter.io/path_provider');
  // need to assign it or something apparently.
  var meh = channel.setMockMethodCallHandler((MethodCall methodCall) async {
    return ".";
  });
  log.i("mocked path_provider");

  /*late*/ WalletService walletService;
  /*late*/ UserApi userApi;
  VotingService votingService;

  setUp(() async {
    log.i("user_api_test setUp starting");
    walletService = WalletService();
    walletService.walletDirectoryPath = Some(".");
    userApi = UserApiMock();
    log.i("user_api_test setUp finished");
  });

  tearDown(() async {
    walletService.delete();
  });

  group('User service', () {
    testWidgets('sign up', (WidgetTester tester) async {
      log.i("user_api_test sign up test starting");
      var walletFile = await walletService.walletFile();
      log.i("loaded walletFile");
      var walletExists = await walletFile.existsSync();
      log.i("walletFile.existsSync=${walletExists}");
      var wallet = await walletService.load(allowCreation: true);
      log.i("created new wallet via walletService.load(allowCreation: true)");
      await walletService.save(wallet);

      log.i(
          "skipping userApi.signup because we're not testing the API itself and haven't modularised/mocked code.");
      if (false) {
        dynamic response = await userApi
            .signup((await walletService.ethereumAddress()).toString());
      }
      // log.i('userApi.signup response: ${response}');

      return;
      // returning here because the following code depends on the API and we haven't mocked it. We should do so.
      // Plus, if we add user validation it will break _anyway_.

      log.i('pausing for 5s to give txs time to confirm or something');
      sleep(Duration(seconds: 5));
      var balance = await walletService.balance();
      // expect(balance.getInWei.toInt(), greaterThan(0));
      log.i("Got balance ${balance}");

      var votingService = VotingService(walletService: walletService);

      var txHash = await votingService.submitVoteTransaction(
        "39e0c51afbada3237f2ea33748973a4e812b40347955b207df79df2629e4d4e6",
        "yes",
      );
      log.i("txHash from vote transaction: ${txHash}");
      expect(txHash, startsWith("0x"));
    });
  });
}
