import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsProvider with ChangeNotifier {
  String languageCode = 'en';

  bool get isEnglish => languageCode == 'en';

  void loadLanguage() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    bool isEnglishLanguage = preferences.getBool('isEnglishLanguage') ?? false;
    languageCode = isEnglishLanguage ? 'en' : 'ar';
    notifyListeners();
  }

  void changeLanguage(String language) async {
    if (languageCode == language) return;
    languageCode = language;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool('isEnglishLanguage', isEnglish);
    notifyListeners();
  }
}
