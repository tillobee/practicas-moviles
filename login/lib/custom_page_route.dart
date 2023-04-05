import 'package:flutter/material.dart';

class CustomPageRoute extends PageRouteBuilder {

  final Widget child;

  CustomPageRoute({
    required this.child,
    RouteSettings? settings,
  }):super(
    /* transitionDuration: const Duration(seconds: 1),
    reverseTransitionDuration: const Duration(seconds: 1), */
    pageBuilder: (context, animation, secondaryAnimation)=>child,
    settings: settings
  );

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {

    animation=CurvedAnimation(
      parent: animation, 
      curve: Curves.linearToEaseOut
    );

    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(0,1),
        end: Offset.zero
      ).animate(animation),
      child: child,
    ); 

  }

}