import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Password extends StatefulWidget {
  @override
  _PasswordState createState() => _PasswordState();
}

class _PasswordState extends State<Password> {
  TextEditingController email = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        overflow: Overflow.visible,
        children: <Widget>[
          Positioned(
            child: Text(
              "Password Recovery",
              style: TextStyle(
                fontSize: 40,
              ),
            ),
            left: 30,
            top: 180,
          ),
          Positioned(
            child: Text(
              "Enter your registered Email \nto get back to your account",
              softWrap: true,
              overflow: TextOverflow.visible,
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            left: 30,
            top: 230,
          ),
          Container(
            padding: EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: ListView(
                shrinkWrap: true,
                children: <Widget>[
                  Container(
                    alignment: Alignment.topLeft,
                    padding: EdgeInsets.only(left: 10, top: 30),
                    child: IconButton(
                      icon: Icon(Icons.arrow_back),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ),
                  SizedBox(
                    height: 150,
                  ),
                  _showEmailInput(),
                  _showButton(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _showEmailInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 65.0, 0.0, 0.0),
      child: new TextFormField(
        maxLines: 1,
        keyboardType: TextInputType.emailAddress,
        autofocus: false,
        decoration: new InputDecoration(
            labelText: "Email",
            icon: new Icon(
              Icons.mail,
              color: Colors.grey,
            )),
        controller: email,
        validator: (value) => value.isEmpty ? 'Email can\'t be empty' : null,
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
              "Proceed",
              style: TextStyle(
                fontSize: 20,
                color: Colors.white
              ),
            ),
            onPressed: () {
              FirebaseAuth.instance.sendPasswordResetEmail(email: email.text);
              email.clear();
              Navigator.of(context).pop();
            },
          ),
        ));
  }
}
