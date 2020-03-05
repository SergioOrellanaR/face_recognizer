import 'package:flutter/material.dart';

class StreamTextField extends StatelessWidget {
  final String labelText;
  final String labelHint;
  final IconData leadingIcon;
  final Stream stream;
  final Function onChangedFunction;

  StreamTextField(
      {this.labelText,
      this.labelHint,
      this.leadingIcon,
      this.stream,
      this.onChangedFunction});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: stream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
                icon: Icon(
                  leadingIcon,
                  color: Colors.deepPurple,
                ),
                hintText: labelHint,
                labelText: labelText,
                counterText: snapshot.data,
                errorText: snapshot.error),
            onChanged: onChangedFunction,
          ),
        );
      },
    );
  }
}
