import 'package:facial_recognizer/src/models/ComparisonResult.dart';
import 'package:facial_recognizer/src/models/Person.dart';
import 'package:facial_recognizer/src/models/PersonInformationController.dart';
import 'package:facial_recognizer/src/providers/DBProvider.dart';
import 'package:facial_recognizer/src/widgets/OperationButton.dart';
import 'package:flutter/material.dart';
import 'package:facial_recognizer/utils/utils.dart' as utils;

class PersonInformationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Size _screenSize = MediaQuery.of(context).size;
    PersonInformationController _pageController =
        ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: utils.appBar(),
      body: _body(context, _pageController, _screenSize),
    );
  }

  _body(BuildContext context, PersonInformationController pageController,
      Size screenSize) {
    return ListView(
      children: <Widget>[
        SizedBox(
          height: screenSize.height * 0.05,
        ),
        _imagesBox(pageController, screenSize),
        utils.verticalSeparator(),
        _personInformation(pageController.person),
        utils.verticalSeparator(),
        _comparisonResult(pageController.comparisonResult),
        utils.verticalSeparator(),
        _buttons(context, pageController)
      ],
    );
  }

  Column _subTitle(String value) {
    return Column(
      children: <Widget>[
        Divider(),
        Container(
          child: Text(
            value,
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
        ),
        Divider()
      ],
    );
  }

  Widget _imagesBox(
      PersonInformationController pageController, Size screenSize) {
    if (pageController.comparisonResult != null) {
      return Row(
        children: <Widget>[
          _loadImage(pageController.comparisonResult.getImage(), screenSize),
          _loadImage(pageController.person.getImage(), screenSize)
        ],
        mainAxisAlignment: MainAxisAlignment.spaceAround,
      );
    } else {
      return _loadImage(pageController.person.getImage(), screenSize);
    }
  }

  Align _loadImage(Image image, Size screenSize) {
    return Align(
      alignment: Alignment.center,
      child: ClipRRect(
          child: Container(
              width: screenSize.width * 0.4,
              height: screenSize.height * 0.3,
              child: image),
          borderRadius: BorderRadius.circular(20.0)),
    );
  }

  _personInformation(Person person) {
    return Column(
      children: <Widget>[
        _subTitle("Información de persona"),
        printData("Nombre", person.name),
        Divider(),
        printData("Profesión", person.profession),
        Divider(),
        printData("Hobby", person.hobby)
      ],
    );
  }

  _comparisonResult(ComparisonResult comparisonResult) {
    if (comparisonResult != null) {
      return Column(
        children: <Widget>[
          _subTitle("Datos de comparación"),
        ],
      );
    } else {
      return Container();
    }
  }

  Text printData(String key, String value) {
    TextStyle style = TextStyle();
    return Text(
      "$key : $value",
      style: style,
    );
  }

  _buttons(BuildContext context, PersonInformationController controller) {
    return Column(
      children: <Widget>[
        _deleteButton(context, controller),
        utils.verticalSeparator(),
        _backButton(context)
      ],
    );
  }

  _deleteButton(BuildContext context, PersonInformationController controller) {
    if (controller.comparisonResult != null) {
      return Container();
    } else {
      return OperationButton(
          message: "Borrar",
          backgroundColor: Colors.red,
          function: () {
            DBProvider.connection.deletePerson(controller.person.id);
            Navigator.pushReplacementNamed(context, "home");
          },
          isMainButton: true);
    }
  }

  _backButton(BuildContext context) {
    return OperationButton(
        message: "Volver",
        backgroundColor: Colors.indigo,
        function: () {
          Navigator.pushReplacementNamed(context, "home");
        },
        isMainButton: true);
  }
}
