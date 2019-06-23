import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'dart:io';
import 'package:fluttertoast/fluttertoast.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  TextEditingController controllerNickname;
  TextEditingController controllerAboutMe;

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  SharedPreferences prefs;

  String id = '';
  String nickname = '';
  String aboutMe = '';
  String photoUrl = '';

  String userid = "";

  bool isLoading = false;
  File avatarImageFile;

  final FocusNode focusNodeNickname = new FocusNode();
  final FocusNode focusNodeAboutMe = new FocusNode();

  @override
  void initState() {
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
    //  id = prefs.getString('id') ?? '';
    nickname = prefs.getString('nickname') ?? '';
    aboutMe = prefs.getString('aboutMe') ?? '';

    controllerNickname = new TextEditingController(text: nickname);
    controllerAboutMe = new TextEditingController(text: aboutMe);

    // Force refresh input
    setState(() {});
  }

  Future<String> getCurrentUser() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    return user.uid;
  }

  void handleUpdateData() {
    focusNodeNickname.unfocus();
    focusNodeAboutMe.unfocus();

    setState(() {
      isLoading = true;
    });

    Firestore.instance.collection('users').document(userid).updateData({
      'nickname': nickname,
      'aboutMe': aboutMe,
    }).then((data) async {
      await prefs.setString('aboutMe', aboutMe);
      await prefs.setString('nickname', nickname);
      setState(() {
        isLoading = false;
      });

      Fluttertoast.showToast(msg: "Update success");
    }).catchError((err) {
      setState(() {
        isLoading = false;
      });

      Fluttertoast.showToast(msg: err.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
      ),
      body: Stack(
        children: <Widget>[
          SingleChildScrollView(
            child: Column(
              children: <Widget>[

                // Input
                Column(
                  children: <Widget>[
                    // Username
                    Container(
                      child: Text(
                        'Nickname',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.teal,
                          fontSize: 18,
                        ),
                      ),
                      margin: EdgeInsets.only(
                        left: 10.0,
                        bottom: 10.0,
                        top: 10.0,
                      ),
                    ),
                    Container(
                      child: Theme(
                        data: Theme.of(context).copyWith(
                          primaryColor: Colors.teal,
                        ),
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: nickname,
                            contentPadding: EdgeInsets.all(5.0),
                            hintStyle: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                          controller: controllerNickname,
                          onChanged: (value) {
                            nickname = value;
                          },
                          focusNode: focusNodeNickname,
                        ),
                      ),
                      margin: EdgeInsets.only(
                        left: 20.0,
                        right: 20.0,
                      ),
                    ),

                    // About me
                    Container(
                      child: Text(
                        'About me',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.teal,
                          fontSize: 18,
                        ),
                      ),
                      margin: EdgeInsets.only(
                        left: 10.0,
                        top: 30.0,
                        bottom: 10.0,
                      ),
                    ),
                    Container(
                      child: Theme(
                        data: Theme.of(context).copyWith(
                          primaryColor: Colors.teal,
                        ),
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: aboutMe,
                            contentPadding: EdgeInsets.all(5.0),
                            hintStyle: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                          controller: controllerAboutMe,
                          onChanged: (value) {
                            aboutMe = value;
                          },
                          focusNode: focusNodeAboutMe,
                        ),
                      ),
                      margin: EdgeInsets.only(
                        left: 20.0,
                        right: 20.0,
                      ),
                    ),
                  ],
                  crossAxisAlignment: CrossAxisAlignment.start,
                ),

                // Button
                Container(
                  child: FlatButton(
                    onPressed: handleUpdateData,
                    child: Text(
                      'UPDATE',
                      style: TextStyle(fontSize: 16.0),
                    ),
                    color: Colors.teal,
                    highlightColor: new Color(0xff8d93a0),
                    splashColor: Colors.transparent,
                    textColor: Colors.white,
                    padding: EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 10.0),
                  ),
                  margin: EdgeInsets.only(top: 50.0, bottom: 50.0),
                ),
              ],
            ),
            padding: EdgeInsets.only(left: 15.0, right: 15.0),
          ),

          // Loading
          Positioned(
            child: isLoading
                ? Container(
                    child: Center(
                      child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                        Colors.red,
                      )),
                    ),
                    color: Colors.white.withOpacity(0.8),
                  )
                : Container(),
          ),
        ],
      ),
    );
  }
}
