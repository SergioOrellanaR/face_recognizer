import 'package:facial_recognizer/src/pages/HomePage.dart';
import 'package:facial_recognizer/src/pages/PersonInformationPage.dart';
import 'package:facial_recognizer/src/pages/RegisterPersonPage.dart';
import 'package:flutter/material.dart';

Map<String, WidgetBuilder> routeMap() {
   return <String, WidgetBuilder>{
   "home"   : (BuildContext context) => HomePage(),
   "registration"   : (BuildContext context) => RegisterPersonPage(),
   "information" : (BuildContext context) => PersonInformationPage(),
   };
}