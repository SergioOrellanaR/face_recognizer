import 'dart:io';

import 'package:flutter/material.dart';

class ComparisonResult {
  String imagePath;

  ComparisonResult({this.imagePath});

  Image getImage() {
    return Image.file(File(imagePath), fit: BoxFit.fill);
  }
}
