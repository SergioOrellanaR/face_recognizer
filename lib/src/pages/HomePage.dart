import 'dart:io';
import 'package:facial_recognizer/src/widgets/SnackbarShowerOnInit.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:facial_recognizer/src/REST/SearchByImageResponse.dart';
import 'package:facial_recognizer/src/models/AnimationColorController.dart';
import 'package:facial_recognizer/src/models/ComparisonResult.dart';
import 'package:facial_recognizer/src/models/Person.dart';
import 'package:facial_recognizer/src/models/PersonInformationController.dart';
import 'package:facial_recognizer/src/REST/RESTCalls.dart' as rest;
import 'package:facial_recognizer/src/widgets/FancyBackground.dart';
import 'package:facial_recognizer/utils/utils.dart' as utils;

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
    // return Scaffold(body: _body());
    return Scaffold(body: Builder(
      builder: (BuildContext context) {
        return _body(context);
      },
    ));
  }

  Widget _body(context) {
    return Column(
      children: <Widget>[
        _halfScreenContainer(
            Icons.face, Colors.indigo, _registerPersonFunction(), true),
        _halfScreenContainer(Icons.search, Colors.black54,
            _recognizePersonFunction(context), false),
        snackOnInit()
      ],
    );
  }

  Widget snackOnInit() {
    if (_message != null) {
      String mes = _message;
      _message = null;
      return SnackbarShower(
        message: mes,
      );
    } else {
      return Container();
    }
  }

  Widget _halfScreenContainer(
      IconData iconData, Color color, Function function, bool isRegister) {
    IconButton button = IconButton(
      iconSize: _screenSize.height * 0.25,
      icon: Icon(iconData),
      color: color,
      enableFeedback: true,
      splashColor: Colors.blue,
      onPressed: function,
    );

    return Flexible(
      child: Container(
        height: _screenSize.height / 2,
        width: double.infinity,
        child: FancyBackgroundApp(
          containedWidget: button,
          colorController: _applyGradient(isRegister: isRegister),
          isRegister: isRegister,
        ),
      ),
    );
  }

  AnimationColorController _applyGradient({@required bool isRegister}) {
    if (isRegister) {
      return AnimationColorController.createPerson();
    } else {
      return AnimationColorController.recognize();
    }
  }

  Function _registerPersonFunction() {
    return () {
      Navigator.pushNamed(context, "registration");
    };
  }

  Function _recognizePersonFunction(context) {
    return () => _getImage(context);
  }

  Future _getImage(context) async {
    File _image = await ImagePicker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 100);
    if (_image != null) {
      _showSnackbar(context, "Realizando búsqueda de imagen...");
      SearchByImage restResponse = await rest.searchByImageResponse(_image);
      _hideCurrentSnackbar(context);
      if (restResponse.ok) {
        Person person = Person(
            id: restResponse.person.id,
            name: restResponse.person.name,
            email: restResponse.person.email,
            hobby: restResponse.person.hobby,
            profession: restResponse.person.profession,
            imagePath: restResponse.person.imgName);
        Navigator.pushNamed(context, "information",
            arguments: PersonInformationController(
                person: person,
                comparisonResult: ComparisonResult(
                    imagePath: _image.path,
                    similarity: restResponse.data.faceMatches[0].similarity)));
      } else {
        _showSnackbar(context, restResponse.results);
      }
    } else {
      _showSnackbar(context, "No se ha detectado imagen");
    }
  }

  _showSnackbar(context, String message) {
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(message),
      duration: Duration(seconds: 5),
    ));
  }

  _hideCurrentSnackbar(context) {
    Scaffold.of(context).hideCurrentSnackBar();
  }
}
