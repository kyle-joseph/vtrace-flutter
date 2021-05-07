import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vtraceflutter/components/customappbar.dart';
import 'package:vtraceflutter/components/drawer.dart';
import 'package:vtraceflutter/components/loading.dart';
import 'package:vtraceflutter/screens/Auth/auth.dart';
import 'package:vtraceflutter/screens/Home/home.body.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  SharedPreferences _establishment;
  bool displayAuth = true;
  bool initDone = false;

  void initEstablishmentData() async {
    _establishment = await SharedPreferences.getInstance();
    if (_establishment.containsKey('establishmentName') &&
        _establishment.containsKey('establishmentId') &&
        _establishment.containsKey('vtestToken')) {
      setState(() {
        initDone = true;
        displayAuth = false;
      });
    } else {
      setState(() {
        initDone = true;
        displayAuth = true;
      });
    }
  }

  @override
  void initState() {
    initEstablishmentData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String active = "home";

    if (initDone) {
      if (!displayAuth) {
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
      } else {
        return Auth();
      }
    }

    return Loading();
  }
}
