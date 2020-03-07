import 'package:flutter/material.dart';

class AnimationColorController {

  Color color1Begin;
  Color color1End;
  Color color2Begin;
  Color color2End;

  AnimationColorController({this.color1Begin, this.color1End, this.color2Begin, this.color2End});
  
  AnimationColorController.createPerson()
  {        
    color1Begin = Color.fromRGBO(76, 161, 175, 1.0);
    color1End = Color.fromRGBO(196, 224, 229, 0.8);
    color2Begin = Colors.green;
    color2End = Colors.blue;
  }

  AnimationColorController.recognize()
  {
    color1Begin = Color.fromRGBO(221, 221, 218, 0.8);
    color1End = Colors.indigo;
    color2Begin = Color.fromRGBO(74, 112, 122, 1.0);
    color2End = Colors.grey;
  }

  

  
  
}