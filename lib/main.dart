
import 'package:facial_recognizer/src/REST/RESTCalls.dart';
import 'package:facial_recognizer/src/pages/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:facial_recognizer/utils/routes.dart' as routes;

void main() async
{ 
  WidgetsFlutterBinding.ensureInitialized();
  // final restCalls = new RestCalls();
  // await restCalls.initCalls();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Facial Recognizer',
        home: HomePage(),
        routes: routes.routeMap(),
        debugShowCheckedModeBanner: false);
  }
}