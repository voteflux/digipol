import 'package:test/test.dart';
import 'dart:io';
import 'package:voting_app/core/services/wallet.dart';
import 'package:voting_app/core/services/user_api.dart';

void main() {
  WalletService walletService;
  UserApi userApi;

  setUp(() async {
    walletService = WalletService(".");
    userApi = UserApi();
  });

  tearDown(() async {
    walletService.delete();
  });

  group('User service', () {
    test('sign up', () async {
      await walletService.make();
      var response = await userApi
          .signup((await walletService.ethereumAddress()).toString());
      print(response);
      //sleep(Duration(seconds: 10));
      var balance = await walletService.balance();
      expect(balance.getInWei.toInt(), greaterThan(0));
    });
  });
}
