import 'package:flutter/material.dart';
import 'package:login/settings/styles._settings.dart';

class ThemeProvider with ChangeNotifier {

  ThemeData? _themeData;
  ThemeProvider(BuildContext context){
    _themeData=StyleSettings.lightTheme(context);
  }

  getThemeData() => this._themeData;

  setThemeData(ThemeData theme){
    this._themeData=theme;
    notifyListeners();
  }
}