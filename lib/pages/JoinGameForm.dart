import 'package:flutter/material.dart';

class JoingGameForm extends StatefulWidget {
  @override
  _JoinGameState createState() => _JoinGameState();
}

class _JoinGameState extends State<JoingGameForm> {
  final _formKey = GlobalKey<FormState>();
  String nickname = "";
  @override
  void initState() {
    super.initState();
  }

  // @override
  // void dispose() {
  //   controller?.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(children: <Widget>[
          new Container(
            child: 
            Image.asset('assets/images/logo.png'),
            margin: const EdgeInsets.only(top: 123),
            ),
          new Container(
            child: Text(
              "NICKNAME",
              style: TextStyle(
                  fontFamily: 'Montreal-Bold', 
                  fontSize: 12, 
                  color: Color.fromRGBO(114, 114, 114, 0.7),
                  fontWeight: FontWeight.bold
                ),
              ),
            margin: const EdgeInsets.only(top: 114),
          ),
          new Container(
            child:
              Form(
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
                        borderRadius: const BorderRadius.all(const Radius.circular(25.0)),
                      ),
                    )
                ),
              ),
              width: 260,
              height: 50,
              margin: const EdgeInsets.only(top: 10),
          )
        ],),
      ),
    );
  }
}
