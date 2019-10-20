import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  void doSomething() {
    print('Chamou!');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            Padding(padding: const EdgeInsets.all(80.0)),
            Expanded(
              child: Image.asset('assets/images/logo.png'),
            ),
            Padding(padding: const EdgeInsets.all(100.0)),
            Expanded(
              child: Column(
                children: <Widget>[
                  MaterialButton(
                    child: Text('Entrar em um jogo',
                        style: TextStyle(fontSize: 16.0)),
                    onPressed: doSomething,
                    color: Color.fromRGBO(254, 133, 110, 1),
                    textColor: Colors.white,
                    height: 50.0,
                    minWidth: 300.0,
                    shape: StadiumBorder(),
                  ),
                  Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: MaterialButton(
                        child:
                            Text('Novo jogo', style: TextStyle(fontSize: 16.0)),
                        onPressed: doSomething,
                        textColor: Color.fromRGBO(254, 133, 110, 1),
                        height: 50.0,
                        minWidth: 300.0,
                      ))
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
