import 'package:flutter/material.dart';
import 'package:vtraceflutter/components/customappbar.dart';
import 'package:vtraceflutter/components/drawer.dart';
import 'package:vtraceflutter/screens/Logs/logs.body.dart';

class Logs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String active = "logs";
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomAppbar(
          title: "Logs",
          color: Color(0xff5253ED),
        ),
        body: LogsBody(),
        drawer: CustomDrawer(active: active),
      ),
    );
  }
}
