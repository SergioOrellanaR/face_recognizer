import 'package:facial_recognizer/src/REST/EmotionResponse.dart';
import 'package:facial_recognizer/src/REST/RESTCalls.dart' as rest;
import 'package:facial_recognizer/src/REST/RegisterResponse.dart';
import 'package:facial_recognizer/src/blocs/PersonBloc.dart';
import 'package:facial_recognizer/src/models/Person.dart';
import 'package:facial_recognizer/src/widgets/StreamTextField.dart';
import 'package:flutter/material.dart';
import 'dart:io' as io;
import 'package:image_picker/image_picker.dart';
import 'package:facial_recognizer/src/widgets/OperationButton.dart';
import 'package:facial_recognizer/utils/utils.dart' as utils;

class RegisterPersonPage extends StatefulWidget {
  @override
  _RegisterPersonPageState createState() => _RegisterPersonPageState();
}

class _RegisterPersonPageState extends State<RegisterPersonPage> {
  Size _screenSize;
  PersonBloc _person = new PersonBloc();
  String _imagePath;
  String _message = "";

  @override
  Widget build(BuildContext context) {
    _screenSize = MediaQuery.of(context).size;

    return Scaffold(
        appBar: utils.appBar(),
        body: Builder(
          builder: (BuildContext context) {
            return GestureDetector(
              onTap: (){
                
              },
              onPanDown: (_){
                FocusScope.of(context).requestFocus(new FocusNode());
              },
              
              child: Stack(
                children: <Widget>[
                  _background(),
                  _body(context),
                ],
              ),
            );
          },
        ));
  }

  ListView _body(context) {
    return ListView(
        reverse: true,
        children: <Widget>[
          SizedBox(
            height: _screenSize.height * 0.05,
          ),
          Align(
            child: _imageStream(),
            alignment: Alignment.center,
          ),
          utils.verticalSeparator(),
          _selectPhotoFrom(),
          utils.verticalSeparator(),
          _showMessage(),
          utils.verticalSeparator(),
          _personInformation(),
          utils.verticalSeparator(),
          _registerButton(context)
        ].reversed.toList());
  }

  Wrap _personInformation() {
    return Wrap(
      children: <Widget>[
        _nameTextField(),
        utils.verticalSeparator(),
        _emailTextField(),
        utils.verticalSeparator(),
        _professionTextField(),
        utils.verticalSeparator(),
        _hobbyTextField()
      ],
    );
  }

  _registerButton(context) {
    return StreamBuilder(
      stream: _person.formValidStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return OperationButton(
            message: "Registrar",
            backgroundColor: Colors.indigo,
            function: snapshot.hasData
                ? () async {
                    Person person = Person(
                        name: _person.getName,
                        profession: _person.getProfession,
                        email: _person.getEmail,
                        hobby: _person.getHobby,
                        imagePath: _imagePath);

                    _showSnackbar(context, "Procesando datos");
                    RegisterResponse registerResponse =
                        await rest.registerResponse(_imagePath, person);
                    _hideCurrentSnackbar(context);
                    if (registerResponse.ok) {
                      Navigator.pushReplacementNamed(context, "home",
                          arguments:
                              '${person.name} ha sido registrado correctamente');
                    } else {
                      setState(() {
                        _message =
                            "Ha ocurrido un error al realizar el registro: ${registerResponse.message}";
                      });
                      _showSnackbar(context, "Error!");
                    }
                  }
                : null,
            isMainButton: true);
      },
    );
  }

  Wrap _selectPhotoFrom() {
    return Wrap(
      children: <Widget>[_selectPhotoFromCamera(), _selectPhotoFromGallery()],
      direction: Axis.horizontal,
      alignment: WrapAlignment.center,
      spacing: _screenSize.width * 0.1,
    );
  }

  FloatingActionButton _selectPhotoFromGallery() {
    return FloatingActionButton(
        child: Icon(Icons.insert_photo),
        backgroundColor: Colors.indigo,
        onPressed: () async {
          await _getImage(source: ImageSource.gallery);
        },
        heroTag: "photoFromGallery");
  }

  FloatingActionButton _selectPhotoFromCamera() {
    return FloatingActionButton(
      backgroundColor: Colors.indigo,
      foregroundColor: Colors.white,
      child: Icon(Icons.camera_alt),
      onPressed: () async {
        await _getImage(source: ImageSource.camera);
      },
    );
  }

  Widget _imageStream() {
    return StreamBuilder(
      stream: _person.imageStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return ClipRRect(
          child: Container(
            width: _screenSize.width * 0.6,
            height: _screenSize.height * 0.3,
            child: snapshot.data ??
                Image(
                    image: AssetImage("assets/noImage.png"), fit: BoxFit.fill),
          ),
          borderRadius: BorderRadius.circular(20.0),
        );
      },
    );
  }

  StreamTextField _nameTextField() {
    return StreamTextField(
        labelText: "Nombre",
        labelHint: "Nombre de la persona",
        leadingIcon: Icons.person,
        stream: _person.nameStream,
        onChangedFunction: _person.changeName);
  }

  StreamTextField _emailTextField() {
    return StreamTextField(
        labelText: "Email",
        labelHint: "Email de la persona",
        leadingIcon: Icons.mail_outline,
        stream: _person.emailStream,
        onChangedFunction: _person.changeEmail);
  }

  StreamTextField _professionTextField() {
    return StreamTextField(
        labelText: "Profesión",
        labelHint: "Profesión de la persona",
        leadingIcon: Icons.work,
        stream: _person.professionStream,
        onChangedFunction: _person.changeProfession);
  }

  StreamTextField _hobbyTextField() {
    return StreamTextField(
        labelText: "Hobby",
        labelHint: "Hobby favorito de la persona",
        leadingIcon: Icons.star,
        stream: _person.hobbyStream,
        onChangedFunction: _person.changeHobby);
  }

  Text _showMessage() {
    return Text(
      _message,
      textAlign: TextAlign.center,
    );
  }

  Future _getImage({@required ImageSource source}) async {
    io.File _image =
        await ImagePicker.pickImage(source: source, imageQuality: 100);
    if (_image != null) {
      EmotionResponse restResponse = await rest.emotionResponse(_image);
      if (restResponse.ok) {
        _person.changeImage(Image.file(_image));
        _imagePath = _image.path;
        setState(() {
          _message = "En la imagen pareces ${restResponse.emocion}";
        });
      } else {
        setState(() {
          _message = restResponse.message;
        });
      }
    }
  }

  _background() {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
        Color.fromRGBO(55, 59, 68, 0.6),
        Color.fromRGBO(21, 101, 192, 0.3)
      ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
    );
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
