import 'package:donation_app/chat/home.dart';
import 'package:donation_app/test.dart';
import 'package:donation_app/video/index.dart';
import 'package:flutter/material.dart';

class AfterResults extends StatefulWidget {
  AfterResults({Key key, @required this.sum, @required this.sum1})
      : super(key: key);
  final int sum;
  final int sum1;
  @override
  _AfterResultsState createState() => _AfterResultsState();
}

class _AfterResultsState extends State<AfterResults> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            _routine(),
            _chat(),
            _video(),
          ],
        ),
      ),
    );
  }

  Widget _routine() {
    return Column(
      children: <Widget>[
        Text(
          "To get daily updates click here\n",
          style: TextStyle(fontSize: 20),
        ),
        ButtonTheme(
          height: 70,
          minWidth: 200,
          buttonColor: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: RaisedButton(
            child: Text(
              "Routine",
              style: TextStyle(
                fontSize: 20,
                color: Colors.indigo,
                fontWeight: FontWeight.bold,
              ),
            ),
            onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Test(),
                  ),
                ),
          ),
        ),
      ],
    );
  }

  Widget _chat() {
    if (widget.sum <= 11 && widget.sum1 <= 11) {
      return Container(
        height: 0,
        width: 0,
      );
    } else {
      return Column(
        children: <Widget>[
          Text(
            "To join the group chat or to talk to \nthe psychiatrist click here\n",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20),
          ),
          ButtonTheme(
            height: 70,
            minWidth: 200,
            buttonColor: Colors.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: RaisedButton(
              child: Text("Chat",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.indigo,
                    fontWeight: FontWeight.bold,
                  )),
              onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomePage(currentUserId: ""),
                    ),
                  ),
            ),
          ),
        ],
      );
    }
  }

  Widget _video() {
    if (widget.sum <= 11 && widget.sum1 <= 11) {
      return Container(
        height: 0,
        width: 0,
      );
    } else {
      return Column(
        children: <Widget>[
          Text(
            "To video call with an expert \npsychiatrist click here\n",
            style: TextStyle(fontSize: 20),
            textAlign: TextAlign.center,
          ),
          ButtonTheme(
            height: 70,
            minWidth: 200,
            buttonColor: Colors.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: RaisedButton(
              child: Text("Video",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.indigo,
                    fontWeight: FontWeight.bold,
                  )),
              onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => IndexPage(),
                    ),
                  ),
            ),
          ),
        ],
      );
    }
  }
}
