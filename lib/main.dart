import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:wifi/wifi.dart';
import 'package:connectivity/connectivity.dart';

void main() => runApp(MyApp()); 

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wifi Strength',
      home: MyApp1(),
    );
  }
}

class MyApp1 extends StatefulWidget {
  @override
  _MyApp1State createState() => _MyApp1State();
}

class _MyApp1State extends State<MyApp1> {

  String display = "WELCOME";
  void _printStatus() async{
      String _temp = ""; 
      var connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult == ConnectivityResult.mobile) {
        _temp = "CONNECT TO WIFI";          
      } else if (connectivityResult == ConnectivityResult.wifi) {
        int _level = await Wifi.level;
        String _ip = await Wifi.ip;
        String _ssid = await Wifi.ssid;
        _temp = "WiFi id is $_ssid" + "\n IP address is : $_ip " + "\n Wifi Strength is $_level" ;          
      }else{
           _temp = "CONNECT TO INTERNET";          
      }
      setState(() {
        display = _temp;        
      });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
        title: new Text("Wifi Strength"),
      ),
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text(
                  '$display',
                  style: new TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                  fontFamily: 'Roboto',
                ),
              ),
            new Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  new RaisedButton(
                    padding: const EdgeInsets.all(8.0),
                    textColor: Colors.white,
                    color: Colors.blue,
                    onPressed: _printStatus,
                    child: new Text("GET STRENGTH"),
                  ),
                ],
              )
          ],
        ),
      ),
    );
  }
}