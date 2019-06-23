import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donation_app/after_results.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/widgets.dart';

class AResult extends StatefulWidget {
  AResult({Key key, @required this.userid}) : super(key: key);

  final String userid;

  @override
  _AResultState createState() => _AResultState();
}

class _AResultState extends State<AResult> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  String finalSum = "";
  String finalSum1 = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
    getData1();
    _makeData();
  }

  int sum = 0;
  int sum1 = 0;

  int sumT = 0;
  int sum1T = 0;

  Future<String> getCurrentUser() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    return user.uid;
  }

  getData() async {
    await Firestore.instance
        .collection('users')
        .document(widget.userid)
        .get()
        .then((doc) {
      sum = int.parse(doc.data['Aques1']) +
          int.parse(doc.data['Aques2']) +
          int.parse(doc.data['Aques3']) +
          int.parse(doc.data['Aques4']) +
          int.parse(doc.data['Aques5']) +
          int.parse(doc.data['Aques6']) +
          int.parse(doc.data['Aques7']);
      print(sum.toString());
      setState(() {
        finalSum = sum.toString();
        sumT = int.parse(((sum / 21) * 100).toStringAsFixed(0));
      });
      return sum.toString();
    });
  }

  getData1() async {
    await Firestore.instance
        .collection('users')
        .document(widget.userid)
        .get()
        .then((doc) {
      sum1 = int.parse(doc.data['Dques1']) +
          int.parse(doc.data['Dques2']) +
          int.parse(doc.data['Dques3']) +
          int.parse(doc.data['Dques4']) +
          int.parse(doc.data['Dques5']) +
          int.parse(doc.data['Dques6']) +
          int.parse(doc.data['Dques7']);
      print(sum1.toString());
      setState(() {
        finalSum1 = sum1.toString();
        sumT = int.parse(((sum / 21) * 100).toStringAsFixed(0));
      });
      return sum1.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                children: <Widget>[
                  SizedBox(
                    height: 60,
                  ),
                  Text(
                    "Anxiety",
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      fontSize: 30,
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      ((sum / 21) * 100).toStringAsFixed(2) + "%",
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.indigo,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  show(),
                ],
              ),
              SizedBox(
                width: 25,
              ),
              SizedBox(
                width: 25,
              ),
              Column(
                children: <Widget>[
                  SizedBox(
                    height: 60,
                  ),
                  Text(
                    "Depression",
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      fontSize: 30,
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      ((sum1 / 21) * 100).toStringAsFixed(2) + "%",
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.indigo,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  show1(),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 50,
          ),
          Container(
            padding: EdgeInsets.all(10),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 3,
            child: Center(
              child: Column(
                children: <Widget>[
                  Flexible(
                    fit: FlexFit.loose,
                    child: charts.BarChart(
                      _chartdata,
                      animate: true,
                      animationDuration: Duration(seconds: 2),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          body(),
          SizedBox(
            height: 50,
          ),
          ButtonTheme(
            height: 50,
            minWidth: 150,
            child: RaisedButton(
              child: Text(
                "Continue",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AfterResults(sum: sum, sum1: sum1),
                  ),
                );
              },
              elevation: 5,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
            ),
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }

  Widget show() {
    if (sum >= 7 && sum <= 10) {
      return Text(
        "Low",
        style: TextStyle(fontSize: 20, color: Colors.pink),
      );
    } else if (sum >= 11 && sum <= 14) {
      return Text(
        "Medium",
        style: TextStyle(fontSize: 20, color: Colors.pink),
      );
    } else if (sum >= 15 && sum <= 21) {
      return Text(
        "High",
        style: TextStyle(fontSize: 20, color: Colors.pink),
      );
    } else {
      return Text("");
    }
  }

  Widget show1() {
    if (sum1 >= 7 && sum1 <= 10) {
      return Text(
        "Low",
        style: TextStyle(fontSize: 20, color: Colors.pink),
      );
    } else if (sum1 >= 11 && sum1 <= 14) {
      return Text(
        "Medium",
        style: TextStyle(fontSize: 20, color: Colors.pink),
      );
    } else if (sum1 >= 15 && sum1 <= 21) {
      return Text(
        "High",
        style: TextStyle(fontSize: 20, color: Colors.pink),
      );
    } else {
      return Text("");
    }
  }

  Widget body() {
    if (sum >= 15 && sum1 >= 15) {
      return Text(
        "Your results indicate that you maybe experiencing symptons of anxiety and depression.",
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 20,
        ),
      );
    } else if (sum <= 10 && sum1 <= 10) {
      return Text(
        "Your results indicate that you may not be suffering from anxiety and depression. Still if you feel something isn\'t quite right we recommend you to follow our daily routines.",
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 20,
        ),
      );
    } else if (sum > sum1) {
      return Text(
        "Your results indicate that you maybe experiencing symptons of severe anxiety. These results do not mean that you have anxiety but we recommend you to start a conversaation with our mental health professionals.",
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 20,
        ),
      );
    } else if (sum < sum1) {
      return Text(
        "Your results indicate that you maybe experiencing symptons of severe depression. These results do not mean that you have anxiety but we recommend you to start a conversaation with our mental health professionals.",
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 20,
        ),
      );
    } else {
      return Text("");
    }
  }

  List<IndividualScore> _data1;
  List<charts.Series<IndividualScore, String>> _chartdata;

  void _makeData() {
    _data1 = List<IndividualScore>();
    _chartdata = List<charts.Series<IndividualScore, String>>();

    _data1.add(IndividualScore("Anxiety", 57));
    _data1.add(IndividualScore("Depression", 76));

    _chartdata.add(charts.Series(
        id: "Mental Health",
        colorFn: (_, __) => charts.MaterialPalette.indigo.shadeDefault,
        data: _data1,
        domainFn: (IndividualScore IndividualScore, _) => IndividualScore.issue,
        measureFn: (IndividualScore IndividualScore, _) =>
            IndividualScore.score,
        fillPatternFn: (_, __) => charts.FillPatternType.solid,
        displayName: "Score Card"));
  }
}

class IndividualScore {
  String issue;
  int score;
  IndividualScore(this.issue, this.score);
}
