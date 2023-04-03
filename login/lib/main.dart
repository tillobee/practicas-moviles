import 'package:concentric_transition/concentric_transition.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:login/card_onboard.dart';
import 'package:login/database/database_helper.dart';
import 'package:login/models/favourite_model.dart';
import 'package:login/preferences.dart';
import 'package:login/provider/favourites_provider.dart';
import 'package:login/provider/flags_provider.dart';
import 'package:login/provider/theme_provider.dart';
import 'package:login/routes.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Preferences.preferences();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  static SharedPreferences? mainPrefs;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  DatabaseHelper? databaseHelper;
  List<FavouriteModel>? _favs=[];

  _loadApp() async {
    MyApp.mainPrefs = await SharedPreferences.getInstance();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    databaseHelper =DatabaseHelper();
    _getFavourites();
    _loadApp();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
     providers: [
        ChangeNotifierProvider(
          create: (_)=>ThemeProvider(
            context:context, 
            isDark: Preferences.isDark, 
            primaryColor: Preferences.primaryColor, 
            secondaryColor: Preferences.secondaryColor
          )
        ),
        ChangeNotifierProvider(
          create: (_)=>FlagsProvider()
        ),
        ChangeNotifierProvider(
          create: (_)=>FavouritesProvider(favourites: _favs!))
      ],
      child: PMSNApp()
    );
  }

  _getFavourites(){
    _favs=[];
    Future res = databaseHelper!.getFavourites();
    res.then((data){
      for (var fav in data) {
        FavouriteModel favourite = fav;
        _favs!.add(favourite);
      }
    },onError: (e)=>print(e));
  }
}

class PMSNApp extends StatefulWidget {
  const PMSNApp({super.key});

  @override
  State<PMSNApp> createState() => _PMSNAppState();
}

class _PMSNAppState extends State<PMSNApp> {

  @override
  Widget build(BuildContext context) {
    ThemeProvider theme = Provider.of<ThemeProvider>(context);

    return  MaterialApp(
      theme: theme.getThemeData(),
      routes: getApplicationRoutes(),
      home: onBoarding(),
    );
  }
}

class onBoarding extends StatelessWidget {
  onBoarding({super.key});

  final  data=[
    CardOnBoardData(
      title: "Bienvenido a Vlr-Social!", 
      subtitle: "Tu pequeño espacio personal para conocer personas con tu mismo gusto por Valonxo",
      image: AssetImage('assets/breach2.png'), 
      backgroundColor: Color.fromARGB(255, 204, 105, 97), 
      titleColor: Colors.black, 
      subtitleColor: Colors.yellow,
      background: LottieBuilder.asset('assets/animation/bg.json')
    ),
    CardOnBoardData(
      title: "Comparte tus mejores momentos!", 
      subtitle: "En esta red social podrás postear tus imagenes relacionadas a tus partidos y mejores jugadas de Vaolnxo para impresionar a tus amigos",
      image: AssetImage('assets/fade.png'), 
      backgroundColor: Color.fromARGB(255, 97, 103, 111), 
      titleColor: Colors.black, 
      subtitleColor: Colors.yellow,
      background: LottieBuilder.asset('assets/animation/bg.json')
    ),
    CardOnBoardData(
      title: "Ve el contenido de tus amigos!", 
      subtitle: "De igual manera tu puedes ver los momentos y logros que comparten tus amigos, puede que aprendas un poco jeje...",
      image: AssetImage('assets/sage.png'), 
      backgroundColor: Color.fromARGB(255, 178, 86, 235), 
      titleColor: Colors.black, 
      subtitleColor: Colors.yellow,
      background: LottieBuilder.asset('assets/animation/bg.json')
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
        ConcentricPageView(
          colors: data.map((e) => e.backgroundColor).toList(),
          itemCount: data.length,
          itemBuilder:(int index){
            return CardOnBoard(data: data[index]);
          } ,
          onFinish: (){
            Navigator.pushNamed(context, '/home');
          },
        )
    );
  }
}