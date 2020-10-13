import 'package:shared_preferences/shared_preferences.dart';
import 'package:voting_app/core/enums/viewstate.dart';
import 'package:voting_app/core/services/auth_service.dart';
import 'package:voting_app/core/viewmodels/base_model.dart';
import 'package:voting_app/locator.dart';

class SettingsModel extends BaseModel {
  /*late*/ String user;
  String get getUser => user;
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();

  SettingsModel();

  Future setUser() async {
    var isUser = await _authenticationService.getUser();
    user = isUser;
    print(user);
  }

  Future clearUser() async {
    setState(ViewState.Busy);
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('name');
    setState(ViewState.Idle);
  }
}
