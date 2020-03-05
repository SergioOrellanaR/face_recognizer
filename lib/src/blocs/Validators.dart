import 'dart:async';
import 'package:flutter/material.dart';

class Validators {

  final validateImage = StreamTransformer<Image, Image>.fromHandlers(
    handleData: (image, sink)
    {
      //TODO: Realizar validación de si es o no un rostro.

      if (false)
      {
        sink.addError("La imágen debe ser de un rostro");
      }
      else
      {
        sink.add(image);
      }
    }
  );
  
}