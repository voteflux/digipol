import 'dart:async';

import 'package:voting_app/core/models/user.dart';

import '../../locator.dart';
import 'api.dart';

class AuthenticationService {
  Api _api = locator<Api>();

  StreamController<User> userController = StreamController<User>();

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