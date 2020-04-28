/// Wallet service
///
/// The wallet is loaded on demand, and not kept in memory. This is to make illegal access to the keys more difficult.

import 'dart:io';
import 'dart:math';

import 'package:web3dart/web3dart.dart';
import 'package:bip39/bip39.dart' as bip39;
import 'package:bip32/bip32.dart' as bip32;
import 'package:hex/hex.dart';

const WALLET_FILE_NAME = "wallet.json";
const TEMPORARY_PASSWORD = "4%8=)l_L210920A@g,";
const ETH_HD_DERIVATION_PATH = "m/44'/60'/0'/0/0";

class WalletMissingException implements Exception {
  @override
  String toString() {
    return "Wallet file is missing";
  }
}

class WalletService {
  String _walletDirectoryPath;

  /// Instantiate the service.
  /// @param _walletDirectoryPath The path of the directory to be used for storing the wallet file.
  WalletService(this._walletDirectoryPath);

  /// Create a new wallet and save it to the wallet file.
  /// If a list of strings is supplied as the parameter [words], they are used to generate the private key via BIP-39
  /// Otherwise, a random private key is generated from scratch.
  Future<Wallet> make({List<String> words}) async {
    EthPrivateKey ethKey;
    var rand = Random.secure();

    //Use mnemonic words if supplied, otherwise create a random key
    if (words == null) {
      ethKey = EthPrivateKey.createRandom(rand);
    } else {
      ethKey = _makePrivKeyFromWords(words);
    }

    //Make a wallet from the key
    var wallet = Wallet.createNew(ethKey, TEMPORARY_PASSWORD, rand);

    //Save it to the wallet file and return it
    await save(wallet);
    return wallet;
  }

  static List<String> makeRandomWords() {
    String words = bip39.generateMnemonic();
    return words.split(" ");
  }

  ///Make a private key, given a list of words
  static EthPrivateKey _makePrivKeyFromWords(List<String> words) {
    //Make into a string
    var mnemonic = words.reduce((value, element) => "$value $element");

    // Make a seed from a list of words
    String seed = bip39.mnemonicToSeedHex(mnemonic);

    // Make a BIP32 for an Ethereum key
    bip32.BIP32 root = bip32.BIP32.fromSeed(HEX.decode(seed));
    bip32.BIP32 child = root.derivePath(ETH_HD_DERIVATION_PATH);

    // Make into an EthPrivateKey
    String privateKey = HEX.encode(child.privateKey);
    return EthPrivateKey.fromHex(privateKey);
  }

  /// Read wallet from the wallet file.
  Future<Wallet> load() async {
    if (await walletExists()) {
      String walletContent = walletFile.readAsStringSync();
      return Wallet.fromJson(walletContent, TEMPORARY_PASSWORD);
    } else {
      throw WalletMissingException();
    }
  }

  /// Write a wallet to the wallet file.
  Future<bool> save(Wallet wallet) async {
    try {
      await walletFile.writeAsString(wallet.toJson());
      return true;
    } catch (e) {
      return false;
    }
  }

  /// Returns true if the wallet file exists.
  Future<bool> walletExists() async {
    return await walletFile.exists();
  }

  /// Delete the wallet file.
  Future<bool> delete() async {
    try {
      await walletFile.delete();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<EthereumAddress> ethereumAddress() async {
    var wallet = await load();
    return await wallet.privateKey.extractAddress();
  }

  /// The file handle for the file used to store the wallet object.
  File get walletFile {
    return File('${_walletDirectoryPath}/$WALLET_FILE_NAME');
  }
}
