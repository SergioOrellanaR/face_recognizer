import 'dart:async';
import 'package:facial_recognizer/src/blocs/Validators.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter/material.dart';

class PersonBloc with Validators{
  //Reemplaza streams
  final _imageController = BehaviorSubject<Image>();
  final _nameController = BehaviorSubject<String>();
  final _professionController = BehaviorSubject<String>();
  final _hobbyController = BehaviorSubject<String>();

  //Recuperar datos de stream
  Stream<Image> get imageStream => _imageController.stream.transform(validateImage);
  Stream<String> get nameStream => _nameController.stream;
  Stream<String> get professionStream => _professionController.stream;
  Stream<String> get hobbyStream => _hobbyController.stream;

  //Si existe dato en los 4 devuelve true, si es que no, devuelve null
  Stream<bool> get formValidStream => CombineLatestStream.combine4(
      _imageController,
      _nameController,
      _professionController,
      _hobbyController,
      (image, email, password, hobby) => true);

  //Insertar valores al stream
  Function(Image) get changeImage => _imageController.sink.add;
  Function(String) get changeName => _nameController.sink.add;
  Function(String) get changeProfession => _professionController.sink.add;
  Function(String) get changeHobby => _hobbyController.sink.add;

  //Obtener ultimo valor de los streams
  Image get getImage => _imageController.value;
  String get getName => _nameController.value;
  String get getProfession => _professionController.value;
  String get getHobby => _hobbyController.value;

  void dispose() {
    _imageController?.close();
    _nameController?.close();
    _professionController?.close();
    _hobbyController?.close();
  }
}
