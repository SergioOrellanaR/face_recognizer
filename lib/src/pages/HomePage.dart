import 'package:facial_recognizer/src/widgets/OperationButtonWidget.dart';
import 'package:facial_recognizer/utils/utils.dart' as utils;
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
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
      //Agregar galeria de listView horizontal.
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
}
