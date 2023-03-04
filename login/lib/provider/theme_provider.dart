import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier {

 late ThemeData themeData;
  
  ThemeProvider({required context,required bool isDark, required int primaryColor,required int secondaryColor,}){
    themeData=isDark?ThemeData.dark():ThemeData.light();
    themeData = themeData.copyWith(
      colorScheme: Theme.of(context).colorScheme.copyWith(
          primary: Color(primaryColor),
          secondary: Color(secondaryColor)
        )
    );
  }

  getThemeData() => this.themeData;

  setThemeData(ThemeData theme){
    this.themeData=theme;
    notifyListeners();
  }
}