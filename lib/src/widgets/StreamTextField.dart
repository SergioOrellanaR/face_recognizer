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
          width: double.infinity,
          child: TextField(
            keyboardType: TextInputType.text,
            cursorColor: Colors.black87,
            decoration: InputDecoration(
                icon: Icon(
                  leadingIcon,
                  color: Colors.black87,
                ),
                hintText: labelHint,
                labelText: labelText,
                focusColor: Colors.black87,
                hoverColor: Colors.black87,
                fillColor: Colors.black87,
                labelStyle: new TextStyle(color: const Color(0xFF424242)),
                border: new UnderlineInputBorder(
                    borderSide: new BorderSide(color: Colors.red)),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black87),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black87),
                ),
                counterText: snapshot.data,
                errorText: snapshot.error),
            onChanged: onChangedFunction,
          ),
        );
      },
    );
  }
}
