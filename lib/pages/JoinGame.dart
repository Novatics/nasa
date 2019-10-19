import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

List<CameraDescription> cameras;

class JoinGame extends StatefulWidget {
  @override
  _JoinGameState createState() => _JoinGameState();
}

class _JoinGameState extends State<JoinGame> {
  CameraController controller;

  @override
  void initState() {
    super.initState();
    availableCameras().then((availableCameras) {
      cameras = availableCameras;

      controller = CameraController(cameras[0], ResolutionPreset.medium);
      controller.initialize().then((_) {
        if (!mounted) {
          return;
        }
        setState(() {});
      });
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!controller.value.isInitialized) {
      return Text('Camera did not load yet!');
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Join Game'),
      ),
      body: AspectRatio(
        aspectRatio: controller.value.aspectRatio,
        child: CameraPreview(controller)
      ),
    );
  }
}
