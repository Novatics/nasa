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
              child: Container(
                color: Colors.white,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Card(
                      margin: EdgeInsets.all(0),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(30, 19, 26, 19),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Align(
                              alignment: Alignment.centerRight,
                              child: IconButton(
                                icon: Image.asset(
                                  'assets/images/close.png',
                                ),
                                onPressed: () => Navigator.pop(context),
                              ),
                            ),
                            Text(
                              'Monte o seu jogo',
                              style: TextStyle(
                                fontSize: 18,
                                color: Color.fromRGBO(90, 94, 96, 1),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(child: _satellitesListWidget(snapshot.data)),
                  ],
                ),
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
  return ListView.separated(
    padding: EdgeInsets.all(0),
    itemCount: satellites.length,
    separatorBuilder: (context, index) => Divider(),
    itemBuilder: (context, position) {
      return GestureDetector(
        child: Card(
          color: Colors.white,
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 22, 0),
                  child: Container(
                    width: 26,
                    height: 26,
                    decoration: ShapeDecoration(
                      shape: CircleBorder(
                        side: BorderSide(
                          width: 1,
                          color: Color.fromRGBO(144, 144, 144, 1),
                        ),
                      ),
                    ),
                  ),
                ),
                Text(satellites[position].name),
              ],
            ),
          ),
        ),
        onTap: () => print('tapped'),
      );
    },
  );
}
