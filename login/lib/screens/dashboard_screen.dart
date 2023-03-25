import 'package:day_night_switcher/day_night_switcher.dart';
import 'package:flutter/material.dart';
import 'package:login/provider/theme_provider.dart';
import 'package:login/screens/list_post.dart';
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
  void initState() {
    // TODO: implement initState
    super.initState();
    isDarkModeEnabled=Preferences.isDark;
  }

  @override
  Widget build(BuildContext context) {

   ThemeProvider theme = Provider.of<ThemeProvider>(context);


    return Scaffold(
      appBar: AppBar(
        title: Text('Osiosi'),
      ),
      body: ListPost(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: (() {
          Navigator.pushNamed(context, '/add');
        }),
        label: const Text('add post'),
        icon: const Icon(Icons.add_comment),
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
            ListTile(
              leading: const Icon(Icons.calendar_today),
              title: const Text('Calendario de eventos'),
              trailing: const Icon(Icons.chevron_right),
              subtitle: const Text('Visualiza tu agenda de eventos en un calendario.'),
              onTap:((){
                Navigator.pushNamed(context, '/si');
              }),
            ),
            ListTile(
              leading: const Icon(Icons.movie),
              title: const Text('Api peliculas'),
              trailing: const Icon(Icons.chevron_right),
              subtitle: const Text('Lista de peliculas populares de API TMBD.'),
              onTap:((){
                Navigator.pushNamed(context, '/popular_videos');
              }),
            ),
            DayNightSwitcher(
              isDarkModeEnabled: isDarkModeEnabled, 
              onStateChanged:(isDarkModeEnabled){
                //Preferences.isDark=isDarkModeEnabled; //Establlecer la preferencia dentro de styleSettins para que no interfiera el switch con los botones de pantalla tema personalizado
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