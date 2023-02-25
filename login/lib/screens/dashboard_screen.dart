import 'package:day_night_switcher/day_night_switcher.dart';
import 'package:flutter/material.dart';
import 'package:login/provider/theme_provider.dart';
import 'package:login/settings/styles._settings.dart';
import 'package:provider/provider.dart';

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
      drawer: Drawer(
        child: ListView(
          children:  [
            const UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage('https://pps.whatsapp.net/v/t61.24694-24/322320749_1687092041708650_2296218376132150917_n.jpg?ccb=11-4&oh=01_AdQa6QoyysENgNH8h-nYVqCY-_t8QWWbPw12Ad-5WDfMpw&oe=63FA7EC0'),
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
            DayNightSwitcher(
              isDarkModeEnabled: isDarkModeEnabled, 
              onStateChanged:(isDarkModeEnabled){
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