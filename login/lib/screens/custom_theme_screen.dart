import 'package:day_night_switcher/day_night_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:login/main.dart';
import 'package:login/provider/theme_provider.dart';
import 'package:provider/provider.dart';

import '../preferences.dart';

class CustomThemeScreen extends StatefulWidget {


  const CustomThemeScreen({super.key});

  @override
  State<CustomThemeScreen> createState() => _CustomThemeScreenState();
}

class _CustomThemeScreenState extends State<CustomThemeScreen> {

  bool isDarkModeEnabled = false;

  Color pickerColor = Colors.white;
  Color currentColor = Colors.black;

  ThemeData _customTheme = ThemeData(
    primaryColor: Colors.blue,
    accentColor: Colors.white,
    backgroundColor: Colors.white,
  );

  void changeColor(Color color){
    setState(() {
      pickerColor=color;
    });
  }

  @override
  Widget build(BuildContext context) {

    ThemeProvider theme = Provider.of<ThemeProvider>(context);
    ThemeData currentTheme = theme.getThemeData();


    _showPickerPrimary(){
      showDialog(
        context: context, 
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Pick osi'),
          content: SingleChildScrollView(
            child: MaterialPicker(
              pickerColor: pickerColor,
              onColorChanged: changeColor,
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              onPressed: (() {
                setState(() {
                  currentColor=pickerColor;


                  _customTheme= currentTheme.copyWith(
                    colorScheme: Theme.of(context).colorScheme.copyWith(
                      primary: currentColor
                    )
                  );

                  //Actualiza la variable global del tema o el PROVIDER del tema para que se actualice en toda la apicación
                  theme.setThemeData(_customTheme);

                  Preferences.primaryColor=currentColor.value;

                  //cierra el dialogo con el color picker
                  Navigator.of(context).pop();
                });
                Preferences.primaryColor=currentColor.value;
              }),
              child: const Text('Si'), 
            )
          ],
        )
      );
    }

    _showPickerAccent(){
      showDialog(
        context: context, 
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Pick an accent color'),
          content: SingleChildScrollView(
            child: MaterialPicker(
              pickerColor: pickerColor,
              onColorChanged: changeColor,
            )
          ),
          actions: <Widget>[
            ElevatedButton(
              onPressed: (() {
                setState(() {
                  currentColor=pickerColor;
                  _customTheme = currentTheme.copyWith(
                    colorScheme: Theme.of(context).colorScheme.copyWith(
                      secondary: currentColor
                    )
                  );
                  theme.setThemeData(_customTheme);

                  Preferences.secondaryColor=currentColor.value;

                  Navigator.of(context).pop();
                });
              }), 
              child: const Text('si'))
          ],
        )
      );
    }
  
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: (() {
          print(Preferences.isDark);
        }),
        child: const Icon(Icons.plus_one),
      ),
      body: Container(
        alignment: Alignment.center,
        child:  Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20,),
            ElevatedButton(
              onPressed: _showPickerPrimary,
              child: const Text('Choose primary color'),
            ),
            const SizedBox(height: 20,),
            ElevatedButton(
              onPressed: (_showPickerAccent), 
              child: const Text('Choose accent color'),
            ),
            const SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  onPressed: (){
                    setState(() {
                      _customTheme= ThemeData.light();
                      _customTheme = _customTheme.copyWith(
                        colorScheme: Theme.of(context).colorScheme.copyWith(
                          primary: currentTheme.colorScheme.primary,
                          secondary: currentTheme.colorScheme.secondary
                        )
                      );
                      Preferences.isDark=false;
                      theme.setThemeData(_customTheme);
                    });
                  },
                  label: const Text('Light'),
                  icon: const Icon(Icons.light_mode),
                ),
                const SizedBox(
                  width: 10,
                ),
                ElevatedButton.icon(
                  onPressed: (){
                    setState(() {
                      _customTheme= ThemeData.dark();
                      _customTheme = _customTheme.copyWith(
                        colorScheme: Theme.of(context).colorScheme.copyWith(
                          primary: currentTheme.colorScheme.primary,
                          secondary: currentTheme.colorScheme.secondary
                        )
                      );
                      Preferences.isDark=true;
                      theme.setThemeData(_customTheme);
                    });
                  },
                  label: const Text('Dark'),
                  icon: const Icon(Icons.dark_mode),
                )
              ],
            )
          ],
        ),
       ),
    );
  }
}