import 'package:flutter/material.dart';

class OperationButton extends StatelessWidget {
  final String message;
  final Color backgroundColor;
  final Function function;
  final bool isMainButton;

  OperationButton({this.message, this.backgroundColor, this.function, this.isMainButton});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RaisedButton(
        child: Padding(
          padding: isMainButton ? EdgeInsets.all(14.0) : EdgeInsets.all(1.0),
          child: Text(
            message,
            style: isMainButton ? TextStyle(fontSize: 20.0) : TextStyle(fontSize: 15.0),
          ),
        ),
        onPressed: function,
        color: backgroundColor,
        shape: StadiumBorder(),
        textColor: Colors.white,
      ),
    );
  }
}
