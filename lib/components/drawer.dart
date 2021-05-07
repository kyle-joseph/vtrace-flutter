import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomDrawer extends StatefulWidget {
  final String active;

  CustomDrawer({this.active});

  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  Color homeColor;
  Color logsColor;
  Color scanColor;

  bool establishmentDataExists = false;
  SharedPreferences _establishmentData;

  void initEstablishmentData() async {
    _establishmentData = await SharedPreferences.getInstance();
    if (_establishmentData.containsKey('establishmentName') &&
        _establishmentData.containsKey('establishmentId') &&
        _establishmentData.containsKey('vtestToken')) {
      setState(() {
        establishmentDataExists = true;
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
    activeColor();
    // final user = Provider.of<AppState>(context).currentUser;
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            margin: EdgeInsets.zero,
            decoration: BoxDecoration(
              color: Color(0xff5253ED),
            ),
            child: Container(
              child: Column(
                children: [
                  Material(
                    borderRadius: BorderRadius.all(Radius.circular(50.0)),
                    child: Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Image.asset(
                        'assets/images/flutterlogo.png',
                        width: 55,
                        height: 55,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                    child: Text(
                      establishmentDataExists
                          ? _establishmentData.getString('establishmentName')
                          : "",
                      style: GoogleFonts.nunito(
                        textStyle: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                    child: Text(
                      establishmentDataExists
                          ? _establishmentData.getString('establishmentId')
                          : "",
                      style: GoogleFonts.nunito(
                        textStyle: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () async {
              await Navigator.popAndPushNamed(context, "/");
            },
            child: ListTile(
              leading: Icon(
                Icons.home,
                size: 30.0,
              ),
              title: Text(
                'Home',
                style: TextStyle(
                  fontSize: 17.0,
                ),
              ),
              trailing: Icon(Icons.arrow_right),
              tileColor: homeColor,
            ),
          ),
          InkWell(
            onTap: () async {
              await Navigator.popAndPushNamed(context, "/logs");
            },
            child: ListTile(
              leading: Icon(
                Icons.list_alt_rounded,
                size: 30.0,
              ),
              title: Text(
                'Logs',
                style: TextStyle(
                  fontSize: 17.0,
                ),
              ),
              trailing: Icon(Icons.arrow_right),
              tileColor: logsColor,
            ),
          ),
          InkWell(
            onTap: () async {
              await Navigator.popAndPushNamed(context, "/scan");
            },
            child: ListTile(
              leading: Icon(
                Icons.qr_code,
                size: 30.0,
              ),
              title: Text(
                'Scan',
                style: TextStyle(
                  fontSize: 17.0,
                ),
              ),
              trailing: Icon(Icons.arrow_right),
              tileColor: scanColor,
            ),
          ),
          InkWell(
            onTap: () async {
              // Provider.of<AppState>(context, listen: false).setUser(User());

              _establishmentData.remove('establishmentId');
              _establishmentData.remove('establishmentName');
              _establishmentData.remove('vtestToken');

              await Navigator.popAndPushNamed(context, "/");
            },
            child: ListTile(
              leading: Icon(
                Icons.logout,
                size: 30.0,
              ),
              title: Text(
                'Logout',
                style: TextStyle(
                  fontSize: 17.0,
                ),
              ),
              trailing: Icon(Icons.arrow_right),
            ),
          ),
        ],
      ),
    );
  }

  void activeColor() {
    switch (widget.active) {
      case "home":
        homeColor = Color(0xffEEEEEE);
        break;
      case "logs":
        logsColor = Color(0xffEEEEEE);
        break;
      case "scan":
        scanColor = Color(0xffEEEEEE);
        break;
      default:
        homeColor = Colors.white;
        logsColor = Colors.white;
        scanColor = Colors.white;
    }
  }
}
