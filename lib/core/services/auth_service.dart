import 'dart:async';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:voting_app/core/models/user.dart';
import 'package:voting_app/core/services/wallet.dart';

import '../../locator.dart';
import 'api.dart';

class AuthenticationService {
  Api _api = locator<Api>();

  StreamController<User> userController = StreamController<User>();

  Future<String> createUser(String name) async {

    
    final prefs = await SharedPreferences.getInstance();

    //set name
    prefs.setString('name', name);

    Directory appDocDir = await getApplicationDocumentsDirectory();
    String appDocPath = appDocDir.path;

    var walletService = WalletService(appDocPath);
    walletService.make();

    // TO DO: check not to override existing wallet
    prefs.setString('ethereumAddress', walletService.ethereumAddress().toString());

    print(name);
    return name;
  }



  Future<String> getUser() async {

    final prefs = await SharedPreferences.getInstance();
    final user = prefs.getString('name') ?? null;

    print(user);
    return user;
  }
}