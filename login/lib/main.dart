import 'package:concentric_transition/concentric_transition.dart';
import 'package:login/card_onboard.dart';
import 'package:login/provider/theme_provider.dart';
import 'package:login/routes.dart';
import 'package:login/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_)=>ThemeProvider(context)
        )
      ],
      child: PMSNApp(),
    );
  }
}

class PMSNApp extends StatelessWidget {
  const PMSNApp({super.key});

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