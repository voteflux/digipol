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
  String pincode;
  bool wrongPin = false;
  bool isUser = false;

  final NavigationService _navigationService = locator<NavigationService>();

  UserModel();

  Future<String> start() async {
    setState(ViewState.Busy);

    var name = await _authenticationService.getUser();
    if (name != null) {
      user = name;
      isUser = true;
    }

    setState(ViewState.Idle);
    return name;
  }

  Future<String> login(String pincode) async {
    var userPincode = await _authenticationService.getUserPin();
    print(userPincode);
    if (userPincode == pincode) {
      await _navigationService.replaceWith(Routes.mainScreen);
    } else {
      wrongPin = true;
      print('incorrect pin');
      notifyListeners();
    }
  }

  Future create(String name, String pincode) async {
    setState(ViewState.Busy);
    user = await _authenticationService.createUser(name, pincode);
    setState(ViewState.Idle);
  }
}
