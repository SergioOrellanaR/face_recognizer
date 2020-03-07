import 'dart:io';

import 'package:flutter/material.dart';

class ComparisonResult {
  String imagePath;
  double similarity;

  ComparisonResult({this.imagePath, this.similarity});

  Image getImage() {
    return Image.file(File(imagePath), fit: BoxFit.fill);
  }
}
