import 'package:facial_recognizer/src/widgets/OperationButtonWidget.dart';
import 'package:facial_recognizer/utils/utils.dart' as utils;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RegisterPersonPage extends StatefulWidget {
  @override
  _RegisterPersonPageState createState() => _RegisterPersonPageState();
}

class _RegisterPersonPageState extends State<RegisterPersonPage> {
  Size _screenSize;
  TextEditingController _textEditingController;
  String _personName;

  @override
  Widget build(BuildContext context) {
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
      _personNameTextField(),
      utils.verticalSeparator(),
      _registerButton()
    ]);
  }

  OperationButton _registerButton() {
    return OperationButton(
        message: "Registrar",
        backgroundColor: Colors.orange,
        function: () {},
        isMainButton: true);
  }

  ClipRRect _imageBox() {
    return ClipRRect(
      child: Container(
        width: _screenSize.width * 0.6,
        height: _screenSize.height * 0.3,
        child: null ??
            Image(image: AssetImage("assets/noImage.png"), fit: BoxFit.fill),
      ),
      borderRadius: BorderRadius.circular(20.0),
    );
  }

  Wrap _selectPhotoFrom() {
    return Wrap(
      children: <Widget>[_selectPhotoFromGallery(), _selectPhotoFromCamera()],
      direction: Axis.horizontal,
      alignment: WrapAlignment.center,
      spacing: _screenSize.width * 0.1,
    );
  }

  FloatingActionButton _selectPhotoFromGallery() {
    return FloatingActionButton(
      child: Icon(Icons.camera_alt),
      backgroundColor: Colors.orange,
      onPressed: () {},
      heroTag: "photoFromGallery",
      
    );
  }

  FloatingActionButton _selectPhotoFromCamera() {
    return FloatingActionButton(
      child: Icon(Icons.insert_photo),
      backgroundColor: Colors.orange,
      onPressed: () {},
      heroTag: "photoFromCamera",
    );
  }

  Container _personNameTextField() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: TextFormField(
        controller: _textEditingController,
        maxLines: 1,
        inputFormatters: [LengthLimitingTextInputFormatter(50)],
        decoration: InputDecoration(
          labelText: "Nombre",
          helperText: "Nombre de persona de la imagen",
        ),
        maxLengthEnforced: true,
        onChanged: (value) {
          setState(() {
            _personName = value;
          });
        },
      ),
    );
  }
}
