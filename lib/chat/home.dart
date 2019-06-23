import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donation_app/chat/chat.dart';
import 'package:donation_app/chat/settings.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  final String currentUserId;
  HomePage({Key key, @required this.currentUserId}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState(currentUserId: currentUserId);
}

class _HomePageState extends State<HomePage> {
  _HomePageState({Key key, @required this.currentUserId});

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  final String currentUserId;

  bool isLoading = false;

  String userid = "";

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
  }

  Future<String> getCurrentUser() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    return user.uid;
  }

  Widget buildItem(BuildContext context, DocumentSnapshot document) {
    if (document['uid'] == userid) {
      return Container();
    } else {
      return Container(
        child: FlatButton(
          child: Row(
            children: <Widget>[
              Flexible(
                child: Container(
                  child: Column(
                    children: <Widget>[
                      Container(
                        child: Text(
                          'Nickname: ${document['nickname']}',
                          style: TextStyle(color: Colors.grey),
                        ),
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 5.0),
                      ),
                      Container(
                        child: Text(
                          'About me: ${document['aboutMe'] ?? 'Not available'}',
                          style: TextStyle(color: Colors.grey),
                        ),
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
                      )
                    ],
                  ),
                  margin: EdgeInsets.only(left: 20.0),
                ),
              ),
            ],
          ),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Chat(
                          peerName: document['nickname'],
                          peerId: document.documentID,
                        )));
          },
          color: Colors.grey[800],
          padding: EdgeInsets.fromLTRB(25.0, 10.0, 25.0, 10.0),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        ),
        margin: EdgeInsets.only(bottom: 10.0, left: 5.0, right: 5.0),
      );
    }
  }

  // Future<bool> onBackPress() {
  //   openDialog();
  //   return Future.value(false);
  // }

  // Future<Null> openDialog() async {
  //   switch (await showDialog(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return SimpleDialog(
  //           contentPadding:
  //               EdgeInsets.only(left: 0.0, right: 0.0, top: 0.0, bottom: 0.0),
  //           children: <Widget>[
  //             Container(
  //               color: Colors.teal,
  //               margin: EdgeInsets.all(0.0),
  //               padding: EdgeInsets.only(bottom: 10.0, top: 10.0),
  //               height: 100.0,
  //               child: Column(
  //                 children: <Widget>[
  //                   Container(
  //                     child: Icon(
  //                       Icons.exit_to_app,
  //                       size: 30.0,
  //                       color: Colors.white,
  //                     ),
  //                     margin: EdgeInsets.only(bottom: 10.0),
  //                   ),
  //                   Text(
  //                     'Exit app',
  //                     style: TextStyle(
  //                         color: Colors.white,
  //                         fontSize: 18.0,
  //                         fontWeight: FontWeight.bold),
  //                   ),
  //                   Text(
  //                     'Are you sure to exit app?',
  //                     style: TextStyle(color: Colors.white70, fontSize: 14.0),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //             SimpleDialogOption(
  //               onPressed: () {
  //                 Navigator.pop(context, 0);
  //               },
  //               child: Row(
  //                 children: <Widget>[
  //                   Container(
  //                     child: Icon(Icons.cancel, color: Colors.teal),
  //                     margin: EdgeInsets.only(right: 10.0),
  //                   ),
  //                   Text(
  //                     'CANCEL',
  //                     style: TextStyle(
  //                         color: Colors.grey, fontWeight: FontWeight.bold),
  //                   )
  //                 ],
  //               ),
  //             ),
  //             SimpleDialogOption(
  //               onPressed: () {
  //                 Navigator.pop(context, 1);
  //               },
  //               child: Row(
  //                 children: <Widget>[
  //                   Container(
  //                     child: Icon(
  //                       Icons.check_circle,
  //                       color: Colors.teal,
  //                     ),
  //                     margin: EdgeInsets.only(right: 10.0),
  //                   ),
  //                   Text(
  //                     'YES',
  //                     style: TextStyle(
  //                         color: Colors.grey, fontWeight: FontWeight.bold),
  //                   )
  //                 ],
  //               ),
  //             ),
  //           ],
  //         );
  //       })) {
  //     case 0:
  //       break;
  //     case 1:
  //       exit(0);
  //       break;
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.settings,
            ),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Settings()));
            },
          ),
        ],
        elevation: 2,
        title: Text(
          "Chat",
          textAlign: TextAlign.center,
        ),
      ),
      body: Stack(
        children: <Widget>[
          Container(
            child: StreamBuilder(
              stream: Firestore.instance.collection('users').snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.teal),
                    ),
                  );
                } else {
                  return ListView.builder(
                    padding: EdgeInsets.all(10.0),
                    itemBuilder: (context, index) =>
                        buildItem(context, snapshot.data.documents[index]),
                    itemCount: snapshot.data.documents.length,
                  );
                }
              },
            ),
          ),
          Positioned(
            child: isLoading
                ? Container(
                    child: Center(
                      child: CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.teal)),
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
