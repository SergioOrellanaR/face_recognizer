import 'package:flutter/material.dart';

class SnackbarShower extends StatefulWidget {
  final String message;

  SnackbarShower({this.message});
  @override
  State createState() => new SnackbarShowerState();
}

class SnackbarShowerState extends State<SnackbarShower> {

  
  
  @override
  void initState() {
    new Future<Null>.delayed(Duration.zero, () {
      Scaffold.of(context).showSnackBar(
        new SnackBar(content: new Text(widget.message)),
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Container();
  }
}