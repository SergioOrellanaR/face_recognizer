import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class RegisterPersonController {
  List<CameraDescription> cameras;
  Image image;

  RegisterPersonController({@required this.cameras, this.image});
}