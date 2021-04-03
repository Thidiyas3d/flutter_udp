import 'dart:io';

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter UDP'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String udpMessage = "No data received!";

  void listen() async {
    var portNo = 56000;
    await RawDatagramSocket.bind(InternetAddress.anyIPv4, portNo)
        .then((udpSocket) {
      udpSocket.listen((e) {
        print(e.toString());
        var d = udpSocket.receive();
        if (d != null) {
          var message = String.fromCharCodes(d.data);
          setState(() {
            udpMessage = message;
          });
          print(udpMessage);
          //var jsonResp = json.encode(message);
          //print(jsonResp);
          // d.data.forEach((x) => print(x));
        }
      });
    });
  }

  @override
  void initState() {
    super.initState();
    listen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(child: Text("UDP Data")),
            ),
            Center(
              child: Text(udpMessage.toString()),
            )
          ],
        ),
      ),
    );
  }
}
