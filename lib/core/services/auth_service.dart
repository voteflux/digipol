import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:voting_app/core/models/user.dart';
import 'package:voting_app/core/services/wallet.dart';

class AuthenticationService {
  //Api _api = locator<Api>();

  StreamController<User> userController = StreamController<User>();

  Future<String> createUser(String name) async {

    final prefs = await SharedPreferences.getInstance();

    //set name
    prefs.setString('name', name);

    //If there is no wallet yet, create one.
    var walletService = WalletService(null);
    var exists = await walletService.walletExists();
    if (!exists) {
      await walletService.make();
    }

    //Put the ethereum address in prefs for display in the UI
    var ethAddress = await walletService.ethereumAddress();
    prefs.setString('ethereumAddress', ethAddress.toString());

    //Debug
    print("Ethereum address: ${ethAddress.toString()}");
    print("Name: $name");

    return name;
  }


  Future<String> getUser() async {

    final prefs = await SharedPreferences.getInstance();
    final user = prefs.getString('name') ?? null;
    final ethereumAddress = prefs.getString('ethereumAddress') ?? null;

    print(user);
    print(ethereumAddress);
    return user;
  }

  Future<String> getEthereumAddress() async {

    final prefs = await SharedPreferences.getInstance();
    final ethereumAddress = prefs.getString('ethereumAddress') ?? null;

    print(ethereumAddress);
    return ethereumAddress;
  }
}