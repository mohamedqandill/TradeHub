import 'package:flutter/material.dart';
import 'package:tradehub/core/constants/app_constants.dart';
import 'package:tradehub/core/utils/shared_prefs/prefs.dart';

class ThemeViewModel extends ChangeNotifier {
  late ThemeMode mode;
  SharedPrefsHelper prefs = SharedPrefsHelper();
  getSavedTheme() {
    bool isDark = prefs.getBool(AppConstants.isDarkMode) ?? false;
    mode = isDark ? ThemeMode.dark : ThemeMode.light;
  }

  changeTheme(ThemeMode themeMode) {
    mode = themeMode;
    prefs.saveBool(AppConstants.isDarkMode, mode == ThemeMode.dark);
    notifyListeners();
  }
}
