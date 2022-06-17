
import 'package:flutter/material.dart';
import '../shared_preferences/app_preferences_controller.dart';

class ChangeLanguageNotifier extends ChangeNotifier{

  String languageCode = AppSettingsPreferances().langCode;
  void changeLanguage({required String languageCode}){
    this.languageCode =languageCode;
    AppSettingsPreferances().saveLanguage(language: languageCode);
    notifyListeners();
  }


}