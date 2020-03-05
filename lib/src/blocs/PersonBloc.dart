import 'dart:async';
import 'package:rxdart/rxdart.dart';

class PersonBloc {
  //Reemplaza streams
  final _nameController =    BehaviorSubject<String>();
  final _professionController = BehaviorSubject<String>();
  final _hobbyController = BehaviorSubject<String>();

  //Recuperar datos de stream
  Stream<String> get nameStream    => _nameController.stream;
  Stream<String> get professionStream => _professionController.stream;
  Stream<String> get hobbyStream => _hobbyController.stream;

  //Si existe dato en los 3 devuelve true, si es que no, devuelve null
  Stream<bool> get formValidStream => CombineLatestStream.combine3(_nameController, _professionController, _hobbyController, (email, password, hobby) => true);

  //Insertar valores al stream
  Function(String) get changeName    => _nameController.sink.add;
  Function(String) get changeProfession => _professionController.sink.add;
  Function(String) get changeHobby => _hobbyController.sink.add;

  //Obtener ultimo valor de los streams
  String get getName =>    _nameController.value;
  String get getProfession => _professionController.value;
  String get getHobby => _hobbyController.value;
  
  void dispose() { 
    _nameController?.close();
    _professionController?.close();
    _hobbyController?.close();
  }
}