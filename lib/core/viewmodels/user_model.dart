import 'package:voting_app/core/enums/viewstate.dart';
import 'package:voting_app/core/services/auth_service.dart';
import 'package:voting_app/locator.dart';

import 'base_model.dart';

class UserModel extends BaseModel {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();

  Future<String> login() async {
    setState(ViewState.Busy);

    var name = await _authenticationService.getUser();

    setState(ViewState.Idle);
    print(name);
    return name;
  }

  Future<String> create(String name) async {
    setState(ViewState.Busy);

    var user = await _authenticationService.createUser(name);

    setState(ViewState.Idle);
    return user;
  }

}
