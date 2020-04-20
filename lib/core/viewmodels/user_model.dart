import 'package:voting_app/core/enums/viewstate.dart';
import 'package:voting_app/core/services/auth_service.dart';
import 'package:voting_app/locator.dart';
import 'dart:math';
import 'package:web3dart/web3dart.dart';

import 'base_model.dart';

class UserModel extends BaseModel {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();

  Future<bool> login(String name) async {
    setState(ViewState.Busy);

    // Not a number
    if (name == null) {
      setState(ViewState.Idle);
      return false;
    }

    var success = await _authenticationService.login(name);

    setState(ViewState.Idle);
    print(success);
    return success;
  }
}
