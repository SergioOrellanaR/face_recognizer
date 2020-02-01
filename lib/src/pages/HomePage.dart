import 'package:camera/camera.dart';
import 'package:facial_recognizer/src/widgets/TakePhotoWidget.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  final List<CameraDescription> cameras;
  final Image image;
  HomePage({this.cameras, this.image});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Size _screenSize;

  @override
  Widget build(BuildContext context) {
    _screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: _appBar(),
      body: _body(),
      floatingActionButton: _cameraButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  AppBar _appBar() {
    return AppBar(
      title: Text("Facial Recognizer"),
      backgroundColor: Colors.orange,
    );
  }

  Row _body() {
    return Row(
      children: <Widget>[
        _bodyContent()
      ],
      mainAxisAlignment: MainAxisAlignment.center,
    );
  }

  Column _bodyContent() {
    return Column(children: <Widget>[
      SizedBox(
        height: _screenSize.height * 0.05,
      ),
      _imageBox()
    ], mainAxisAlignment: MainAxisAlignment.start);
  }

  ClipRRect _imageBox() {
    return ClipRRect(
      child: Container(
        width: _screenSize.width * 0.5,
        height: _screenSize.height * 0.3,
        child: widget.image ?? Image(image: AssetImage("assets/noImage.png"), fit: BoxFit.fill),
      ),
      borderRadius: BorderRadius.circular(30.0),
    );
  }

  FloatingActionButton _cameraButton() {
    return FloatingActionButton(
      backgroundColor: Colors.orange,
      foregroundColor: Colors.white,
      child: Icon(Icons.camera_alt),
      onPressed: ()
      {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => TakePhotoWidget(cameras: widget.cameras, cachedImage: widget.image)));        
      },
    );
  }
}
