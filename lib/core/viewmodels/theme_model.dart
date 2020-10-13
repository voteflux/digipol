import 'package:hive/hive.dart';
import 'package:voting_app/core/viewmodels/base_model.dart';

import '../consts.dart';

class ThemeModel extends BaseModel {
  var userPrefsBools = Hive.box<bool>(HIVE_USER_PREFS_BOOLS);
  bool isDarkMode = false;

  // change theme via switch and save in hive
  void updateTheme(bool value) {
    userPrefsBools.put('darkMode', value);
    this.isDarkMode = value;
    print(value);
    notifyListeners();
  }

  // set theme on load
  void setTheme() {
    var userPrefsBools = Hive.box<bool>(HIVE_USER_PREFS_BOOLS);
    bool darkMode = userPrefsBools.get('darkMode', defaultValue: false);
    this.isDarkMode = darkMode;
    notifyListeners();
  }
}
