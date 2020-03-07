import 'dart:math';

import 'package:facial_recognizer/src/models/AnimationColorController.dart';
import 'package:facial_recognizer/src/widgets/AnimatedBackground.dart';
import 'package:facial_recognizer/src/widgets/AnimatedWave.dart';
import 'package:flutter/material.dart';

class FancyBackgroundApp extends StatelessWidget {

  final AnimationColorController colorController;
  final Widget containedWidget;
  final bool isRegister;

  FancyBackgroundApp({@required this.colorController, @required this.containedWidget, @required this.isRegister});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned.fill(child: AnimatedBackground(colorController: colorController)),
        
        waveAnimation(),
        Positioned.fill(child: containedWidget),
      ],
    );
  }

  onBottom(Widget child) => Positioned.fill(
        child: Align(
          alignment: Alignment.bottomCenter,
          child: child,
        ),
      );

  waveAnimation()
  {
    double height = isRegister ? 160: 130;
    double speed = isRegister ? 0.7 : 1.0;

    return onBottom(AnimatedWave(
          height: height,
          speed: speed,
        ));
  }
}

class CenteredText extends StatelessWidget {
  const CenteredText({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Text(
      "Hello!",
      style: TextStyle(color: Colors.white),
      textScaleFactor: 5,
    ));
  }
}
