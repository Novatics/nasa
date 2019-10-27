import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:museum/pages/GeneratedGame.dart';
import 'package:museum/pages/JoinGame.dart';
import 'package:museum/pages/NewGame.dart';

import 'pages/Home.dart';

void main() async {
  Position position = await Geolocator()
      .getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
  print(position);
  return runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => Home(),
        '/game/new': (context) => NewGame(),
        '/game/join': (context) => JoinGame(),
        '/game/show': (contex) => GeneratedGame(),
      },
    );
  }
}
