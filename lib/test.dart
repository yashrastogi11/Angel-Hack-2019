import 'package:donation_app/welcome.dart';
import 'package:flutter/material.dart';

class Test extends StatefulWidget {
  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text("Welcome"),
        RaisedButton(
          onPressed: () => Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Welcome())),
        ),
      ],
    );
  }
}