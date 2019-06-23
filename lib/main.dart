import 'package:donation_app/authentication.dart';
import 'package:donation_app/intro_screen.dart';
import 'package:donation_app/root_page.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Enlight!n",
      home: IntroScreen(),
      // home: RootPage(auth: Auth()),
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        fontFamily: 'ProximaNova'
      ),
    );
  }
}
