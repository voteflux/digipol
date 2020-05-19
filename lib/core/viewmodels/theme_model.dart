import 'package:voting_app/core/services/api.dart';
import 'package:voting_app/core/viewmodels/base_model.dart';
import 'package:voting_app/locator.dart';

class ThemeModel extends BaseModel {
  Api _api = locator<Api>();
  bool isDarkMode = false;
  String user;
  String get getUser => user;
  bool get loggedIn => user == null ? false : true;
  
  void updateTheme(bool isDarkMode) {
    this.isDarkMode = isDarkMode;
    print(isDarkMode);
    notifyListeners();
  }
}
