import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donation_app/anxiety%20questions/aques5.dart';
import 'package:donation_app/test.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AQues4 extends StatefulWidget {
  @override
  _AQues4State createState() => _AQues4State();
}

class _AQues4State extends State<AQues4> {
  SharedPreferences prefs;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  String adispValue4 = '';

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
    adispValue4 = prefs.getString('adispValue4') ?? '';
  }

  void role(String e) {
    setState(() {
      if (e == "1") {
        adispValue4 = "1";
      } else if (e == "2") {
        adispValue4 = "2";
      } else if (e == "3") {
        adispValue4 = "3";
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
              "Do you have trouble \nrelaxing?",
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
                      groupValue: adispValue4,
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
                      groupValue: adispValue4,
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
                      groupValue: adispValue4,
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
      if (adispValue4 != "") {
        if (adispValue4 == "1") {
          Firestore.instance.collection('users').document(userid).updateData({
            "Aques4": "1",
          }).then((data) async {
            await prefs.setString("adispValue4", adispValue4);
          });
        } else if (adispValue4 == "2") {
          Firestore.instance.collection('users').document(userid).updateData({
            "Aques4": "2",
          }).then((data) async {
            await prefs.setString("adispValue4", adispValue4);
          });
        } else if (adispValue4 == "3") {
          Firestore.instance.collection('users').document(userid).updateData({
            "Aques4": "3",
          }).then((data) async {
            await prefs.setString("adispValue4", adispValue4);
          });
        }
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => AQues5()));
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
