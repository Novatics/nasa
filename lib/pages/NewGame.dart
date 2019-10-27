import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:museum/models/satellite.dart';
import 'package:museum/services/api.dart' as api;

class NewGame extends StatefulWidget {
  @override
  _NewGameState createState() => _NewGameState();
}

class _NewGameState extends State<NewGame> {
  List<Satellite> satellites;
  List<int> selections;

  @override
  void initState() {
    super.initState();
    setState(() {
      satellites = [];
      selections = [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Satellite>>(
      future: api.getSatellites(),
      builder: (BuildContext context, AsyncSnapshot<List<Satellite>> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            if (snapshot.hasError) {
              return Text('Error on fetching data');
            }
            return SafeArea(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Text('sdf'),
                    ),
                  ),
                  Expanded(child: _satellitesListWidget(snapshot.data)),
                ],
              ),
            );
          default:
            return Text('Data Fetched');
        }
      },
    );
  }
}

_satellitesListWidget(List<Satellite> satellites) {
  return ListView.builder(
    itemCount: satellites.length,
    itemBuilder: (context, position) {
      return GestureDetector(
        child: Card(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Container(child: Text(satellites[position].name)),
          ),
        ),
        onTap: () => print('tapped'),
      );
    },
  );
}
