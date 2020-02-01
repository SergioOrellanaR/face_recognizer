import 'package:camera/camera.dart';
import 'package:facial_recognizer/src/pages/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:facial_recognizer/utils/routes.dart' as routes;

void main() async
{ 
  WidgetsFlutterBinding.ensureInitialized();
  final cameras = await availableCameras();
  runApp(MyApp(cameras: cameras));
}

class MyApp extends StatelessWidget {
  final List<CameraDescription> cameras;
  MyApp({this.cameras});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Facial Recognizer',
        home: HomePage(cameras: cameras),
        routes: routes.routeMap(),
        debugShowCheckedModeBanner: false);
  }
}