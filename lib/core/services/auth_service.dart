import 'dart:async';
import 'package:hive/hive.dart';
import 'package:voting_app/core/models/user.dart';
import 'package:voting_app/core/services/wallet.dart';
import 'package:voting_app/core/services/user_api.dart';

class AuthenticationService {
  Future<String> createUser(String name) async {
    Box userBox = Hive.box("user_box");

    // clear box
    userBox.clear();

    //If there is no wallet yet, create one.
    var walletService = WalletService(null);
    var exists = await walletService.walletExists();
    if (!exists) {
      print("Does not exist");
      await walletService.make();
    }
    print("Loading address");
    //Put the ethereum address in prefs for display in the UI
    var ethAddress = await walletService.ethereumAddress();

    userBox
        .putAll({'firstName': name, 'ethereumAddress': ethAddress.toString()});

    //Debug
    print("Ethereum address: ${ethAddress.toString()}");
    print("Name: $name");

    //Call signup API
    var userApi = UserApi();
    await userApi.signup(ethAddress.toString());

    return name;
  }

  Future<String> getUser() async {
    Box userBox = Hive.box("user_box");
    final user = userBox.get('firstName') ?? null;
    return user;
  }
}
