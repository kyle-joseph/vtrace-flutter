import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vtraceflutter/components/customappbar.dart';
import 'package:vtraceflutter/components/drawer.dart';
import 'package:vtraceflutter/screens/Auth/auth.dart';
import 'package:vtraceflutter/screens/Home/home.body.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String active = "home";

    // if (state.currentUser.email == "none" &&
    //     state.currentUser.company == "none") {
    return Auth();
    // }

    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomAppbar(
          title: "",
          color: Color(0xff5253ED),
        ),
        body: HomeBody(),
        drawer: CustomDrawer(active: active),
      ),
    );
  }
}
