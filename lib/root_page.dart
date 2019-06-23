import 'package:donation_app/authentication.dart';
import 'package:donation_app/login_signup_page.dart';
import 'package:donation_app/welcome.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';

class RootPage extends StatefulWidget {
  RootPage({this.auth});

  final BaseAuth auth;

  @override
  State<StatefulWidget> createState() => new _RootPageState();
}

enum AuthStatus {
  NOT_DETERMINED,
  NOT_LOGGED_IN,
  LOGGED_IN,
}

class _RootPageState extends State<RootPage> {
  AuthStatus authStatus = AuthStatus.NOT_DETERMINED;
  String _userId = "";

  // final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  @override
  void initState() {
    super.initState();
    // firebaseCloudMessagingListeners();
    widget.auth.getCurrentUser().then((user) {
      setState(() {
        if (user != null) {
          _userId = user?.uid;
        }
        authStatus =
            user?.uid == null ? AuthStatus.NOT_LOGGED_IN : AuthStatus.LOGGED_IN;
      });
    });
  }

  // void firebaseCloudMessagingListeners() {
  //   _firebaseMessaging.getToken().then((token) {
  //     print(token);
  //   });

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

  void _onLoggedIn() {
    widget.auth.getCurrentUser().then((user) {
      setState(() {
        _userId = user.uid.toString();
      });
    });
    setState(() {
      authStatus = AuthStatus.LOGGED_IN;
    });
  }

  void _onSignedOut() {
    setState(() {
      authStatus = AuthStatus.NOT_LOGGED_IN;
      _userId = "";
    });
  }

  Widget _buildWaitingScreen() {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: CircularProgressIndicator(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    switch (authStatus) {
      case AuthStatus.NOT_DETERMINED:
        return _buildWaitingScreen();
        break;
      case AuthStatus.NOT_LOGGED_IN:
        return LoginSignUpPage(
          auth: widget.auth,
          onSignedIn: _onLoggedIn,
        );
        break;
      case AuthStatus.LOGGED_IN:
        if (_userId.length > 0 && _userId != null) {
          //        return HomePage(
          //          userId: _userId,
          //          auth: widget.auth,
          //          onSignedOut: _onSignedOut,
          //        );
          return Welcome();
          // return Test();
        } else
          return _buildWaitingScreen();
        break;
      default:
        return _buildWaitingScreen();
    }
  }

  int temp = 0;
  final GoogleSignIn googleSignIn = GoogleSignIn();
}
