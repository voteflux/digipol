import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:hive/hive.dart';
import 'package:voting_app/core/services/user_api.dart';
import 'package:voting_app/core/services/wallet.dart';

import '../consts.dart';

class AuthenticationService {
  Future<String> createUser(String name) async {
    var userBox = Hive.box<String>(HIVE_USER_PREFS_STR);

    // clear box
    userBox.clear();

    //If there is no wallet yet, create one.
    var walletService = WalletService(None());
    var exists = await walletService.walletExists();
    if (!exists) {
      print("Does not exist");
      await walletService.make();
    }
    print("Loading address");
    //Put the ethereum address in prefs for display in the UI
    var ethAddress = await walletService.ethereumAddress();

    userBox.put("firstName", name);
    userBox.put("ethereumAddress", ethAddress.toString());

    //Debug
    print("Ethereum address: ${ethAddress.toString()}");
    print("Name: $name");

    //Call signup API
    var userApi = UserApi();
    await userApi.signup(ethAddress.toString());

    return name;
  }

  Future<String> getUser() async {
    Box userBox = Hive.box<Box>(HIVE_USER_BOX);
    final String? user = (userBox.get('firstName') ?? null) as String;
    return Future.value(user);
  }
}
