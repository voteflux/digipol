import 'package:flutter/widgets.dart';
import 'dart:math';
import 'package:web3dart/web3dart.dart';

enum Status { Uninitialized, Authenticated, Authenticating, Unauthenticated }

class UserRepository with ChangeNotifier {

  Status _status = Status.Uninitialized;
  String _name;
  EthPrivateKey _id;

  Status get status => _status;
  get name => _name;

  void signIn(String name) {
    if(name != '') {
      _status = Status.Authenticated;
      name = _name;
      var rng = new Random.secure();
      _id = EthPrivateKey.createRandom(rng);
      print(_id);
      notifyListeners();
    }
  }
}