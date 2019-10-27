import 'package:flutter/material.dart';

class GeneratedGame extends StatelessWidget {
  static const routeName = '/game/show';

  @override
  Widget build(BuildContext context) {
    final String code = ModalRoute.of(context).settings.arguments;

    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Column(
            children: <Widget>[
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
                    'Baixar QR codes',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () => Navigator.of(context).popUntil(
                    ModalRoute.withName('/'),
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
