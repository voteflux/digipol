import 'dart:async';

import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:voting_app/core/services/user_api.dart';
import 'package:voting_app/core/services/wallet.dart';
import 'package:voting_app/locator.dart';

import '../consts.dart';

@lazySingleton
class AuthenticationService {
  final WalletService _walletService = locator<WalletService>();

  Box userBox = Hive.box<String>(HIVE_USER_PREFS_STR);
  Future<String> createUser(String name) async {
    // clear box
    userBox.clear();

    //If there is no wallet yet, create one.
    var exists = await _walletService.walletExists();
    if (!exists) {
      print("Does not exist");
      await _walletService.make();
    }
    print("Loading address");
    //Put the ethereum address in prefs for display in the UI
    var ethAddress = await _walletService.ethereumAddress();

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
    final String /*?*/ user = (userBox.get('firstName') ?? null) as String;
    return Future.value(user);
  }
}
