import 'dart:io';
import 'package:flutter/material.dart';
import 'package:dot_net_push/register.dart';
import 'package:device_info/device_info.dart';
import 'package:dot_net_push/providers/PushProvider.dart';
import 'package:unique_identifier/unique_identifier.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  SharedPreferences logindata;
  String username;

  @override
  void initState() {
    super.initState();
    final pushProvider = new PushProvider();
    pushProvider.initNotfy();
    initial();
  }

  void initial() async {
    logindata = await SharedPreferences.getInstance();
    setState(
      () {
        username = logindata.getString('username');
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Logged in as: $username'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Logout',
              style: TextStyle(fontSize: 30, color: Colors.pink[200]),
            ),
            RaisedButton(
              onPressed: () {
                logindata.setBool('login', true);
                Navigator.pushReplacement(
                    context,
                    new MaterialPageRoute(
                        builder: (context) => RegisterPage()));
              },
              child: Icon(
                Icons.logout,
                size: 40,
              ),
              shape: CircleBorder(),
              padding: EdgeInsets.all(20),
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              'Get Device',
              style: TextStyle(fontSize: 30, color: Colors.pink[200]),
            ),
            RaisedButton(
              shape: CircleBorder(),
              padding: EdgeInsets.all(20),
              onPressed: getDevice,
              child: Icon(
                Icons.device_unknown,
                size: 40,
              ),
            )
          ],
        ),
      ),
    );
  }

  getDevice() async {
    String identifier;
    if (Platform.isIOS) {
      final DeviceInfoPlugin deviceInfoPlugin = new DeviceInfoPlugin();
      var data = await deviceInfoPlugin.iosInfo;
      identifier = data.identifierForVendor;

      print("IDENTIFICADOR IOS: $identifier");
    } else {
      identifier = await UniqueIdentifier.serial;
      print("IDENTIFICADOR ANDROID: $identifier");
    }
    return identifier;
  }
}
