import 'dart:async';
import 'package:flutter/material.dart';

class Validators {
  
  final validateEmail =
      StreamTransformer<String, String>.fromHandlers(handleData: (email, sink) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp emailRegex = new RegExp(pattern);

    if (!emailRegex.hasMatch(email)) {
      sink.addError("Email inválido");
    } else {
      sink.add(email);
    }
  });

  final validateImage =
      StreamTransformer<Image, Image>.fromHandlers(handleData: (image, sink) {
    //TODO: Realizar validación de si es o no un rostro.

    if (false) {
      sink.addError("La imágen debe ser de un rostro");
    } else {
      sink.add(image);
    }
  });
}
