import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:test/test.dart';
import 'package:voting_app/core/services/user_api.dart';
import 'package:voting_app/core/services/voting_service.dart';
import 'package:voting_app/core/services/wallet.dart';

// mock filesystem stuff in tests
const MethodChannel channel = MethodChannel('plugins.flutter.io/path_provider');
// need to assign it or something apparently.
var meh = channel.setMockMethodCallHandler((MethodCall methodCall) async {
  return ".";
});

void main() {
  // mock filesystem stuff in tests
  const MethodChannel channel =
      MethodChannel('plugins.flutter.io/path_provider');
  // need to assign it or something apparently.
  var meh = channel.setMockMethodCallHandler((MethodCall methodCall) async {
    return ".";
  });

  WidgetsFlutterBinding.ensureInitialized();
  /*late*/ WalletService walletService;
  /*late*/ UserApi userApi;

  setUp(() async {
    walletService = WalletService();
    walletService.walletDirectoryPath = Some(".");
    userApi = UserApi();
  });

  tearDown(() async {
    walletService.delete();
  });

  group('User service', () {
    test('sign up', () async {
      var wallet = await walletService.make();
      walletService.save(wallet);
      dynamic response = await userApi
          .signup((await walletService.ethereumAddress()).toString());
      print(response);
      //sleep(Duration(seconds: 10));
      var balance = await walletService.balance();
      expect(balance.getInWei.toInt(), greaterThan(0));

      var votingService = VotingService(walletService);

      var txHash = await votingService.submitVoteTransaction(
        "39e0c51afbada3237f2ea33748973a4e812b40347955b207df79df2629e4d4e6",
        "yes",
      );
      print(txHash);
      expect(txHash, startsWith("0x"));
    });
  });
}
