import 'package:flutter/material.dart';
import 'package:vtraceflutter/components/loading.dart';
import 'package:vtraceflutter/services/connection.dart';
import 'package:vtraceflutter/services/authentication.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

class LoginPage extends StatefulWidget {
  final Function toggleView;
  LoginPage({this.toggleView});

  @override
  State<StatefulWidget> createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final Authentication _auth = Authentication();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;
  //error message
  String error = '';

  //will hold the value of email and password
  String establishmentId = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.white,
            body: Container(
              child: SingleChildScrollView(
                child: Column(children: <Widget>[
                  Container(
                    height: 250,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/images/background1.png"),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.all(30.0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                        color:
                                            Color.fromRGBO(143, 148, 251, .2),
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
                                          ? 'Please enter establishment id.'
                                          : null,
                                      onChanged: (val) {
                                        setState(() => establishmentId = val);
                                      },
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Establishment Id",
                                        hintStyle:
                                            TextStyle(color: Colors.grey[400]),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.fromLTRB(20, 0, 10, 0),
                                    child: TextFormField(
                                      obscureText: true,
                                      validator: (val) => val.length < 8
                                          ? 'Password should be at least 8 characters.'
                                          : null,
                                      onChanged: (val) {
                                        setState(() => password = val);
                                      },
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: "Password",
                                          hintStyle: TextStyle(
                                              color: Colors.grey[400])),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            FlatButton(
                              onPressed: () {
                                //forgot password screen
                              },
                              child: Text(
                                'Forgot Password',
                                style: TextStyle(
                                    color: Color.fromRGBO(143, 148, 251, .8)),
                              ),
                            ),
                            Container(
                              height: 50,
                              width: 300,
                              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                              child: RaisedButton(
                                color: Colors.purple[280],
                                child: Text(
                                  'Login',
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Color.fromRGBO(143, 148, 251, .8)),
                                ),
                                onPressed: () async {
                                  if (_formKey.currentState.validate()) {
                                    bool connection =
                                        await Connection().checkConnection();
                                    if (connection) {
                                      setState(() => loading = true);
                                      SharedPreferences _login =
                                          await SharedPreferences.getInstance();

                                      var establishmentLogin =
                                          await _auth.login(
                                              establishmentId: establishmentId,
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

                                        await Navigator.popAndPushNamed(
                                            context, "/");
                                        // setState(() => loading = false);
                                      } else {
                                        setState(() {
                                          loading = false;
                                          error = establishmentLogin['message'];
                                        });
                                      }
                                    } else {
                                      Toast.show(
                                          "No Internet Connection", context,
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
                                  'Does not have account?',
                                  style: TextStyle(
                                      color: Color.fromRGBO(143, 148, 251, .8)),
                                ),
                                FlatButton(
                                  textColor: Colors.blue,
                                  child: Text(
                                    'Signup',
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
                      ))
                ]),
              ),
            ),
          );
  }
}
