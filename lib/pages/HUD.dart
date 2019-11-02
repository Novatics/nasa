import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:museum/models/coordinate.dart';
import 'package:museum/models/player.dart';
import 'package:qr_mobile_vision/qr_camera.dart';
import 'package:geolocator/geolocator.dart';
import 'package:museum/services/api.dart' as api;

class HUD extends StatefulWidget {
  static const routeName = 'HUD';

  @override
  State<StatefulWidget> createState() => _HUDState();
}

class _HUDState extends State<HUD> {
  String qr = '';
  Position position;
  Player player;
  var geolocator = Geolocator();
  var locationOptions = LocationOptions(accuracy: LocationAccuracy.high, distanceFilter: 15);
  var positionStream;

  String getCurrentSatellite() {
    return player.availableSatellites.where((s) {
      return !player.collectedSatellites.contains(s);
    }).first;
  }

  @override
  void initState() {
    super.initState();

    Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.best).then((position) async {
      String satelliteId = getCurrentSatellite();
      Coordinate coordinate = await api.getCoordinates(satelliteId, position.latitude.toString(), position.longitude.toString(), position.altitude.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      player = ModalRoute.of(context).settings.arguments;
    });

    return Scaffold(
        body: Stack(
      children: <Widget>[
        new QrCamera(
          onError: (context, error) => Text(
            error.toString(),
            style: TextStyle(color: Colors.red),
          ),
          qrCodeCallback: (code) {
            setState(() {
              qr = code;
            });
          },
          child: Stack(
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
        ),
      ],
    ));
  }
}
