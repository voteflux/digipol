import 'dart:io';
import 'dart:math';

import 'package:web3dart/web3dart.dart';
import 'package:path_provider/path_provider.dart';

const WALLET_FILE_NAME = "wallet.json";
const TEMPORARY_PASSWORD = "4%8=)l_L210920A@g,";

class WalletService {

  String _walletDirectoryPath;
  
  WalletService(this._walletDirectoryPath);

  Future<Wallet> make() async {
    var rand = new Random.secure();
    var key = EthPrivateKey.createRandom(rand);
    var wallet = Wallet.createNew(key, TEMPORARY_PASSWORD, rand);
    await save(wallet);
    return wallet;
  }

  Future<Wallet> load() async {  
    String walletContent = walletFile.readAsStringSync();
    return Wallet.fromJson(walletContent, TEMPORARY_PASSWORD);
  }

  Future<bool> save(Wallet wallet) async {
    try {
      await walletFile.writeAsString(wallet.toJson());
      return true;
    }
    catch (e) {
      return false;
    }
  }

  /*static Future<String> publicKey() async {
    
  }*/

  File get walletFile {
    return File('${_walletDirectoryPath}/$WALLET_FILE_NAME');
  }


}
