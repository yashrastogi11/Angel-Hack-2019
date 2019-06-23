import 'package:donation_app/authentication.dart';
import 'package:donation_app/login_signup_page.dart';
import 'package:donation_app/welcome.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AfterSignUp extends StatefulWidget {
  AfterSignUp({this.auth});
  final BaseAuth auth;
  @override
  _AfterSignUpState createState() => _AfterSignUpState();
}

class _AfterSignUpState extends State<AfterSignUp> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  final _formKey = new GlobalKey<FormState>();

  String _errorMessage = "";

  String userid = "";

  TextEditingController _age = TextEditingController();
  TextEditingController _gender = TextEditingController();
  TextEditingController _name = TextEditingController();
  TextEditingController _address = TextEditingController();

  TextEditingController _pinCode = TextEditingController();
  TextEditingController _phone = TextEditingController();

  SharedPreferences prefs;

  String name = '';
  String gender = '';
  String address = '';
  String age = '';
  String pinCode = '';
  String phone = '';
  String dispValue = '';

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
    name = prefs.getString('name') ?? '';
    age = prefs.getString('age') ?? '';
    pinCode = prefs.getString('pinCode') ?? '';
    address = prefs.getString('address') ?? '';
    phone = prefs.getString('phone') ?? '';
    dispValue = prefs.getString('dispValue') ?? '';

    _name = TextEditingController(text: name);
    _age = TextEditingController(text: age);
    _pinCode = TextEditingController(text: pinCode);
    _phone = TextEditingController(text: phone);
    _gender = TextEditingController(text: gender);
    _address = TextEditingController(text: address);
  }

  void role(String e) {
    setState(() {
      if (e == "1") {
        dispValue = "1";
      } else if (e == "2") {
        dispValue = "2";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Registration"),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: <Widget>[
            Form(
              key: _formKey,
              child: ListView(
                shrinkWrap: true,
                children: <Widget>[
                  _showName(),
                  _showNameInput(),
                  _showGender(),
                  _showGenderInput(),
                  _showAge(),
                  _showAgeInput(),
                  _showAddress(),
                  _showAddressInput(),
                  _showPhone(),
                  _showPhoneInput(),
                  _showPinCode(),
                  _showPinCodeInput(),
                  _showButton(),
                  _showLogoutButton(),
                  _showErrorMessage(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _showName() {
    return Padding(
      padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
      child: Text(
        "Name",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.purple,
          fontSize: 18,
        ),
      ),
    );
  }

  Widget _showNameInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 0.0),
      child: new TextField(
        maxLines: 1,
        keyboardType: TextInputType.text,
        autofocus: false,
        decoration: new InputDecoration(
          hintText: name,
          contentPadding: EdgeInsets.all(5.0),
        ),
        onChanged: (value) => name = value,
        controller: _name,
      ),
    );
  }

  Widget _showGender() {
    return Padding(
      padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
      child: Text(
        "Gender",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.purple,
          fontSize: 18,
        ),
      ),
    );
  }

  Widget _showGenderInput() {
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
      child: Row(
        children: <Widget>[
          Radio(
            value: "1",
            groupValue: dispValue,
            onChanged: (String e) => role(e),
          ),
          Text("Male"),
          SizedBox(
            width: 30,
          ),
          Radio(
            value: "2",
            groupValue: dispValue,
            onChanged: (String e) => role(e),
          ),
          Text("Female"),
        ],
      ),
    );
  }

  Widget _showAge() {
    return Padding(
      padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
      child: Text(
        "Age",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.purple,
          fontSize: 18,
        ),
      ),
    );
  }

  Widget _showAgeInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 0.0),
      child: new TextField(
        maxLines: 1,
        keyboardType: TextInputType.number,
        autofocus: false,
        decoration: new InputDecoration(
          hintText: age,
          contentPadding: EdgeInsets.all(5.0),
        ),
        onChanged: (value) => age = value,
        controller: _age,
      ),
    );
  }

  Widget _showAddress() {
    return Padding(
      padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
      child: Text(
        "Address",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.purple,
          fontSize: 18,
        ),
      ),
    );
  }

  Widget _showAddressInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 0.0),
      child: TextField(
        maxLines: 1,
        keyboardType: TextInputType.text,
        autofocus: false,
        decoration: InputDecoration(
          hintText: _address.text,
          contentPadding: EdgeInsets.all(5.0),
        ),
        onChanged: (value) => address = value,
        controller: _address,
      ),
    );
  }

  Widget _showPinCode() {
    return Padding(
      padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
      child: Text(
        "Pin Code",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.purple,
          fontSize: 18,
        ),
      ),
    );
  }

  Widget _showPinCodeInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 0.0),
      child: new TextField(
        maxLines: 1,
        keyboardType: TextInputType.number,
        autofocus: false,
        decoration: new InputDecoration(
          hintText: pinCode,
          contentPadding: EdgeInsets.all(5.0),
        ),
        onChanged: (value) => pinCode = value,
        controller: _pinCode,
      ),
    );
  }

  Widget _showPhone() {
    return Padding(
      padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
      child: Text(
        "Phone",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.purple,
          fontSize: 18,
        ),
      ),
    );
  }

  Widget _showPhoneInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 0.0),
      child: new TextField(
        maxLines: 1,
        keyboardType: TextInputType.phone,
        autofocus: false,
        decoration: new InputDecoration(
          hintText: phone,
          contentPadding: EdgeInsets.all(5.0),
        ),
        onChanged: (value) => phone = value,
        controller: _phone,
      ),
    );
  }

  Widget _showButton() {
    return new Padding(
      padding: EdgeInsets.fromLTRB(0.0, 25.0, 0.0, 0.0),
      child: SizedBox(
        height: 40.0,
        child: new RaisedButton(
          elevation: 5.0,
          shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(30.0),
          ),
          color: Colors.indigo,
          child: Text(
            "Save and Continue",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
          onPressed: _validateAndSubmit,
        ),
      ),
    );
  }

  Widget _showLogoutButton() {
    return new Padding(
      padding: EdgeInsets.fromLTRB(0.0, 25.0, 0.0, 0.0),
      child: SizedBox(
        height: 40.0,
        child: new RaisedButton(
          elevation: 5.0,
          shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(30.0),
          ),
          color: Colors.indigo,
          child: Text(
            "Logout",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
          onPressed: () {
            FirebaseAuth.instance.signOut();
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (BuildContext context) => LoginSignUpPage(),
                ),
                (Route<dynamic> route) => false);
          },
        ),
      ),
    );
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

  bool _validateAndSave() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  _validateAndSubmit() async {
    if (true) {
      try {
        if (dispValue != null) {
          if (dispValue == "1") {
            Firestore.instance.collection('users').document(userid).updateData({
              "uid": userid,
              "name": name,
              "age": int.parse(_age.text),
              "phone": int.parse(_phone.text),
              "pin code": int.parse(_pinCode.text),
              "address": address,
              "gender": "Male",
            }).then((data) async {
              await prefs.setString('name', name);
              await prefs.setString('age', age);
              await prefs.setString('phone', phone);
              await prefs.setString('address', address);
              await prefs.setString('pinCode', pinCode);
              await prefs.setString('dispValue', dispValue);
            });
          } else if (dispValue == "2") {
            Firestore.instance.collection('users').document(userid).updateData({
              "uid": userid,
              "name": name,
              "age": int.parse(_age.text),
              "phone": int.parse(_phone.text),
              "pin code": int.parse(_pinCode.text),
              "address": address,
              "gender": "Female",
            }).then((data) async {
              await prefs.setString('name', name);
              await prefs.setString('age', age);
              await prefs.setString('phone', phone);
              await prefs.setString('address', address);
              await prefs.setString('pinCode', pinCode);
              await prefs.setString('dispValue', dispValue);
            });
          }
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (BuildContext context) => Welcome(),
              ),
              (Route<dynamic> route) => false);
        } else {
          setState(() {
            _errorMessage = "Please select your gender";
          });
        }
      } catch (e) {
        setState(() {
          _errorMessage = e.toString();
        });
      }
    }
  }

  updateData() {}

  Future<String> getCurrentUser() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    return user.uid;
  }
}
