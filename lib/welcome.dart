import 'package:donation_app/after_signup.dart';
import 'package:donation_app/anxiety%20questions/aques1.dart';
import 'package:donation_app/anxiety%20result.dart';
import 'package:donation_app/chat/home.dart';
import 'package:donation_app/depression%20questions/dques1.dart';
import 'package:donation_app/login_signup_page.dart';
import 'package:donation_app/video/index.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';

class Welcome extends StatefulWidget {
  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  String userid = "";
  String name = "Loading ...";

  DocumentReference documentReference;

  // final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  // void firebaseCloudMessagingListeners() {
  //   // _firebaseMessaging.getToken().then((token) {
  //   //   print(token);
  //   // });

  //   _firebaseMessaging.configure(
  //     onMessage: (Map<String, dynamic> message) {
  //       print('on message $message');
  //     },
  //     onResume: (Map<String, dynamic> message) {
  //       print('on resume $message');
  //     },
  //     onLaunch: (Map<String, dynamic> message) {
  //       print('on launch $message');
  //     },
  //   );
  // }

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
    // firebaseCloudMessagingListeners();
    // getName();
    Future.delayed(Duration(seconds: 2), () {
      _fetch();
    });
    // _fetch();
  }

  Future<void> _fetch() async {
    documentReference = Firestore.instance.collection('users').document(userid);
    documentReference.get().then((doc) {
      if (doc.exists) {
        setState(() {
          name = doc.data['name'];
        });
      } else {
        setState(() {
          name = "Loading";
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Screen"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AfterSignUp(),
                  ),
                ),
          ),
        ],
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 100,
                ),
                Text(
                  "Welcome ",
                  style: TextStyle(
                    fontSize: 30,
                  ),
                ),
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 30,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            // RaisedButton(
            //   child: Text("SignOut"),
            //   onPressed: () {
            //     FirebaseAuth.instance.signOut();
            //     Navigator.of(context).pushAndRemoveUntil(
            //         MaterialPageRoute(
            //           builder: (BuildContext context) => LoginSignUpPage(),
            //         ),
            //         (Route<dynamic> route) => false);
            //   },
            // ),
            // SizedBox(
            //   height: 30,
            // ),
            ButtonTheme(
              height: 80,
              minWidth: 250,
              buttonColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              child: RaisedButton(
                child: Text(
                  "Take Anxiety Test",
                  style: TextStyle(fontSize: 20),
                ),
                onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AQues1(),
                      ),
                    ),
              ),
            ),
            SizedBox(
              height: 60,
            ),
            ButtonTheme(
              height: 80,
              minWidth: 250,
              buttonColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              child: RaisedButton(
                child: Text(
                  "Take Depression Test",
                  style: TextStyle(fontSize: 20),
                ),
                onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DQues1(),
                      ),
                    ),
              ),
            ),
            SizedBox(
              height: 60,
            ),
            // RaisedButton(
            //   child: Text("Chat"),
            //   onPressed: () => Navigator.push(
            //         context,
            //         MaterialPageRoute(
            //           builder: (context) => HomePage(currentUserId: ""),
            //         ),
            //       ),
            // ),
            // RaisedButton(
            //   child: Text("Video"),
            //   onPressed: () => Navigator.push(
            //         context,
            //         MaterialPageRoute(
            //           builder: (context) => IndexPage(),
            //         ),
            //       ),
            // ),
            ButtonTheme(
              height: 80,
              minWidth: 250,
              buttonColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              child: RaisedButton(
                child: Text(
                  "Result",
                  style: TextStyle(fontSize: 20),
                ),
                onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AResult(userid: userid),
                      ),
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget getName(BuildContext context, DocumentSnapshot snapshot) {
  //   return snapshot['name'];
  // }

  // Future<Widget> getName() async {
  //   return StreamBuilder(
  //     stream:
  //         Firestore.instance.collection('users').document(userid).snapshots(),
  //     builder: (BuildContext context, AsyncSnapshot snapshot) {
  //       var document = snapshot.data;
  //     },
  //   );
  // }

  // Widget getName() {
  // return StreamBuilder(
  //   stream:
  //       Firestore.instance.collection('users').document(userid).snapshots(),
  //   builder: (BuildContext context, AsyncSnapshot snapshot) {
  //     var document = snapshot.data;
  //     if (snapshot.hasData) {
  //       return Text(document["name"]);
  //     }
  //     else {
  //       return Text("Loading");
  //     }
  //   },
  // );
  // }

  // Future<Widget> getName() async {
  //    return StreamBuilder(
  //      stream:
  //          Firestore.instance.collection('users').document(userid).snapshots(),
  //      builder: (context, snapshot) {
  //        if (snapshot.hasData) {
  //          DocumentSnapshot document = snapshot.data;
  //          return Text(document["name"]);
  //        }
  //        return Text("ABC");
  //      },
  //    );
  // }

  Future<String> getCurrentUser() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    return user.uid;
  }
}
