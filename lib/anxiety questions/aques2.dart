import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donation_app/anxiety%20questions/aques3.dart';
import 'package:donation_app/test.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AQues2 extends StatefulWidget {
  @override
  _AQues2State createState() => _AQues2State();
}

class _AQues2State extends State<AQues2> {
  SharedPreferences prefs;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  String adispValue2 = '';

  String _errorMessage = "";

  String userid = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentUser().then((user) {
      setState(() {
        if (user != null) {
          userid = user;
        }
      });
    });
    readLocal();
  }

  void readLocal() async {
    prefs = await SharedPreferences.getInstance();
    adispValue2 = prefs.getString('adispValue2') ?? '';
  }

  void role(String e) {
    setState(() {
      if (e == "1") {
        adispValue2 = "1";
      } else if (e == "2") {
        adispValue2 = "2";
      } else if (e == "3") {
        adispValue2 = "3";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        overflow: Overflow.visible,
        children: <Widget>[
          Positioned(
            child: Text(
              "Not being able to stop \nor control worrying?",
              style: TextStyle(
                fontSize: 30,
              ),
            ),
            left: 30,
            top: 180,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 300,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Radio(
                      value: "1",
                      groupValue: adispValue2,
                      onChanged: (String e) => role(e),
                    ),
                    Text(
                      "1",
                      style: TextStyle(fontSize: 25),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Radio(
                      value: "2",
                      groupValue: adispValue2,
                      onChanged: (String e) => role(e),
                    ),
                    Text(
                      "2",
                      style: TextStyle(fontSize: 25),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Radio(
                      value: "3",
                      groupValue: adispValue2,
                      onChanged: (String e) => role(e),
                    ),
                    Text(
                      "3",
                      style: TextStyle(fontSize: 25),
                    ),
                  ],
                ),
                _showButton(),
                _showErrorMessage(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _showButton() {
    return new Padding(
        padding: EdgeInsets.fromLTRB(0.0, 50.0, 0.0, 10.0),
        child: SizedBox(
          height: 60.0,
          child: RaisedButton(
            elevation: 5.0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            color: Colors.indigo,
            child: Text(
              "Next",
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
            onPressed: () {
              _submit();
            },
          ),
        ));
  }

  _submit() async {
    try {
      if (adispValue2 != "") {
        if (adispValue2 == "1") {
          Firestore.instance.collection('users').document(userid).updateData({
            "Aques2": "1",
          }).then((data) async {
            await prefs.setString("adispValue2", adispValue2);
          });
        } else if (adispValue2 == "2") {
          Firestore.instance.collection('users').document(userid).updateData({
            "Aques2": "2",
          }).then((data) async {
            await prefs.setString("adispValue2", adispValue2);
          });
        } else if (adispValue2 == "3") {
          Firestore.instance.collection('users').document(userid).updateData({
            "Aques2": "3",
          }).then((data) async {
            await prefs.setString("adispValue2", adispValue2);
          });
        }
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => AQues3()));
      } else {
        setState(() {
          _errorMessage = "Please select one of the above options";
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
      });
    }
  }

  Widget _showErrorMessage() {
    if (_errorMessage.length > 0 && _errorMessage != null) {
      return new Text(
        _errorMessage,
        style: TextStyle(
          fontSize: 14.0,
          color: Colors.red,
          height: 1.0,
          fontWeight: FontWeight.w400,
        ),
      );
    } else {
      return new Container(
        height: 20.0,
      );
    }
  }

  Future<String> getCurrentUser() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    return user.uid;
  }
}
