import 'package:hive/hive.dart';
import 'package:voting_app/core/viewmodels/base_model.dart';

class ThemeModel extends BaseModel {
  Box userPreferencesBox = Hive.box("user_preferences");
  bool isDarkMode = false;
  
  // change theme via switch and save in hive
  void updateTheme(bool value) {
    userPreferencesBox.put('darkMode', value);
    this.isDarkMode = value;
    print(value);
    notifyListeners();
  }

  // set theme on load
  void setTheme(){
    Box userPreferencesBox = Hive.box("user_preferences");
    bool darkMode = userPreferencesBox.get('darkMode', defaultValue: false);
    this.isDarkMode = darkMode;
    notifyListeners();
  }
}
