import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:test/test.dart';
import 'package:voting_app/core/services/wallet.dart';
import 'package:web3dart/web3dart.dart';

const SAMPLE_WALLET_BACKUP = [
  "leader",
  "shadow",
  "labor",
  "imitate",
  "vivid",
  "left",
  "critic",
  "giant",
  "repair",
  "they",
  "delay",
  "matter"
];
const SAMPLE_WALLET_ADDR = "0x8a4AD0054E4bE3c752b8CDC6F9674f094d11cD81";

void main() {
  // mock filesystem stuff in tests
  const MethodChannel channel =
      MethodChannel('plugins.flutter.io/path_provider');
  // need to assign it or something apparently.
  var meh = channel.setMockMethodCallHandler((MethodCall methodCall) async {
    return ".";
  });

  WidgetsFlutterBinding.ensureInitialized();
  /*late*/ WalletService service;

  setUp(() async {
    service = WalletService();
    service.walletDirectoryPath = Some(".");
  });

  tearDown(() async {
    service.delete();
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
      expect(loadedWallet.privateKey.toString(),
          equals(wallet.privateKey.toString()));
    });

    test('wallet ethereum address should be valid', () async {
      await service.make();
      var ethAddress = await service.ethereumAddress();

      expect(ethAddress.toString(), allOf([startsWith("0x"), hasLength(42)]));
    });

    test('loading empty wallet file should fail', () async {
      expect(() => service.load(allowCreation: false), throwsException);
    });

    test('make wallet from random mnemomic', () async {
      List<String> wordList = WalletService.makeRandomWords();
      expect(wordList.length, equals(12));
      var wallet = await service.make(words: wordList);
      expect(wallet, isA<Wallet>());
    });

    test('making wallet with known mnemonic should generate correct key',
        () async {
      var wallet = await service.make(words: SAMPLE_WALLET_BACKUP);
      var derivedAddress =
          (await wallet.privateKey.extractAddress()).toString();

      expect(derivedAddress, equalsIgnoringCase(SAMPLE_WALLET_ADDR));
    });
  });
}
