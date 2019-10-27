import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:museum/pages/GeneratedGame.dart';
import 'package:museum/pages/HUD.dart';
import 'package:museum/pages/JoinGame.dart';
import 'package:museum/pages/JoinGameForm.dart';
import 'package:museum/pages/NewGame.dart';
import 'package:museum/pages/Home.dart';

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
      initialRoute: Home.routeName,
      routes: {
        Home.routeName: (context) => Home(),
        NewGame.routeName: (context) => NewGame(),
        JoinGame.routeName: (context) => JoinGame(),
        JoinGameForm.routeName: (context) => JoinGameForm(),
        GeneratedGame.routeName: (contex) => GeneratedGame(),
        HUD.routeName: (context) => HUD(),
      },
    );
  }
}
