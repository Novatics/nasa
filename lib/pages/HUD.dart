import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:museum/models/player.dart';
import 'package:qr_mobile_vision/qr_camera.dart';

class HUD extends StatefulWidget {
  static const routeName = 'HUD';

  @override
  State<StatefulWidget> createState() => _HUDState();
}

class _HUDState extends State<HUD> {
  String qr = '';

  @override
  void initState() {
    super.initState();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final Player player = ModalRoute.of(context).settings.arguments;
    print(player.nickname);
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
