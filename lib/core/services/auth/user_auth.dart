import 'package:flutter/widgets.dart';

enum Status { Uninitialized, Authenticated, Authenticating, Unauthenticated }

class UserRepository with ChangeNotifier {

  Status _status = Status.Uninitialized;
  String _name;

  Status get status => _status;

  void signIn(String name) {
    if(name != '') {
      _status = Status.Authenticated;
      name = _name;
      notifyListeners();
    }
  }
}