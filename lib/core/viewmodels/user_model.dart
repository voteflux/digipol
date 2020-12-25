import 'package:injectable/injectable.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:voting_app/core/enums/viewstate.dart';
import 'package:voting_app/core/services/auth_service.dart';
import 'package:voting_app/locator.dart';

import '../router.gr.dart';
import 'base_model.dart';

@injectable
class UserModel extends BaseModel {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  /*late*/ String user;

  final NavigationService _navigationService = locator<NavigationService>();

  UserModel();

  Future<String> login() async {
    setState(ViewState.Busy);

    var name = await _authenticationService.getUser();
    // TODO: might be a better way to pass a success/fail message - Meena
    if(name != null) // logged in successfully, redirect to the main screen.
      await _navigationService.replaceWith(Routes.mainScreen);

    setState(ViewState.Idle);
    return name;
  }

  Future create(String name) async {
    setState(ViewState.Busy);
    user = await _authenticationService.createUser(name);
    setState(ViewState.Idle);
  }
}
