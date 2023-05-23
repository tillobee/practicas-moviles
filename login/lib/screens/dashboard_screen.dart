import 'package:day_night_switcher/day_night_switcher.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login/firebase/git_auth.dart';
import 'package:login/firebase/google_auth.dart';
import 'package:login/provider/theme_provider.dart';
import 'package:login/provider/user_provider.dart';
import 'package:login/screens/list_favourites_cloud.dart';
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
  GoogleAuth _googleAuth = GoogleAuth();
  GitAuth _gitAuth = GitAuth();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isDarkModeEnabled=Preferences.isDark;
  }

  @override
  Widget build(BuildContext context) {

   ThemeProvider theme = Provider.of<ThemeProvider>(context);

   final userProvider = context.watch<UserProvider>();
   UserCredential user = userProvider.getUserData();
   String name;

   if(user.user!.displayName != null){
    name = user.user!.displayName!;
   }else if(user.additionalUserInfo!.profile!['name']!=null){
    name = user.additionalUserInfo!.profile!['name'];
   }else if(user.additionalUserInfo!.username != null){
    name = user.additionalUserInfo!.username!;
   }else{
    name= 'no name available';
   }

    return Scaffold(
      appBar: AppBar(
        title: Text('Osiosi'),
      ),
      /* body: ListFavouritesCloud(), */ //ListPost(),
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
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: user.user!.photoURL != null ? 
                  NetworkImage(user.user!.photoURL!): 
                  const NetworkImage('https://upload.wikimedia.org/wikipedia/commons/8/89/Portrait_Placeholder.png')
              ),
              accountName: Text(name), 
              accountEmail: Text(user.user!.email!)
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
             ListTile(
              leading: const Icon(Icons.co_present_rounded),
              title: const Text('Valorant API - Agentes'),
              trailing: const Icon(Icons.chevron_right),
              subtitle: const Text('Lista de agentes de Valorant'),
              onTap:((){
                Navigator.pushNamed(context, '/list_agents');
              }),
            ),
            ListTile(
              leading: const Icon(Icons.map),
              title: const Text('Mapas'),
              trailing: const Icon(Icons.chevron_right),
              subtitle: const Text('mapas'),
              onTap:((){
                Navigator.pushNamed(context, '/maps');
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
              }
            ),
            Padding( //Sign Out button
              padding: const EdgeInsets.all(10.0),
              child: ElevatedButton(
                onPressed: (){
                  _signOut(user.additionalUserInfo!.providerId);
                }, 
                style: ButtonStyle(
                  elevation: MaterialStateProperty.all(10),
                  backgroundColor: MaterialStateProperty.all(Colors.red)
                ),
                child: const Text('sign out'),
              ),
            ),

          ],
        ),
      ),
    );
  }

  _signOut(String? provider){
    switch(provider){
      case 'github.com':{
        //GitAuth.signOut()
        _gitAuth.gitEmailSignOut();
        Navigator.pushNamed(context, '/home');
      }  
      break;
      
      case 'google.com':{
        //GoogleAuth.signOut()
        _googleAuth.googleSignOut();
        Navigator.pushNamed(context, '/home');
      } 
      break;
      
      default:{
        //EmailAuth.signOut()
        _gitAuth.gitEmailSignOut();
        Navigator.pushNamed(context, '/home');
      }
      break;

    }

  }
}