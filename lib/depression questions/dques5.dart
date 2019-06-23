import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donation_app/anxiety%20questions/aques2.dart';
import 'package:donation_app/depression%20questions/dques6.dart';
import 'package:donation_app/test.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DQues5 extends StatefulWidget {
  @override
  _DQues5State createState() => _DQues5State();
}

class _DQues5State extends State<DQues5> {
  SharedPreferences prefs;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  String ddispValue5 = '';

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
    ddispValue5 = prefs.getString('ddispValue5') ?? '';
  }

  void role(String e) {
    setState(() {
      if (e == "1") {
        ddispValue5 = "1";
      } else if (e == "2") {
        ddispValue5 = "2";
      } else if (e == "3") {
        ddispValue5 = "3";
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
              "Poor appetite or overeating?",
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
                      groupValue: ddispValue5,
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
                      groupValue: ddispValue5,
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
                      groupValue: ddispValue5,
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
      if (ddispValue5 != "") {
        if (ddispValue5 == "1") {
          Firestore.instance.collection('users').document(userid).updateData({
            "Dques5": "1",
          }).then((data) async {
            await prefs.setString("ddispValue5", ddispValue5);
          });
        } else if (ddispValue5 == "2") {
          Firestore.instance.collection('users').document(userid).updateData({
            "Dques5": "2",
          }).then((data) async {
            await prefs.setString("ddispValue5", ddispValue5);
          });
        } else if (ddispValue5 == "3") {
          Firestore.instance.collection('users').document(userid).updateData({
            "Dques5": "3",
          }).then((data) async {
            await prefs.setString("ddispValue5", ddispValue5);
          });
        }
        // Navigator.of(context).pop();
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => DQues6()));
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
