import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:museum/pages/Home.dart';

class GeneratedGame extends StatelessWidget {
  static const routeName = 'GeneratedGame';

  @override
  Widget build(BuildContext context) {
    final String code = ModalRoute.of(context).settings.arguments;
    final qrCode = new QrCode(4, QrErrorCorrectLevel.L);
    qrCode.addData("code");
    qrCode.make();

    return Material(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Column(
            children: <Widget>[
              QrImage(
                data: code,
                version: QrVersions.auto,
                size: 200.0,
              ),
              Text(
                'Código de acesso'.toUpperCase(),
                style: TextStyle(
                  color: Color.fromRGBO(144, 144, 144, 1),
                  fontSize: 12,
                ),
              ),
              Text(
                code.toString(),
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(90, 94, 96, 1),
                ),
              ),
            ],
          ),
          Column(
            children: <Widget>[
              Container(
                height: 50,
                width: 260,
                child: FlatButton(
                  child: Text(
                    'Voltar para o início',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () => Navigator.of(context).popUntil(
                    ModalRoute.withName(Home.routeName),
                  ),
                  color: Color.fromRGBO(254, 133, 110, 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                    side: BorderSide(
                      width: 1,
                      color: Color.fromRGBO(254, 133, 110, 1),
                    ),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
