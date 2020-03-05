import 'package:camera/camera.dart';
import 'package:facial_recognizer/src/blocs/PersonBloc.dart';
import 'package:facial_recognizer/src/widgets/StreamTextField.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:facial_recognizer/src/models/RegisterPersonController.dart';
import 'package:facial_recognizer/src/widgets/OperationButtonWidget.dart';
import 'package:facial_recognizer/utils/utils.dart' as utils;

class RegisterPersonPage extends StatefulWidget {
  @override
  _RegisterPersonPageState createState() => _RegisterPersonPageState();
}

class _RegisterPersonPageState extends State<RegisterPersonPage> {
  Size _screenSize;
  TextEditingController _textEditingController;
  PersonBloc _person = new PersonBloc();
  RegisterPersonController _controller;

  @override
  Widget build(BuildContext context) {
    _controller = ModalRoute.of(context).settings.arguments;
    _screenSize = MediaQuery.of(context).size;
    return Scaffold(appBar: utils.appBar(), body: _body());
  }

  ListView _body() {
    return ListView(children: <Widget>[
      SizedBox(
        height: _screenSize.height * 0.05,
      ),
      Align(
        child: _imageBox(),
        alignment: Alignment.center,
      ),
      utils.verticalSeparator(),
      _selectPhotoFrom(),
      utils.verticalSeparator(),
      _personInformation(),
      utils.verticalSeparator(),
      _registerButton()
    ]);
  }

  Wrap _personInformation() {
    return Wrap(
      children: <Widget>[
        _nameTextField(),
        utils.verticalSeparator(),
        _professionTextField(),
        utils.verticalSeparator(),
        _hobbyTextField()
      ],
    );
  }

  _registerButton() {
    return StreamBuilder(
      stream: _person.formValidStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return OperationButton(
        message: "Registrar",
        backgroundColor: Colors.indigo,
        function: snapshot.hasData ? () => {} : null,
        isMainButton: true);
      },
    );
  }

  ClipRRect _imageBox() {
    return ClipRRect(
      child: Container(
        width: _screenSize.width * 0.6,
        height: _screenSize.height * 0.3,
        child: _controller.image ??
            Image(image: AssetImage("assets/noImage.png"), fit: BoxFit.fill),
      ),
      borderRadius: BorderRadius.circular(20.0),
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

  Widget _selectPhotoFromCamera() {
    if (_controller.cameras.isNotEmpty) {
      return FloatingActionButton(
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        child: Icon(Icons.camera_alt),
        onPressed: () async {
          await _getImage(source: ImageSource.camera);
        },
      );
    } else {
      return Text("Usted necesita una cámara para poder usar este programa");
    }
  }

  StreamTextField _nameTextField() {
    return StreamTextField(
        labelText: "Nombre",
        labelHint: "Nombre de la persona",
        leadingIcon: Icons.person,
        stream: _person.nameStream,
        onChangedFunction: _person.changeName);
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

  Container _personTextField(
      {String labelText, String helperText, String property}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: TextFormField(
        controller: _textEditingController,
        maxLines: 1,
        inputFormatters: [LengthLimitingTextInputFormatter(50)],
        decoration: InputDecoration(
          labelText: labelText,
          helperText: helperText,
        ),
        maxLengthEnforced: true,
        onChanged: (value) {
          setState(() {
            property = value;
          });
        },
      ),
    );
  }

  Future _getImage({@required ImageSource source}) async {
    var _image = await ImagePicker.pickImage(source: source, imageQuality: 100);
    if (_image != null) {
      setState(() {
        _controller.image = Image.file(_image);
      });
    }
  }
}
