import 'package:flutter/material.dart';

class Button extends StatelessWidget {

  Button({@required this.title, @required this.onPressed});

  final String title;
  final GestureTapCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
        color: Colors.deepOrangeAccent,
        child: Text(title, style: TextStyle(color: Colors.white),),
        onPressed: onPressed);
  }
}