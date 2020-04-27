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

  Future<bool> createUser(String name) async {
 
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
    return true;
  }



  Future<bool> login(String name) async {

    var fetchedUser = await _api.getUser();

    var hasUser = fetchedUser != null;
    if(hasUser) {
      userController.add(fetchedUser);
    }
    print(fetchedUser);
    return hasUser;
  }
}