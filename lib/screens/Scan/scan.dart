import 'package:flutter/material.dart';
import 'package:vtraceflutter/components/customappbar.dart';
import 'package:vtraceflutter/components/drawer.dart';
import 'package:vtraceflutter/screens/Scan/scan.body.dart';

class Scan extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String active = "scan";
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomAppbar(
          title: "Scan QR Code",
          color: Color(0xff5253ED),
        ),
        body: ScanBody(),
        drawer: CustomDrawer(active: active),
      ),
    );
  }
}
