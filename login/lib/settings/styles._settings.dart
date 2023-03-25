import 'package:flutter/material.dart';
import 'package:login/preferences.dart';

class StyleSettings {

  static ThemeData lightTheme(BuildContext context){
    //establece preferencias para el tema Claro DEFAULT
    Preferences.isDark=false;
    Preferences.primaryColor=Color.fromARGB(255, 176, 255, 190).value;
    Preferences.secondaryColor=Color.fromARGB(255, 3, 109, 6).value;

    final theme = ThemeData.light();
    return theme.copyWith(
      colorScheme:Theme.of(context).colorScheme.copyWith(
        primary: Color.fromARGB(255, 176, 255, 190),
        secondary: Color.fromARGB(255, 3, 109, 6),
      )
    );
  }

  static ThemeData darkTheme(BuildContext context){

    //establece preferencias para el tema Oscuro DEAULT
    Preferences.isDark=true;
    Preferences.primaryColor=Color.fromARGB(255, 5, 72, 5).value;
    Preferences.secondaryColor=Color.fromARGB(255, 3, 109, 6).value;

    final theme = ThemeData.dark();
    return theme.copyWith(
      colorScheme:Theme.of(context).colorScheme.copyWith(
        primary: Color.fromARGB(255, 5, 72, 5),
        secondary: Color.fromARGB(255, 3, 109, 6)
      ),
    );
  }
}