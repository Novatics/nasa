import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:museum/models/coordinate.dart';
import 'package:museum/models/player.dart';
import 'package:location/location.dart';
import 'package:sensors/sensors.dart';
import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
import 'package:vector_math/vector_math_64.dart' as vector;
import 'package:museum/services/api.dart' as api;

class HUD extends StatefulWidget {
  static const routeName = 'HUD';

  @override
  State<StatefulWidget> createState() => _HUDState();
}

class _HUDState extends State<HUD> {
  ArCoreController arCoreController;
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
                    child: Text(qr, style: TextStyle(color: Colors.redAccent)),
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

  void _onArCoreViewCreated(ArCoreController _arController) {
    arCoreController = _arController;

    _addCylindre(arCoreController);
  }

  void _addCylindre(ArCoreController _controller) {
    final material = ArCoreMaterial(
      color: Colors.red,
      reflectance: 1.0,
    );
    final cylindre = ArCoreCylinder(
      materials: [material],
      radius: 0.5,
      height: 0.3,
    );
    final node = ArCoreNode(
      shape: cylindre,
      position: vector.Vector3(0.0, -0.5, -2.0),
    );
    _controller.addArCoreNode(node);
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
