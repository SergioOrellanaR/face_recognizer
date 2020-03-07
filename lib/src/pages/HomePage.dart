import 'dart:io';
import 'package:facial_recognizer/src/REST/SearchByImageResponse.dart';
import 'package:facial_recognizer/src/models/ComparisonResult.dart';
import 'package:facial_recognizer/src/models/Person.dart';
import 'package:facial_recognizer/src/models/PersonInformationController.dart';
import 'package:facial_recognizer/src/REST/RESTCalls.dart' as rest;
import 'package:facial_recognizer/src/widgets/OperationButton.dart';
import 'package:facial_recognizer/utils/utils.dart' as utils;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Size _screenSize;
  String _message;

  @override
  Widget build(BuildContext context) {
    _screenSize = MediaQuery.of(context).size;
    _message = ModalRoute.of(context).settings.arguments;
    return Scaffold(appBar: utils.appBar(), body: _body());
  }

  ListView _body() {
    return ListView(children: <Widget>[
      SizedBox(
        height: _screenSize.height * 0.05,
      ),
      _showMessage(),
      SizedBox(
        height: _screenSize.height * 0.2,
      ),
      OperationButton(
        message: "Registrar",
        backgroundColor: Colors.indigo,
        function: _registerPersonFunction(),
        isMainButton: true,
      ),
      utils.verticalSeparator(),
      OperationButton(
          message: "Reconocer",
          backgroundColor: Colors.green,
          function: _recognizePersonFunction(),
          isMainButton: true)
    ]);
  }

  Function _registerPersonFunction() {
    return () {
      Navigator.pushNamed(context, "registration");
    };
  }

  Function _recognizePersonFunction() {
    return _getImage;
  }

  Future _getImage() async {
    File _image = await ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 100);
    if (_image != null) 
    {
      SearchByImage restResponse = await rest.searchByImageResponse(_image);
      
      if (restResponse.ok) 
      {
        Person person = Person(
          id: restResponse.person.id,
          name: restResponse.person.name,
          email: restResponse.person.email,
          hobby: restResponse.person.hobby,
          profession: restResponse.person.profession,
          imagePath: restResponse.person.imgName
        );
        Navigator.pushNamed(context, "information", arguments: PersonInformationController(person: person, comparisonResult: ComparisonResult(imagePath: _image.path, similarity: restResponse.data.faceMatches[0].similarity)));
      } else {
        setState(() {
          _message = restResponse.results;
        });
      }
    }
  }

  _showMessage() {
    if (_message == null) {
      return Container();
    } else {
      return Text(_message);
    }
  }
}
