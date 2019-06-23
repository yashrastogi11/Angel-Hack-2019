import 'package:donation_app/authentication.dart';
import 'package:donation_app/intro_screen.dart';
import 'package:donation_app/password_recovery.dart';
import 'package:donation_app/root_page.dart';
import 'package:donation_app/welcome.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginSignUpPage extends StatefulWidget {
  LoginSignUpPage({this.auth, this.onSignedIn});

  final BaseAuth auth;
  final VoidCallback onSignedIn;

  @override
  State<StatefulWidget> createState() => new _LoginSignUpPageState();
}

enum FormMode { LOGIN, SIGNUP }

GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: <String>[
    'email',
    'https://www.googleapis.com/auth/contacts.readonly',
  ],
);

class _LoginSignUpPageState extends State<LoginSignUpPage> {
  final _formKey = new GlobalKey<FormState>();

  String _errorMessage;

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  String userId = "";

  TextEditingController _c = TextEditingController();

  // Initial form is login form
  FormMode _formMode = FormMode.LOGIN;
  bool _isIos;
  bool _isLoading;

  int temp = 0;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  GoogleSignInAccount _currentUser;

  Future<FirebaseUser> _signIn() async {
    temp = 1;

    await _googleSignIn.signIn();
  }

  // Check if form is valid before perform login or signup
  bool _validateAndSave() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  // Perform login or signup
  _validateAndSubmit() async {
    setState(() {
      _errorMessage = "";
      _isLoading = true;
    });
    if (true) {
      try {
        if (_formMode == FormMode.LOGIN) {
          userId = await widget.auth.signIn(email.text, password.text);
          print('Signed in: $userId');
          Flushbar(
            message: "Successfully Signed In",
            duration: Duration(seconds: 4),
          );
          // Navigator.pushReplacement(context,
          //     MaterialPageRoute(builder: (context) => Welcome(userId)));
        } else {
          userId = await widget.auth.signUp(email.text, password.text);
          print('Signed up user: $userId');
          // AfterSignUp(userId);
          // Navigator.pushReplacement(context,
          //     MaterialPageRoute(builder: (context) => AfterSignUp(userId)));
        }
        setState(() {
          _isLoading = false;
        });

        if (userId.length > 0 && userId != null) {
          widget.onSignedIn();
        }
      } catch (e) {
        print('Error: $e');
        setState(() {
          _isLoading = false;
          if (_isIos) {
            _errorMessage = e.details;
          } else
            _errorMessage = e.toString();
        });
      }
    }
  }

  @override
  void initState() {
    _errorMessage = "";
    _isLoading = false;
    super.initState();
  }

  void _changeFormToSignUp() {
    _formKey.currentState.reset();
    _errorMessage = "";
    setState(() {
      _formMode = FormMode.SIGNUP;
    });
  }

  void _changeFormToLogin() {
    _formKey.currentState.reset();
    _errorMessage = "";
    setState(() {
      _formMode = FormMode.LOGIN;
    });
  }

  @override
  Widget build(BuildContext context) {
    _isIos = Theme.of(context).platform == TargetPlatform.iOS;
    return new Scaffold(
        // appBar: new AppBar(
        //   title: new Text("Cook and Eat"),
        // ),
        body: Stack(
      overflow: Overflow.visible,
      children: <Widget>[
        Container(
          
          child: Image(
            image: AssetImage("images/background.jpg"),
            fit: BoxFit.contain,
          ),
        ),
        Positioned(
          child: Icon(Icons.work),
          top: 90,
          left: 40,
        ),

        Positioned(
          child: _formMode == FormMode.LOGIN
              ? Text(
                  "Welcome Back",
                  style: TextStyle(fontSize: 40),
                )
              : Text(
                  "Welcome to Enlighten",
                  style: TextStyle(fontSize: 40),
                ),
          left: 30,
          top: 180,
        ),
        Positioned(
          child: _formMode == FormMode.LOGIN
              ? Text(
                  "Login to continue",
                  style: TextStyle(fontSize: 18),
                )
              : Text(
                  "Signup to continue",
                  style: TextStyle(fontSize: 18),
                ),
          left: 30,
          top: 230,
        ),

        // Container(
        //   height: MediaQuery.of(context).size.height,
        //   padding: EdgeInsets.all(20),
        //   child: Form(
        //     key: _formKey,
        //     child: ListView(
        //       // shrinkWrap: true,
        //       children: <Widget>[
        //         SizedBox(height: 250),
        //         Form(
        //           child: Theme(
        //             data: ThemeData(
        //                 inputDecorationTheme: InputDecorationTheme(
        //                     labelStyle: TextStyle(fontSize: 15))),
        //             child: ListView(
        //               shrinkWrap: true,
        //               padding: EdgeInsets.only(left: 25, right: 25),
        //               scrollDirection: Axis.vertical,
        //               children: <Widget>[
        //                 TextFormField(
        //                   maxLines: 1,
        //                   autofocus: false,
        //                   decoration: InputDecoration(
        //                     labelText: "Email Address",
        //                     labelStyle: TextStyle(fontSize: 18),
        //                   ),
        //                   keyboardType: TextInputType.emailAddress,
        //                   validator: (value) =>
        //                       value.isEmpty ? 'Email can\'t be empty' : null,
        //                   onSaved: (value) => _email = value,
        //                 ),
        //                 SizedBox(
        //                   height: 50,
        //                 ),
        //                 TextFormField(
        //                   decoration: InputDecoration(
        //                     labelText: "Password",
        //                     labelStyle: TextStyle(fontSize: 18),
        //                   ),
        //                   autofocus: false,
        //                   obscureText: true,
        //                   validator: (value) =>
        //                       value.isEmpty ? 'Password can\'t be empty' : null,
        //                   onSaved: (value) => _password = value,
        //                 ),
        //                 SizedBox(
        //                   height: 40,
        //                 ),
        //                 ButtonTheme(
        //                   height: 60,
        //                   minWidth: 350,
        //                   child: RaisedButton(
        //                     child: Text(
        //                       "Proceed",
        //                       style: TextStyle(
        //                         fontSize: 20,
        //                         color: Colors.white,
        //                         fontWeight: FontWeight.bold,
        //                       ),
        //                     ),
        //                     color: Colors.green,
        //                     onPressed: _validateAndSubmit(),
        //                     elevation: 5,
        //                     shape: RoundedRectangleBorder(
        //                         borderRadius: BorderRadius.circular(15)),
        //                   ),
        //                 ),
        //                 _showErrorMessage(),
        //                 SizedBox(
        //                   height: 20,
        //                 )
        //               ],
        //             ),
        //           ),
        //         ),
        //       ],
        //     ),
        //   ),
        // ),
        // Positioned(
        //   child: FlatButton(
        //       child: Text(
        //         "Forgot Password",
        //         style: TextStyle(
        //           fontSize: 20,
        //         ),
        //       ),
        //       onPressed: () => null),
        //   left: 10,
        //   top: MediaQuery.of(context).size.height - 60,
        // ),
        // Positioned(
        //   child: FlatButton(
        //       child: Text(
        //         "Create Account",
        //         style: TextStyle(
        //           fontSize: 20,
        //         ),
        //       ),
        //       onPressed: () => null),
        //   left: 240,
        //   top: MediaQuery.of(context).size.height - 60,
        // ),
        _showBody(),
        _showCircularProgress(),

        // Positioned(
        //   child: FlatButton(
        //     child: Text(
        //       "Forgot Password",
        //       style: TextStyle(
        //         fontSize: 20,
        //       ),
        //     ),
        //     onPressed: () {
        //       Navigator.push(context,
        //           MaterialPageRoute(builder: (context) => IntroScreen()));
        //     },
        //   ),
        //   left: 40,
        //   top: MediaQuery.of(context).size.height - 60,
        // ),

        // Positioned(
        //   child: FlatButton(
        //     padding: EdgeInsets.only(top: 20, bottom: 25),
        //     child: _formMode == FormMode.LOGIN ? words1() : words2(),
        //     onPressed: _formMode == FormMode.LOGIN
        //         ? _changeFormToSignUp
        //         : _changeFormToLogin,
        //   ),
        //   left: 240,
        //   top: MediaQuery.of(context).size.height - 60,
        // ),
      ],
    ));
  }

  Widget _showCircularProgress() {
    if (_isLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    return Container(
      height: 0.0,
      width: 0.0,
    );
  }

  Widget _showBody() {
    return new Container(
        padding: EdgeInsets.all(16.0),
        child: new Form(
          key: _formKey,
          child: new ListView(
            shrinkWrap: true,
            children: <Widget>[
              SizedBox(
                height: 200,
              ),
              // _showLogo(),
              _showEmailInput(),
              _showPasswordInput(),

              _showPrimaryButton(),
              _showResetButton(),
              _showSecondaryButton(),
              _showErrorMessage(),
              // _line(),
              // _loginWithGmail(),
            ],
          ),
        ));
  }

  // Widget _line() {
  //   return Column(
  //     children: <Widget>[
  //       Row(
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         children: <Widget>[
  //           Container(
  //             height: 1,
  //             width: MediaQuery.of(context).size.width / 2.5,
  //             color: Colors.grey[400],
  //           ),
  //           Text(
  //             'OR',
  //             style: TextStyle(color: Colors.grey[500], fontSize: 15),
  //           ),
  //           Container(
  //             height: 1,
  //             width: MediaQuery.of(context).size.width / 2.5,
  //             color: Colors.grey[400],
  //           ),
  //         ],
  //       ),
  //       SizedBox(height: 20),
  //       Text(
  //         "Continue With",
  //         style: TextStyle(color: Colors.grey[600], fontSize: 15),
  //       ),
  //     ],
  //   );
  // }

  // Widget _loginWithGmail() {
  //   return Padding(
  //       padding: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
  //       child: Row(
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         children: <Widget>[
  //           IconButton(
  //             iconSize: 50,
  //             icon: Icon(Icons.cake),
  //             onPressed: () {
  //               _signIn()
  //                   .then((FirebaseUser user) => print(user))
  //                   .catchError((e) => print(e));

  //               if (FirebaseUser != null) {
  //                 Navigator.of(context).pop();

  //                 Navigator.of(context).pushReplacement(
  //                   MaterialPageRoute(
  //                       builder: (context) => RootPage(auth: Auth())),
  //                 );
  //               } else {
  //                 Flushbar(
  //                   message: "Please Sign In",
  //                   duration: Duration(seconds: 4),
  //                 );
  //               }
  //             },
  //           ),
  //           // IconButton(
  //           //   iconSize: 50,
  //           //   icon: Image.asset("images/facebook.png"),
  //           //   onPressed: () {},
  //           // ),
  //         ],
  //       ));
  // }

  Widget _showErrorMessage() {
    if (_errorMessage.length > 0 && _errorMessage != null) {
      return new Text(
        _errorMessage,
        style: TextStyle(
            fontSize: 14.0,
            color: Colors.red,
            height: 1.0,
            fontWeight: FontWeight.w400),
      );
    } else {
      return new Container(
        height: 0.0,
      );
    }
  }

  Widget _showLogo() {
    return Hero(
      tag: 'hero',
      child: Padding(
        padding: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
        child: CircleAvatar(
          backgroundColor: Colors.transparent,
          radius: 40.0,
          child: Icon(Icons.atm),
        ),
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
        // onSaved: (value) => _email = value,
      ),
    );
  }

  Widget _showPasswordInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
      child: new TextFormField(
        maxLines: 1,
        obscureText: true,
        autofocus: false,
        decoration: new InputDecoration(
            labelText: 'Password',
            icon: new Icon(
              Icons.lock,
              color: Colors.grey,
            )),
        controller: password,
        validator: (value) => value.isEmpty ? 'Password can\'t be empty' : null,
        // onSaved: (value) => _password = value,
      ),
    );
  }

  Widget _showResetButton() {
    return FlatButton(
      // padding: EdgeInsets.only(top: 20),
      child: Text(
        "Forgot Password?",
        style: TextStyle(
          fontSize: 18,
        ),
      ),
      onPressed: () => Navigator.push(
          context, MaterialPageRoute(builder: (context) => Password())),
      // onPressed: () {
      //   showDialog(
      //       context: context,
      //       builder: (context) {
      //         return AlertDialog(
      //           title: Text("Password reset"),
      //           content: TextFormField(
      //             validator: (value) =>
      //                 value.isEmpty ? 'Email can\'t be empty' : null,
      //             controller: _c,
      //             decoration: InputDecoration(
      //               hintText: "Enter your Email",
      //             ),
      //           ),
      //           actions: <Widget>[
      //             FlatButton(
      //               child: Text("Submit"),
      //               onPressed: () {
      //                 FirebaseAuth.instance
      //                     .sendPasswordResetEmail(email: _c.text);
      //                 _c.clear();
      //                 Navigator.of(context).pop();
      //               },
      //             ),
      //           ],
      //         );
      //       });
      // },
    );
  }

  Widget _showSecondaryButton() {
    return new FlatButton(
      // padding: EdgeInsets.only(top: 20),
      child: _formMode == FormMode.LOGIN ? words1() : words2(),
      onPressed: _formMode == FormMode.LOGIN
          ? _changeFormToSignUp
          : _changeFormToLogin,
    );
  }

  Widget words1() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          'New User? ',
          style: TextStyle(
            fontSize: 18,
            color: Colors.grey[800],
          ),
        ),
        Text(
          ' Create Account',
          style: TextStyle(
            fontSize: 18,
            color: Colors.red,
          ),
        )
      ],
    );
  }

  Widget words2() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          'Have an Account? ',
          style: TextStyle(
            fontSize: 20,
            color: Colors.grey[800],
          ),
        ),
        Text(
          ' Sign In',
          style: TextStyle(
            fontSize: 20,
            color: Colors.red,
          ),
        ),
      ],
    );
  }

  Widget _showPrimaryButton() {
    return new Padding(
        padding: EdgeInsets.fromLTRB(0.0, 50.0, 0.0, 40.0),
        child: SizedBox(
          height: 60.0,
          child: ButtonTheme(
            height: 50,
            child: RaisedButton(
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0)),
              color: Color.fromRGBO(0, 27, 72, .75),
              child: _formMode == FormMode.LOGIN
                  ? Text('Proceed',
                      style: TextStyle(fontSize: 20.0, color: Colors.white))
                  : Text('Create account',
                      style: TextStyle(fontSize: 20.0, color: Colors.white)),
              onPressed: _validateAndSubmit,
            ),
          ),
        ));
  }
}
