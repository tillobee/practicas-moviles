import 'package:flutter/material.dart';

class StyleSettings {

  static ThemeData lightTheme(BuildContext context){
    final theme = ThemeData.light();
    return theme.copyWith(
      colorScheme:Theme.of(context).colorScheme.copyWith(
        primary: Color.fromARGB(255, 176, 255, 190),
        secondary: Color.fromARGB(255, 3, 109, 6),
      )
    );
  }

  static ThemeData darkTheme(BuildContext context){
    final theme = ThemeData.dark();
    return theme.copyWith(
      colorScheme:Theme.of(context).colorScheme.copyWith(
        primary: Color.fromARGB(255, 5, 72, 5),
        secondary: Color.fromARGB(255, 3, 109, 6)
      ),
    );
  }
}