import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:museum/models/satellite.dart';
import 'package:museum/pages/GeneratedGame.dart';
import 'package:museum/services/api.dart' as api;

class NewGame extends StatefulWidget {
  @override
  _NewGameState createState() => _NewGameState();
}

class _NewGameState extends State<NewGame> {
  List<Satellite> satellites = [];
  List<bool> selections = [];

  addOrRemoveSatellite(int position) {
    selections[position] = !selections[position];
    setState(() {
      selections = selections;
    });
  }

  createNewGame() {
    List<int> selectedSatellites = [];

    selections.asMap().forEach((index, selected) {
      if (selected) selectedSatellites.add(satellites[index].id);
    });

    api.createGame(selectedSatellites).then((data) {
      Navigator.of(context).pushNamed(GeneratedGame.routeName, arguments: data);
    });
  }

  @override
  void initState() {
    api.getSatellites().then((data) => {
          setState(() {
            satellites = data;
            selections = List.filled(data.length, false);
          })
        });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
            Expanded(
              child: _satellitesListWidget(
                satellites,
                selections,
                addOrRemoveSatellite,
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Container(
                margin: EdgeInsets.all(20),
                width: 260,
                height: 50,
                child: RaisedButton(
                  child: Text(
                    'Criar jogo',
                    style: TextStyle(color: Colors.white),
                  ),
                  color: Color.fromRGBO(254, 133, 110, 1),
                  onPressed: () => createNewGame(),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                    side: BorderSide(
                      width: 1,
                      color: Color.fromRGBO(144, 144, 144, 1),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

_satellitesListWidget(List<Satellite> satellites, List<bool> selections,
    Function onSatteliteSelected) {
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
                    child: selections[position]
                        ? Image.asset('assets/images/check.png')
                        : null,
                    width: 26,
                    height: 26,
                    decoration: selections[position]
                        ? null
                        : ShapeDecoration(
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
        onTap: () => onSatteliteSelected(position),
      );
    },
  );
}
