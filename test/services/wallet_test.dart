import 'package:test/test.dart';
import 'package:voting_app/core/services/wallet.dart';
import 'package:web3dart/web3dart.dart';

void main() {

  WalletService service;

  setUp(() async{
    service = WalletService(".");
  });

  group('Wallet', () {

    test('create new wallet', () async {
      var wallet = await service.make();
      expect(wallet.privateKey, isA<EthPrivateKey>());
    });

    test('save/load wallet', () async {
      var wallet = await service.make();
      await service.save(wallet);
      var loadedWallet = await service.load();
      expect(loadedWallet.privateKey.toString(), equals(wallet.privateKey.toString()));
    });

  });

}