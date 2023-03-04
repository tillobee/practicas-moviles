import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static bool _isDark=false;
  static int _primaryColor=4280391411;
  static int _secondaryColor=4294967295;


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


}