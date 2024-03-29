import 'package:flutter/material.dart';
import 'package:museum/services/api.dart' as api;

import 'HUD.dart';

class JoinGameForm extends StatefulWidget {
  static const routeName = 'JoinGameForm';

  @override
  _JoinGameState createState() => _JoinGameState();
}

class _JoinGameState extends State<JoinGameForm> {
  final _formKey = GlobalKey<FormState>();
  final _codeKey = GlobalKey<FormState>();
  String nickname = "";
  String code = "";
  @override
  void initState() {
    super.initState();
  }

  joinGame(String code, String nickname) {
    api.joinGame(code, nickname).then((player) {
      Navigator.of(context).pushNamed(
        HUD.routeName,
        arguments: player,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              new Container(
                child: Image.asset('assets/images/logoJoin.png'),
                margin: const EdgeInsets.only(top: 30),
              ),
              new Container(
                child: Text(
                  "NICKNAME",
                  style: TextStyle(
                      fontFamily: 'Montreal',
                      fontSize: 12,
                      color: Color.fromRGBO(114, 114, 114, 0.7),
                      fontWeight: FontWeight.bold),
                ),
                margin: const EdgeInsets.only(top: 114),
              ),
              new Container(
                child: Form(
                  key: _formKey,
                  child: TextFormField(
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Digite seu nickname';
                        }
                        return null;
                      },
                      onChanged: (text) {
                        nickname = text;
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                              const Radius.circular(25.0)),
                        ),
                      )),
                ),
                width: 260,
                height: 50,
                margin: const EdgeInsets.only(top: 10),
              ),
              new Container(
                child: Text(
                  "CÓDIGO DE ACESSO",
                  style: TextStyle(
                      fontFamily: 'Montreal',
                      fontSize: 12,
                      color: Color.fromRGBO(114, 114, 114, 0.7),
                      fontWeight: FontWeight.bold),
                ),
                margin: const EdgeInsets.only(top: 25),
              ),
              new Container(
                child: Form(
                  key: _codeKey,
                  child: TextFormField(
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Digite o código do jogo';
                        }
                        return null;
                      },
                      onChanged: (text) {
                        code = text;
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                              const Radius.circular(25.0)),
                        ),
                      )),
                ),
                width: 260,
                height: 50,
                margin: const EdgeInsets.only(top: 10),
              ),
              new Container(
                  child: new RaisedButton(
                    onPressed: () {
                      if (_formKey.currentState.validate() &&
                          _codeKey.currentState.validate()) {
                        joinGame(code, nickname);
                      }
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(25.0),
                    ),
                    color: Color.fromRGBO(254, 133, 110, 1),
                    child: Text(
                      'Entrar',
                      style: TextStyle(
                          fontFamily: 'Montreal',
                          fontSize: 16,
                          color: Color.fromRGBO(255, 255, 255, 1),
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  width: 260,
                  height: 50,
                  margin: const EdgeInsets.only(top: 60),
                  decoration: new BoxDecoration(boxShadow: [
                    BoxShadow(
                      color: Color.fromRGBO(60, 51, 82, 0.15),
                      blurRadius:
                          10.0, // has the effect of softening the shadow
                    )
                  ]))
            ],
          ),
        ),
      ),
    );
  }
}
