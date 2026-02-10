import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsProvider with ChangeNotifier {
  ThemeMode themeMode = .light;
  String languageCode = 'en';

  bool get isEnglish => languageCode == 'en';

  bool get isDark => themeMode == .dark;

  void loadLanguageAndTheme() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    
    bool isEnglishLanguage = preferences.getBool('isEnglishLanguage') ?? false;
    languageCode = isEnglishLanguage ? 'en' : 'ar';

    bool isDarkTheme = preferences.getBool('isEnglishLanguage') ?? false;
    themeMode = isDarkTheme ? .dark : .light;

    notifyListeners();
  }

  void changeLanguage(String language) async {
    if (languageCode == language) return;
    languageCode = language;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool('isEnglishLanguage', isEnglish);
    notifyListeners();
  }

  void changeTheme(ThemeMode theme) async {
    if (themeMode == theme) return;
    themeMode = theme;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool('isDarkTheme', isDark);
    notifyListeners();
  }
}
