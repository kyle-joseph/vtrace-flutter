import 'package:flutter/material.dart';
import 'package:vtraceflutter/screens/Home/home.dart';
import 'package:vtraceflutter/screens/Logs/logs.dart';
import 'package:vtraceflutter/screens/Scan/scan.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'VTrace',
      initialRoute: '/',
      routes: {
        '/': (context) => Home(),
        '/logs': (context) => Logs(),
        '/scan': (context) => Scan(),
        // '/scanned': (context) => ScannedQR(),
      },
    );
  }
}
