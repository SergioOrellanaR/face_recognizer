import 'package:facial_recognizer/src/models/ComparisonResult.dart';
import 'package:facial_recognizer/src/models/Person.dart';
import 'package:flutter/material.dart';

class PersonInformationController {
  Person person;
  ComparisonResult comparisonResult;

  PersonInformationController({@required this.person, this.comparisonResult});
}