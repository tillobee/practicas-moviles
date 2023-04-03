import 'package:flutter/material.dart';

class ListAgentsScreen extends StatefulWidget {
  const ListAgentsScreen({super.key});

  @override
  State<ListAgentsScreen> createState() => _ListAgentsScreenState();
}

class _ListAgentsScreenState extends State<ListAgentsScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(image: AssetImage('assets/background_gekko.png'),
          fit: BoxFit.fitWidth),
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [
              Colors.purple,
              Colors.yellow,
              Colors.black
            ]
          )
        ) ,
      ),
    );
  }
}