import 'package:flutter/material.dart';

class SettingsModel extends ChangeNotifier {
  bool isDarkMode = false;

  void updateTheme(bool isDarkMode) {
    this.isDarkMode = isDarkMode;
    print(isDarkMode);
    notifyListeners();
  }
}
