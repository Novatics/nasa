import 'package:flutter/material.dart';
import 'package:flutter_3d_obj/flutter_3d_obj.dart';

class Estacao extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('3D'),
      ),
      body: new Center(
        child: new Object3D(
          
          size: const Size(400.0, 400.0),
          path: "assets/3ds/file.obj",
          asset: true,
        ),
      ),
    );
  }
}
