import 'dart:async';
import 'dart:convert';
import 'dart:ui';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'package:jalshakti/classes/Constants.dart';
import 'package:jalshakti/custom-widgets/admin_login/rounded_password_field.dart';
import 'package:jalshakti/screens/jal_shakti_home.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:jalshakti/custom-widgets/admin_login/rounded_button.dart';
import 'package:jalshakti/custom-widgets/admin_login/rounded_input_field.dart';

class AdminLoginModal extends StatefulWidget {
  @override
  _AdminLoginModalState createState() => _AdminLoginModalState();
}

class _AdminLoginModalState extends State<AdminLoginModal> {
  @override
  Widget build(BuildContext context) {
    return SlidingUpPanel(
      backdropEnabled: true,
      backdropColor: Colors.blue,
      minHeight: 40,
      maxHeight: MediaQuery.of(context).size.height * 0.9,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
      //margin: EdgeInsets.only(left: 10, right: 10),
      collapsed: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Align(
          alignment: Alignment.topCenter,
          child: Text(
            "Login",
            style: TextStyle(
                decoration: TextDecoration.none,
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xff484848)),
          ),
        ),
      ),
      panel: LoginLayout(),
    );
  }
}

class LoginLayout extends StatefulWidget {
  const LoginLayout({
    Key key,
  }) : super(key: key);

  @override
  _LoginLayoutState createState() => _LoginLayoutState();
}

class _LoginLayoutState extends State<LoginLayout> {
  String _username = "";
  String user = "";
  String _password = "";
  final String url = SERVER_URL;
  SnackBar _snackBar;
  bool indicatorVisible = false;

  Future<bool> _loginUserWithCredentials(username, password) async {
    bool valid = validateCredentials(username, password);
    bool flag = false;
    if (valid) {
      //send to server
      var data = {'username': username, 'password': password};
      try {
        var response = await http.post(SERVER_URL + '/api/admin/login',
            headers: <String, String>{
              'Content-Type': 'application/json;charset=UTF-8'
            },
            body: jsonEncode(data));

        if (response.statusCode == 200) {
          var jsonResponse = jsonDecode(response.body);
          print(jsonResponse['message']);
          _snackBar = SnackBar(content: Text(jsonResponse['message']));
          if (jsonResponse['status'] == 1) {
            flag = true;
            //user = jsonResponse['full-name'];
            var prefs = await SharedPreferences.getInstance();
            prefs.setString('user', jsonResponse['full-name']);
            prefs.setString('state', jsonResponse['state']);
            prefs.setString('district', jsonResponse['district']);
          }
        } else {
          _snackBar = SnackBar(content: Text("Some error occured.."));
        }
      } on TimeoutException catch (err) {
        print("TimeOut...");
        _snackBar = SnackBar(content: Text("Timed out trying to login..."));
      } on SocketException catch (err) {
        print("SocketException.....");
        print(err.osError.message);
        _snackBar = SnackBar(content: Text(err.osError.message));
      } on Error catch (err) {
        print(err.toString());
        _snackBar = SnackBar(content: Text("Some error occured..."));
      }
    } else {
      _snackBar = SnackBar(content: Text("Please enter correct login details"));
    }
    setState(() {
      indicatorVisible = !indicatorVisible;
    });
    return flag;
  }

  bool validateCredentials(username, password) {
    if (username.length < 3 || password.length < 3) return false;
    debugPrint("Validated credentials...\n");
    return true;
  }

  void setLoginStatus() async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLoggedIn', true);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: size.height * 0.06,
          ),
          Text(
            "LOGIN",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
          ),
          SizedBox(
            height: size.height * 0.03,
          ),
          RoundedInputField(
              hintText: "Your email",
              onChanged: (value) {
                _username = value;
              }),
          RoundedPasswordField(
            onChanged: (value) {
              _password = value;
            },
          ),
          Visibility(
            visible: !indicatorVisible,
            child: RoundedButton(
                text: 'LOGIN',
                press: () async {
                  setState(() {
                    indicatorVisible = !indicatorVisible;
                  });
                  print("Credentials are : " + _username + "|" + _password);
                  bool login =
                      await _loginUserWithCredentials(_username, _password);

                  Scaffold.of(context).showSnackBar(_snackBar);
                  if (login) {
                    setLoginStatus();
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return JalShaktiHome(user: "admin");
                        },
                      ),
                    );
                  }
                }),
          ),
          SizedBox(height: size.height * 0.03),
          Visibility(
              visible: indicatorVisible, child: CircularProgressIndicator())
        ],
      ),
    );
  }
}
