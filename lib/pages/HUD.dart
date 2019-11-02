import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:museum/models/coordinate.dart';
import 'package:museum/models/player.dart';
import 'package:location/location.dart';
import 'package:sensors/sensors.dart';
import 'package:vector_math/vector_math_64.dart' as vector;
import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
import 'package:museum/services/api.dart' as api;

class HUD extends StatefulWidget {
  static const routeName = 'HUD';

  @override
  State<StatefulWidget> createState() => _HUDState();
}

class _HUDState extends State<HUD> {
  ArCoreController arCoreController;
  String objectSelected = 'fgb-ext_closed.sfb';
  String qr = '';
  Player player;
  Coordinate coordinate;
  LocationData locationData;
  String x;
  String y;
  String z;
  List<StreamSubscription<dynamic>> _streamSubscriptions =
      <StreamSubscription<dynamic>>[];
  var positionStream;
  var location = new Location();

  String getCurrentSatellite() {
    return player.availableSatellites.where((s) {
      return !player.collectedSatellites.contains(s);
    }).first;
  }

  @override
  void initState() {
    super.initState();

    _streamSubscriptions.add(gyroscopeEvents.listen((GyroscopeEvent event) {
      setState(() {
        x = event.x.toString();
        y = event.y.toString();
        z = event.z.toString();
      });
    }));

    _streamSubscriptions.add(location
        .onLocationChanged()
        .listen((LocationData currentLocation) async {
      String satelliteId = getCurrentSatellite();
      coordinate = await api.getCoordinates(
        satelliteId,
        currentLocation.latitude.toString(),
        currentLocation.longitude.toString(),
        currentLocation.altitude.toString(),
      );

      setState(() {
        locationData = currentLocation;
        coordinate = coordinate;
      });
    }));
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      player = ModalRoute.of(context).settings.arguments;
    });

    return Scaffold(
      body: Stack(
        children: <Widget>[
          ArCoreView(
            onArCoreViewCreated: _onArCoreViewCreated,
            enableTapRecognizer: true,
          ),
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: <Widget>[
              Positioned.fill(
                child: Align(
                  alignment: Alignment.center,
                  child: Image.asset('assets/images/focus.png'),
                ),
              ),
              Column(children: <Widget>[
                Expanded(
                  child: Align(
                    child: FloatingActionButton(
                      child: Icon(
                        Icons.add,
                      ),
                      onPressed: () => _addSatellite(),
                    ),
                    alignment: Alignment.center,
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Image.asset('assets/images/arrow.png'),
                  ),
                ),
              ]),
            ],
          ),
        ],
      ),
    );
  }

  void _onArCoreViewCreated(ArCoreController controller) {
    arCoreController = controller;
    arCoreController.onNodeTap = (name) => onTapHandler(name);
  }

  void _addSatellite() {
    final satelliteNode = ArCoreReferenceNode(
      name: objectSelected,
      obcject3DFileName: objectSelected,
      position: vector.Vector3(0.0, -0.5, -2.0),
    );

    arCoreController.addArCoreNode(satelliteNode);
  }

  void onTapHandler(String name) {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        content: Row(
          children: <Widget>[
            Text('Remover $name?'),
            IconButton(
                icon: Icon(
                  Icons.delete,
                ),
                onPressed: () {
                  arCoreController.removeNode(nodeName: name);
                  Navigator.pop(context);
                })
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    arCoreController.dispose();
    for (StreamSubscription<dynamic> subscription in _streamSubscriptions) {
      subscription.cancel();
    }
  }
}
