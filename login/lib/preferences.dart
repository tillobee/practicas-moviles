import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static bool _isDark=false;
  static int _primaryColor=const Color.fromARGB(255, 176, 255, 190).value;
  static int _secondaryColor=const Color.fromARGB(255, 3, 109, 6).value;
  static bool _isLogged = false;


  static late SharedPreferences _prefs;

  static Future preferences() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static set isDark(bool isDark){
    _isDark=isDark;
    _prefs.setBool('darkMode', isDark);
  }

  static bool get isDark{
    return _prefs.getBool('darkMode') ?? _isDark;
  }

  static set primaryColor(int primaryColor){
    _primaryColor=primaryColor;
    _prefs.setInt('primaryColor', primaryColor);
  }

  static int get primaryColor{
    return _prefs.getInt('primaryColor') ?? _primaryColor;
  }

  static set secondaryColor(int secondaryColor){
    _secondaryColor=secondaryColor;
    _prefs.setInt('secondaryColor', secondaryColor);
  }

  static int get secondaryColor{
    return _prefs.getInt('secondaryColor') ?? _secondaryColor;
  }

  static set isLogged(bool logged){
    _isLogged = logged;
    _prefs.setBool('isLogged', logged);
  }

  static bool get isLogged{
    return _prefs.getBool('isLogged') ?? _isLogged;
  }

}