import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donation_app/anxiety%20questions/aques2.dart';
import 'package:donation_app/depression%20questions/dques7.dart';
import 'package:donation_app/test.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DQues6 extends StatefulWidget {
  @override
  _DQues6State createState() => _DQues6State();
}

class _DQues6State extends State<DQues6> {
  SharedPreferences prefs;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  String ddispValue6 = '';

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
    ddispValue6 = prefs.getString('ddispValue6') ?? '';
  }

  void role(String e) {
    setState(() {
      if (e == "1") {
        ddispValue6 = "1";
      } else if (e == "2") {
        ddispValue6 = "2";
      } else if (e == "3") {
        ddispValue6 = "3";
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
              "Lack of self confidence?",
              style: TextStyle(
                fontSize: 30,
              ),
            ),
            left: 30,
            top: 180,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            // alignment: Alignment.left,
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 300,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Radio(
                      value: "1",
                      groupValue: ddispValue6,
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
                      groupValue: ddispValue6,
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
                      groupValue: ddispValue6,
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
      if (ddispValue6 != "") {
        if (ddispValue6 == "1") {
          Firestore.instance.collection('users').document(userid).updateData({
            "Dques6": "1",
          }).then((data) async {
            await prefs.setString("ddispValue6", ddispValue6);
          });
        } else if (ddispValue6 == "2") {
          Firestore.instance.collection('users').document(userid).updateData({
            "Dques6": "2",
          }).then((data) async {
            await prefs.setString("ddispValue6", ddispValue6);
          });
        } else if (ddispValue6 == "3") {
          Firestore.instance.collection('users').document(userid).updateData({
            "Dques6": "3",
          }).then((data) async {
            await prefs.setString("ddispValue6", ddispValue6);
          });
        }
        // Navigator.of(context).pop();
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => DQues7()));
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
