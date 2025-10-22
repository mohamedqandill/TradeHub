import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import 'package:tradehub/core/constants/app_constants.dart';
import 'package:tradehub/core/utils/shared_prefs/prefs.dart';

@injectable
class LanguageViewModel extends ChangeNotifier {
  static const String languagekey = AppConstants.langKey;

  Locale currentLocale = const Locale(AppConstants.en);

  SharedPrefsHelper prefs = SharedPrefsHelper();

  loadLanguage() {
    var savedLocale = prefs.getString(AppConstants.langKey);
    if (savedLocale != null) {
      currentLocale = Locale(savedLocale);
      notifyListeners();
    }
  }

  changeLanguage(String langCode) async {
    await prefs.saveString(AppConstants.langKey, langCode);
    currentLocale = Locale(langCode);

    notifyListeners();
  }

  bool get isArabic => currentLocale.languageCode == AppConstants.ar;
}
