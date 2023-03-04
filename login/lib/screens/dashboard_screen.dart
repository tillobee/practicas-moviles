import 'package:day_night_switcher/day_night_switcher.dart';
import 'package:flutter/material.dart';
import 'package:login/provider/theme_provider.dart';
import 'package:login/settings/styles._settings.dart';
import 'package:provider/provider.dart';

import '../preferences.dart';

class DashboardScreen extends StatefulWidget {
  DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  bool isDarkModeEnabled=false;

  @override
  Widget build(BuildContext context) {

   ThemeProvider theme = Provider.of<ThemeProvider>(context);


    return Scaffold(
      appBar: AppBar(
        title: Text('Osiosi'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (() {}),
        child: const Icon(Icons.draw_outlined),
      ),
      drawer: Drawer(
        child: ListView(
          children:  [
            const UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage('https://logos.flamingtext.com/Word-Logos/si-design-china-name.png'),
              ),
              accountName: Text('Jou dou'), 
              accountEmail: Text('jd@gmail.com')
            ),
            const ListTile(
              leading: Icon(Icons.settings),
              title: Text('Practica 1'),
              trailing: Icon(Icons.chevron_right),
              subtitle: Text('Descripcion de la practica'),
            ),
            ListTile(
              leading: const Icon(Icons.draw),
              title: const Text('Crear tema'),
              trailing: const Icon(Icons.chevron_right),
              subtitle: const Text('Elegír tema personalizado para la aplicación'),
              onTap:((){
                Navigator.pushNamed(context, '/custom_theme');
              }),
            ),
            DayNightSwitcher(
              isDarkModeEnabled: isDarkModeEnabled, 
              onStateChanged:(isDarkModeEnabled){
                Preferences.isDark=isDarkModeEnabled;
                isDarkModeEnabled
                ?theme.setThemeData(StyleSettings.darkTheme(context))
                :theme.setThemeData(StyleSettings.lightTheme(context));
                this.isDarkModeEnabled=isDarkModeEnabled;
                setState(() {});
            })
          ],
        ),
      ),
    );
  }
}