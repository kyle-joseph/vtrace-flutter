import 'package:flutter/material.dart';
import 'package:vtraceflutter/screens/Auth/login.dart';
import 'package:vtraceflutter/screens/Auth/signup.dart';

class Auth extends StatefulWidget {
  @override
  _AuthState createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  bool showSignIn = true;

  void toggleView() {
    setState(() => showSignIn = !showSignIn);
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn) {
      return LoginPage(toggleView: toggleView);
    } else {
      return SignupPage(toggleView: toggleView);
    }
  }
}
