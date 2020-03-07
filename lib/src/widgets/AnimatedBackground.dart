import 'package:facial_recognizer/src/models/AnimationColorController.dart';
import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';

class AnimatedBackground extends StatelessWidget {
  final AnimationColorController colorController;

  AnimatedBackground({@required this.colorController});

  @override
  Widget build(BuildContext context) {
    final tween = MultiTrackTween([
      Track("color1").add(Duration(seconds: 3),
          ColorTween(begin: colorController.color1Begin, end: colorController.color1End)),
      Track("color2").add(Duration(seconds: 3),
          ColorTween(begin: colorController.color2Begin, end: colorController.color2End))
    ]);

    return ControlledAnimation(
      playback: Playback.MIRROR,
      tween: tween,
      duration: tween.duration,
      builder: (context, animation) {
        return Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [animation["color1"], animation["color2"]])),
        );
      },
    );
  }
}