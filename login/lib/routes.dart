import 'package:flutter/material.dart';
import 'package:login/screens/dashboard_screen.dart';
import 'package:login/screens/register_screen.dart';

Map<String, WidgetBuilder> getApplicationRoutes(){
  return <String,WidgetBuilder>{
    '/register':(BuildContext context) => const RegisterScreen(),
    '/dash':(BuildContext context) =>  DashboardScreen()
  };  
}