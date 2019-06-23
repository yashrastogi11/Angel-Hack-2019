import 'package:donation_app/video/call.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class IndexPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new IndexState();
  }
}

class IndexState extends State<IndexPage> {
  /// create a channelController to retrieve text value
  final _channelController = TextEditingController();

  /// if channel textfield is validated to have error
  bool _validateError = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _handleCameraAndMic();
  }

  @override
  void dispose() {
    // dispose input controller
    _channelController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Let\'s Video Chat'),
        ),
        body: Center(
          child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              height: 400,
              child: Column(
                children: <Widget>[
                  Row(children: <Widget>[]),
                  Row(children: <Widget>[
                    Expanded(
                        child: TextField(
                      controller: _channelController,
                      decoration: InputDecoration(
                          errorText: _validateError
                              ? "Channel name is mandatory"
                              : null,
                          border: UnderlineInputBorder(
                              borderSide: BorderSide(width: 1)),
                          hintText: 'Channel name'),
                    ))
                  ]),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: ButtonTheme(
                      height: 40,
                      minWidth: MediaQuery.of(context).size.width - 100,
                      child: RaisedButton(
                        onPressed: () => onJoin(),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        elevation: 5,
                        child: Text(
                          "Join",
                          style: TextStyle(fontSize: 20),
                        ),
                        color: Colors.indigo,
                        textColor: Colors.white,
                      ),
                    ),
                  )
                ],
              )),
        ));
  }

  onJoin() async {
    // update input validation
    setState(() {
      _channelController.text.isEmpty
          ? _validateError = true
          : _validateError = false;
    });
    if (_channelController.text.isNotEmpty) {
      // await for camera and mic permissions before pushing video page
      await _handleCameraAndMic();
      // push video page with given channel name
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => new CallPage(
                    channelName: _channelController.text,
                  )));
    }
  }

  _handleCameraAndMic() async {
    await PermissionHandler().requestPermissions(
        [PermissionGroup.camera, PermissionGroup.microphone]);
  }
}
