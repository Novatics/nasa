import 'package:flutter/material.dart';
import 'JoinGameForm.dart';


class Home extends StatelessWidget {
  void doSomething() {
    print('Chamou!');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: DecoratedBox(
            position: DecorationPosition.background,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/bg.png'), fit: BoxFit.cover),
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: <Widget>[
                    Padding(padding: const EdgeInsets.all(80.0)),
                    ImageRotate(),
                    Image.asset('assets/images/orbitar.png'),
                    Padding(padding: const EdgeInsets.all(90.0)),
                    Expanded(
                      child: Column(
                        children: <Widget>[
                          MaterialButton(
                            child: Text('Entrar em um jogo',
                                style: TextStyle(fontSize: 16.0)),
                            onPressed: () => Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => JoingGameForm()),
                              ),
                            color: Color.fromRGBO(254, 133, 110, 1),
                            textColor: Colors.white,
                            height: 50.0,
                            minWidth: 300.0,
                            shape: StadiumBorder(),
                          ),
                          Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: MaterialButton(
                                child: Text('Novo jogo',
                                    style: TextStyle(fontSize: 16.0)),
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
            )));
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
          child: new Image.asset('assets/images/logo.png'),
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
