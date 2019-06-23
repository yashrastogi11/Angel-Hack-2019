import 'package:donation_app/authentication.dart';
import 'package:donation_app/root_page.dart';
import 'package:donation_app/selected_photo.dart';
import 'package:flutter/material.dart';

class IntroScreen extends StatefulWidget {
  @override
  _IntroScreenState createState() => _IntroScreenState();
}

List<String> photos = [
  "images/11.jpg",
  "images/22.jpg",
  "images/33.jpg",
  "images/44.png"
];

class _IntroScreenState extends State<IntroScreen>
    with SingleTickerProviderStateMixin {
  AnimationController animController;
  Animation carouselAnimation;

  @override
  void initState() {
    super.initState();

    animController =
        new AnimationController(duration: Duration(seconds: 8), vsync: this);

    carouselAnimation =
        IntTween(begin: 0, end: photos.length - 1).animate(animController)
          ..addListener(() {
            setState(() {
              photoIndex = carouselAnimation.value;
            });
          });

    animController.repeat();
  }

  @override
  void dispose() {
    animController.dispose();
    super.dispose();
  }

  int photoIndex = 0;

  Widget content(int photoIndex) {
    if (photoIndex == 0)
      return Text(
        "Welcome to Fem-in-need",
        style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Color.fromRGBO(112, 112, 112, 1)),
      );
    else if (photoIndex == 1)
      return Text(
        "Working",
        style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Color.fromRGBO(112, 112, 112, 1)),
      );
    else if (photoIndex == 2)
      return Text(
        "A Personal Profile",
        style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Color.fromRGBO(112, 112, 112, 1)),
      );
    else
      return Text(
        "Panic Button",
        style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Color.fromRGBO(112, 112, 112, 1)),
      );
  }

  Widget content2(int photoIndex) {
    if (photoIndex == 0)
      return Text(
        "Panic? Press the Alert button to inform your trusted contacts by sending your location along",
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color.fromRGBO(112, 112, 112, 0.8)),
      );
    else if (photoIndex == 1)
      return Text(
        "Panic? Press the Alert button to inform your trusted contacts by sending your location along",
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color.fromRGBO(112, 112, 112, 0.8)),
      );
    else if (photoIndex == 2)
      return Text(
        "Panic? Press the Alert button to inform your trusted contacts by sending your location along",
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color.fromRGBO(112, 112, 112, 0.8)),
      );
    else
      return Text(
        "Panic? Press the Alert button to inform your trusted contacts by sending your location along",
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color.fromRGBO(112, 112, 112, 0.8)),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 50,
          ),
          content(photoIndex),
          SizedBox(
            height: 30,
          ),
          Container(
            height: MediaQuery.of(context).size.height / 2,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(photos[photoIndex]), fit: BoxFit.cover)),
          ),
          SizedBox(
            height: 40,
          ),
          content2(photoIndex),
          SizedBox(
            height: 30,
          ),
          SelectedPhoto(
            photoIndex: photoIndex,
            numberOfDots: 4,
          ),
          SizedBox(
            height: 30,
          ),
          ButtonTheme(
            minWidth: 350,
            height: 45,
            child: RaisedButton(
              child: Text(
                "Login",
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
              color: Colors.indigo,
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => RootPage(auth: Auth())),
                );
              },
              elevation: 5,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
            ),
          ),
        ],
      ),
    );
  }
}
