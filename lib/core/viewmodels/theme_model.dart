import 'package:hive/hive.dart';
import 'package:voting_app/core/models/bill.dart';
import 'package:voting_app/core/models/block_chain_data.dart';
import 'package:voting_app/core/services/api.dart';
import 'package:voting_app/core/services/auth_service.dart';
import 'package:voting_app/core/viewmodels/base_model.dart';
import 'package:voting_app/locator.dart';

class ThemeModel extends BaseModel {
  Api _api = locator<Api>();
  bool isDarkMode = false;
  String user;
  String get getUser => user;
  bool get loggedIn => user == null ? false : true;
  Box<BlockChainData> blockChainData = Hive.box<BlockChainData>("block_chain_data");
  Box<Bill> billsBox = Hive.box<Bill>("bills");
  
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();

  void updateTheme(bool isDarkMode) {
    this.isDarkMode = isDarkMode;
    print(isDarkMode);
    notifyListeners();
  }

  Future<String> setUser() async {
    var isUser = await _authenticationService.getUser();
    user = isUser;
    print('user');
    return user;
  }
}
