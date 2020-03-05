import 'package:camera/camera.dart';
import 'package:facial_recognizer/src/widgets/OperationButtonWidget.dart';
import 'package:facial_recognizer/src/widgets/TakePhotoWidget.dart';
import 'package:facial_recognizer/utils/utils.dart'  as utils;
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
      appBar: utils.appBar(),
      body: _body()
    );
  }

  

  ListView _body() {
    return ListView(children: <Widget>[
      SizedBox(
        height: _screenSize.height * 0.05,
      ),
      Align(child: _imageBox(), alignment: Alignment.center,),
      SizedBox(
        height: _screenSize.height * 0.1,
      ),
      OperationButton(message: "Registrar persona", backgroundColor: Colors.lightBlue, function: _registerPersonFunction(), isMainButton: true,),
      utils.verticalSeparator(),
      OperationButton(message: "Eliminar persona", backgroundColor: Colors.red, function: _deletePersonFunction, isMainButton: true),
      utils.verticalSeparator(),
      OperationButton(message: "Reconocer persona por imagen", backgroundColor: Colors.green, function: _recognizePersonFunction, isMainButton: true)
    ]);
  }


  ClipRRect _imageBox() {
    return ClipRRect(
      child: Container(
        width: _screenSize.width * 0.6,
        height: _screenSize.height * 0.3,
        child: widget.image ??
            Image(image: AssetImage("assets/noImage.png"), fit: BoxFit.fill),
      ),
      borderRadius: BorderRadius.circular(20.0),
    );
  }

  Function _registerPersonFunction()
  {
    return (){
      Navigator.pushNamed(context, "registration");
    };
  }

  Function _deletePersonFunction()
  {
    return (){

    };
  }

  Function _recognizePersonFunction()
  {
    return (){

    };
  }

  Widget _cameraButton() {
    if (widget.cameras.isNotEmpty) {
      return FloatingActionButton(
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
        child: Icon(Icons.camera_alt),
        onPressed: () {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => TakePhotoWidget(
                      cameras: widget.cameras, cachedImage: widget.image)));
        },
      );
    } else {
      return Text("Usted necesita una cámara para poder usar este programa");
    }
  }
}
