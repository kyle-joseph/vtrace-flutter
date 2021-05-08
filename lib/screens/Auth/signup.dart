import 'package:flutter/material.dart';
import 'package:vtraceflutter/components/loading.dart';
import 'package:vtraceflutter/services/connection.dart';
import 'package:vtraceflutter/services/authentication.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

class SignupPage extends StatefulWidget {
  final Function toggleView;
  SignupPage({this.toggleView});

  @override
  State<StatefulWidget> createState() => new _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _signupFormKey = GlobalKey<FormState>();
  final Authentication _auth = Authentication();
  bool loading = false;

  String company = '';
  String address = '';
  String contactNumber = '';
  String email = '';
  String password = '';
  String confirmPassword = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            body: Container(
                child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  height: 250,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                    image: AssetImage("assets/images/background1.png"),
                    fit: BoxFit.fill,
                  )),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: Form(
                    key: _signupFormKey,
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                    color: Color.fromRGBO(143, 148, 251, .2),
                                    blurRadius: 20.0,
                                    offset: Offset(0, 10))
                              ]),
                          child: Column(
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.fromLTRB(20, 0, 10, 0),
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            color: Colors.grey[100]))),
                                child: TextFormField(
                                  validator: (val) => val.isEmpty
                                      ? 'Please enter establishment name.'
                                      : null,
                                  onChanged: (val) {
                                    setState(() => company = val);
                                  },
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Establishment name",
                                      hintStyle:
                                          TextStyle(color: Colors.grey[400])),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.fromLTRB(20, 0, 10, 0),
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            color: Colors.grey[100]))),
                                child: TextFormField(
                                  validator: (val) => val.isEmpty
                                      ? 'Please enter address.'
                                      : null,
                                  onChanged: (val) {
                                    setState(() => address = val);
                                  },
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Address",
                                      hintStyle:
                                          TextStyle(color: Colors.grey[400])),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.fromLTRB(20, 0, 10, 0),
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            color: Colors.grey[100]))),
                                child: TextFormField(
                                  validator: (val) => val.isEmpty
                                      ? 'Please enter contact number.'
                                      : null,
                                  onChanged: (val) {
                                    setState(() => contactNumber = val);
                                  },
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Contact number",
                                      hintStyle:
                                          TextStyle(color: Colors.grey[400])),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.fromLTRB(20, 0, 10, 0),
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            color: Colors.grey[100]))),
                                child: TextFormField(
                                  validator: (val) {
                                    if (val.isNotEmpty) {
                                      bool emailValid = RegExp(
                                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                          .hasMatch(val);
                                      if (emailValid) {
                                        return null;
                                      }
                                      return 'Invalid email';
                                    }
                                    return 'Please enter email.';
                                  },
                                  onChanged: (val) {
                                    setState(() => email = val);
                                  },
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Email",
                                      hintStyle:
                                          TextStyle(color: Colors.grey[400])),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.fromLTRB(20, 0, 10, 0),
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            color: Colors.grey[100]))),
                                child: TextFormField(
                                  validator: (val) => val.length < 8
                                      ? 'Password should be at least 8 characters.'
                                      : null,
                                  onChanged: (val) {
                                    setState(() => password = val);
                                  },
                                  obscureText: true,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Password",
                                      hintStyle:
                                          TextStyle(color: Colors.grey[400])),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.fromLTRB(20, 0, 10, 0),
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            color: Colors.grey[100]))),
                                child: TextFormField(
                                  validator: (val) {
                                    if (val != password) {
                                      return "Password doesn't match.";
                                    }
                                    return null;
                                  },
                                  onChanged: (val) {
                                    setState(() => confirmPassword = val);
                                  },
                                  obscureText: true,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Confirm Password",
                                      hintStyle:
                                          TextStyle(color: Colors.grey[400])),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'By clicking "Signup", you are agree to the terms of service and privacy policy',
                          style: TextStyle(
                              color: Color.fromRGBO(143, 148, 251, 1)),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 50,
                          width: 300,
                          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: RaisedButton(
                            color: Colors.purple[280],
                            child: Text(
                              'Signup',
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Color.fromRGBO(143, 100, 251, .8)),
                            ),
                            onPressed: () async {
                              //Signup

                              if (_signupFormKey.currentState.validate()) {
                                bool connection =
                                    await Connection().checkConnection();
                                if (connection) {
                                  setState(() => loading = true);
                                  SharedPreferences _login =
                                      await SharedPreferences.getInstance();

                                  var newEstablishment = await _auth.signup(
                                      email: email,
                                      password: password,
                                      establishmentName: company,
                                      address: address,
                                      contactNumber: contactNumber);

                                  if (newEstablishment['success']) {
                                    var establishmentLogin = await _auth.login(
                                        establishmentId:
                                            newEstablishment['newEstablishment']
                                                ['establishmentId'],
                                        password: password);

                                    if (establishmentLogin['success']) {
                                      _login.setString(
                                          'establishmentName',
                                          establishmentLogin[
                                              'establishmentName']);
                                      _login.setString(
                                          'establishmentId',
                                          establishmentLogin[
                                              'establishmentId']);
                                      _login.setString('vtestToken',
                                          establishmentLogin['vtestToken']);

                                      setState(() => loading = false);
                                      await Navigator.popAndPushNamed(
                                          context, "/");
                                    } else {
                                      setState(() {
                                        loading = false;
                                        error =
                                            "Failed to login. Please try again";
                                      });
                                    }
                                  } else {
                                    setState(() {
                                      loading = false;
                                      error =
                                          "An error in creating your account.";
                                    });
                                  }
                                } else {
                                  Toast.show("No Internet Connection", context,
                                      duration: 5, gravity: Toast.TOP);
                                }
                              }
                            },
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            vertical: 5,
                          ),
                          child: Text(
                            error,
                            style: TextStyle(
                              color: Colors.redAccent,
                            ),
                          ),
                        ),
                        Container(
                            child: Row(
                          children: <Widget>[
                            Text(
                              'Already Registered?',
                              style: TextStyle(
                                  color: Color.fromRGBO(143, 148, 251, .8)),
                            ),
                            FlatButton(
                              textColor: Colors.blue,
                              child: Text(
                                'Login',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Color.fromRGBO(143, 148, 251, .8),
                                ),
                              ),
                              onPressed: () {
                                //signup screen
                                widget.toggleView();
                              },
                            )
                          ],
                          mainAxisAlignment: MainAxisAlignment.center,
                        ))
                      ],
                    ),
                  ),
                )
              ],
            ),
          )));
  }
}
