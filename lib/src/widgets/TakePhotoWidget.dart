import 'dart:async';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:facial_recognizer/src/pages/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' show join;
import 'package:path_provider/path_provider.dart';

class TakePhotoWidget extends StatefulWidget {
  final List<CameraDescription> cameras;
  final Image cachedImage;

  const TakePhotoWidget({
    Key key,
    @required this.cameras,
    this.cachedImage
  }) : super(key: key);

  @override
  _TakePhotoWidgetState createState() => _TakePhotoWidgetState();
}

class _TakePhotoWidgetState extends State<TakePhotoWidget> {
  CameraController _controller;
  Future<void> _initializeControllerFuture;
  CameraDescription _camera;
  int _cameraIndex = 0;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed.
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        leading: IconButton(icon: Icon(Icons.arrow_back, color: Colors.white,), onPressed: (){
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => HomePage(cameras: widget.cameras, image: widget.cachedImage),
            ),
          );
        }, ),
        title: Text("Face Recognizer"),
      ),
      // Wait until the controller is initialized before displaying the
      // camera preview. Use a FutureBuilder to display a loading spinner
      // until the controller has finished initializing.
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // If the Future is complete, display the preview.
            return CameraPreview(_controller);
          } else {
            // Otherwise, display a loading indicator.
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: _buttons(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  Row _buttons(BuildContext context) {
    return Row(
      children: <Widget>[
        SizedBox(
          width: 30.0,
        ),
        _changeCameraButton(),
        Expanded(
          child: SizedBox(),
        ),
        _takePhoto(context)
      ],
    );
  }

  FloatingActionButton _takePhoto(BuildContext context) {
    return FloatingActionButton(
      heroTag: "takePhoto",
      backgroundColor: Colors.orange,
      foregroundColor: Colors.white,
      child: Icon(Icons.camera_alt),
      // Provide an onPressed callback.
      onPressed: () async {
        // Take the Picture in a try / catch block. If anything goes wrong,
        // catch the error.
        try {
          // Ensure that the camera is initialized.
          await _initializeControllerFuture;

          // Construct the path where the image should be saved using the
          // pattern package.
          final path = join(
            // Store the picture in the temp directory.
            // Find the temp directory using the `path_provider` plugin.
            (await getTemporaryDirectory()).path,
            '${DateTime.now()}.png',
          );

          // Attempt to take a picture and log where it's been saved.
          await _controller.takePicture(path);

          // If the picture was taken, display it on a new screen.
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => HomePage(cameras: widget.cameras, image: Image.file(File(path)),),
            ),
          );
        } catch (e) {
          // If an error occurs, log the error to the console.
          print(e);
        }
      },
    );
  }

  FloatingActionButton _changeCameraButton() {
    return FloatingActionButton(
      heroTag: "changeCameraButton",
      child: Icon(Icons.cached),
      backgroundColor: Colors.orange,
      foregroundColor: Colors.white,
      onPressed: _changeCamera,
    );
  }

  _changeCamera() {
    int _totalCameras = widget.cameras.length;
    setState(() {
      (_cameraIndex == _totalCameras - 1) ? _cameraIndex = 0 : _cameraIndex++;
      _initializeCamera();
      
    });
  }

  _initializeCamera()
  {
    if (widget.cameras.isNotEmpty) {
        _camera = widget.cameras[_cameraIndex];
      }
      _controller = CameraController(
        _camera,
        ResolutionPreset.veryHigh,
      );
      // Next, initialize the controller. This returns a Future.
      _initializeControllerFuture = _controller.initialize();
  }
}