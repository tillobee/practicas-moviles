import 'package:day_night_switcher/day_night_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:login/provider/theme_provider.dart';
import 'package:provider/provider.dart';

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
            child: BlockPicker(
              pickerColor: pickerColor,
              onColorChanged: changeColor,
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              onPressed: (() {
                setState(() {
                  currentColor=pickerColor;
                  /* crea una copia de la data del tema actual y genera uno nuevo sobreescribiendo las propiedades que se especifican 
                    en el copyWith (COPIA CON) */

                  /* _customTheme=_customTheme.copyWith(
                    //Sobreescribe el color del fondo de la aplicación
                    backgroundColor: currentColor
                  ); */

                  _customTheme= currentTheme.copyWith(
                    colorScheme: Theme.of(context).colorScheme.copyWith(
                      primary: currentColor
                    )
                  );

                  //Actualiza la variable global del tema o el PROVIDER del tema para que se actualice en toda la apicación
                  theme.setThemeData(_customTheme);
                  //cierra el dialogo con el color picker
                  Navigator.of(context).pop();
                });
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
            child: BlockPicker(
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
        onPressed: (() {}),
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
          ],
        ),
       ),
    );
  }
}