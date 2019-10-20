import 'package:flutter/material.dart';
import 'JoinGameForm.dart';

class Congratulations extends StatelessWidget {
  void doSomething() {
    print('Chamou!');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DecoratedBox(
        position: DecorationPosition.background,
        decoration: BoxDecoration(color: Color.fromRGBO(254, 133, 110, 1)),
        child: Stack(
          children: <Widget>[
            Positioned(
              child: Align(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                        margin: EdgeInsets.only(bottom: 10),
                        child: Image.asset(
                          'assets/images/satelite.png',
                          width: 133,
                          height: 133,
                        )),
                    new Container(
                      child: Text(
                        "Parabéns!",
                        style: TextStyle(
                            fontFamily: 'Montreal',
                            fontSize: 20,
                            color: Color.fromRGBO(255, 255, 255, 1),
                            fontWeight: FontWeight.bold),
                      ),
                      margin: const EdgeInsets.only(bottom: 10),
                    ),
                    new Container(
                      child: Text(
                        "Você está na órbita do sucesso",
                        style: TextStyle(
                            fontFamily: 'Montreal',
                            fontSize: 18,
                            color: Color.fromRGBO(255, 255, 255, 1),
                            fontWeight: FontWeight.bold),
                      ),
                      margin: const EdgeInsets.only(top: 0),
                    ),
                  ],
                ),
              ),
            ),
            Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Container(
                    width: 300,
                    margin: EdgeInsets.only(bottom: 50),
                    child: Center(
                      child: MaterialButton(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                              child: Text(
                                'Começar novo jogo',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontFamily: 'Montreal',
                                    fontSize: 16,
                                    color: Color.fromRGBO(254, 133, 110, 1),
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => JoingGameForm()),
                        ),
                        color: Color.fromRGBO(255, 255, 255, 1),
                        height: 50.0,
                        minWidth: 300.0,
                        shape: StadiumBorder(),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ImageRotate extends StatefulWidget {
  @override
  _ImageRotateState createState() => new _ImageRotateState();
}

class _ImageRotateState extends State<ImageRotate>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController = new AnimationController(
      vsync: this,
      duration: new Duration(seconds: 7),
    );

    animationController.repeat();
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      alignment: Alignment.center,
      child: new AnimatedBuilder(
        animation: animationController,
        child: new Container(
          height: 150.0,
          width: 150.0,
          child: new Image.asset('assets/images/satelite.png'),
        ),
        builder: (BuildContext context, Widget _widget) {
          return new Transform.rotate(
            angle: animationController.value * 6.3,
            child: _widget,
          );
        },
      ),
    );
  }
}
