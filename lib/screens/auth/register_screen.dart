import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ticket_booking_client/HomeScreen.dart';
import 'package:ticket_booking_client/class/SharedPref.dart';
import 'package:ticket_booking_client/class/User.dart';
import 'package:ticket_booking_client/components/CustomDrawer.dart';
import 'package:ticket_booking_client/components/CustomSnackBar.dart';
import 'package:ticket_booking_client/components/ModalProgressHud.dart';
import 'package:ticket_booking_client/functions/validators.dart';
import 'package:ticket_booking_client/screens/auth/login_screen.dart';
import 'package:http/http.dart' as http;

class RegisterScreen extends StatefulWidget {
  static const String id = 'register_screen';
  final String type;

  const RegisterScreen({Key key, this.type}) : super(key: key);
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  FocusNode fn = FocusNode();
  SharedPref sharedPref = SharedPref();
  String name;
  String mail;
  String password;
  String conPassword;
  String nic;
  String passportId;
  bool isLoading = false;
  String _errorName;
  String _errormail;
  String _errorpassword;
  String _errorconPassword;
  String _errornic;
  String _errorpassportId;
  bool _name = false;
  bool _mail = false;
  bool _password = false;
  bool _conPassword = false;
  bool _nic = false;
  bool _passportId = false;
  String url = 'http://192.168.8.103:8000/api/auth/signup';
  loadSharedPrefs() async {
    try {
      User user = User.userFromJson(jsonDecode(await sharedPref.read("user")));
      print(user.name);
      if (user != null) {
        Navigator.pushReplacementNamed(context, HomeScreen.id, arguments: user);
      }
    } catch (Exception) {
      print(Exception);
    }
  }

  setErrorsFalse() {
    setState(() {
      _name = false;
      _mail = false;
      _password = false;
      _nic = false;
      _conPassword = false;
      _passportId = false;
    });
  }

  registerLocal(BuildContext context) async {
    if (!checkEmpty(name)) {
      setState(() {
        _name = true;
        _errorName = 'Name cannot be empty';
      });
    } else if (!validateEmail(mail)) {
      setState(() {
        _mail = true;
        _errormail = 'Please enter valid email';
      });
    } else if (!checkPass(password)) {
      setState(() {
        _password = true;
        _errorpassword = 'Minimum password lenght is 8';
      });
    } else if (!confirmPass(password, conPassword)) {
      setState(() {
        _conPassword = true;
        _errorconPassword = 'Passwords does not match';
      });
    } else if (!checkEmpty(nic)) {
      setState(() {
        _nic = true;
        _errornic = 'NIC number cannot be empty';
      });
    } else {
      final http.Response response = await http.post(url,
          headers: <String, String>{
            'Content-Type': 'application/json',
          },
          body: jsonEncode(<String, dynamic>{
            "name": name,
            "email": mail,
            'password': password,
            "native": true,
            "nic": nic
          }));
      if (response.statusCode == 200) {
        User newUser = User.userFromJson(jsonDecode(response.body));
        sharedPref.save("user", response.body);
        Scaffold.of(context).showSnackBar(
            customSnackBar(context, "Sign up as ${newUser.name}"));
        Navigator.pushReplacementNamed(context, HomeScreen.id,
            arguments: newUser);
      } else {
        Scaffold.of(context).showSnackBar(customSnackBar(
            context, "Failed to sign up, check your credentials"));
      }
    }
  }

  @override
  void initState() {
    super.initState();
    loadSharedPrefs();
  }

  @override
  Widget build(BuildContext context) {
    double keyboardH = MediaQuery.of(context).viewInsets.bottom;
    String type = ModalRoute.of(context).settings.arguments;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomPadding: false,
        body: Builder(builder: (BuildContext context) {
          return Container(
            decoration: BoxDecoration(
              gradient: new LinearGradient(
                colors: [
                  const Color(0xFF3366FF),
                  const Color(0xFF00CCFF),
                ],
                begin: const FractionalOffset(0.0, 0.0),
                end: const FractionalOffset(1.0, 0.0),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp,
              ),
            ),
            child: Column(
              children: [
                AnimatedContainer(
                  alignment: Alignment.center,
                  height: keyboardH > 0 ? 0 : 300,
                  duration: Duration(milliseconds: 600),
                  curve: Curves.fastOutSlowIn,
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 6,
                          child: Image(
                            image: AssetImage("images/reg_image.png"),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            "REGISTER - ${(widget.type).toUpperCase()}",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 30,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: ModalProgressHUD(
                    inAsyncCall: isLoading,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(keyboardH > 0 ? 0 : 30),
                          topLeft: Radius.circular(keyboardH > 0 ? 0 : 30),
                        ),
                      ),
                      padding: EdgeInsets.only(top: 40, left: 30, right: 30),
                      child: Column(
                        children: [
                          Container(
                            child: Theme(
                              data: ThemeData(),
                              child: TextField(
                                onTap: () {
                                  setErrorsFalse();
                                },
                                onChanged: (val) {
                                  name = val;
                                },
                                decoration: InputDecoration(
                                    errorText: _name ? _errorName : null,
                                    prefixIcon: Icon(Icons.person),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.grey, width: 1)),
                                    border: OutlineInputBorder(),
                                    labelText: "Name",
                                    hintStyle: TextStyle(
                                      color: Colors.grey[400],
                                    )),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            child: Theme(
                              data: ThemeData(),
                              child: TextField(
                                onTap: () {
                                  setErrorsFalse();
                                },
                                onChanged: (val) {
                                  mail = val;
                                },
                                decoration: InputDecoration(
                                    errorText: _mail ? _errormail : null,
                                    prefixIcon: Icon(Icons.person),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.grey, width: 1)),
                                    border: OutlineInputBorder(),
                                    labelText: "Email",
                                    hintStyle: TextStyle(
                                      color: Colors.grey[400],
                                    )),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            child: Theme(
                              data: ThemeData(),
                              child: TextField(
                                onTap: () {
                                  setErrorsFalse();
                                },
                                onChanged: (val) {
                                  password = val;
                                },
                                obscureText: true,
                                decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.remove_red_eye),
                                    border: OutlineInputBorder(),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.grey, width: 1)),
                                    labelText: "Password",
                                    errorText:
                                        _password ? _errorpassword : null,
                                    errorBorder: OutlineInputBorder().copyWith(
                                        borderSide:
                                            BorderSide(color: Colors.red)),
                                    hintStyle: TextStyle(
                                      color: Colors.grey[400],
                                    )),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            child: Theme(
                              data: ThemeData(),
                              child: TextField(
                                obscureText: true,
                                onTap: () {
                                  setErrorsFalse();
                                },
                                onChanged: (val) {
                                  conPassword = val;
                                },
                                decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.remove_red_eye),
                                    errorText:
                                        _conPassword ? _errorconPassword : null,
                                    border: OutlineInputBorder(),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.grey, width: 1)),
                                    labelText: "Password confirm",
                                    // errorText:
                                    // emailValidation ? "Add Valid Email" : null,
                                    errorBorder: OutlineInputBorder().copyWith(
                                        borderSide:
                                            BorderSide(color: Colors.red)),
                                    hintStyle: TextStyle(
                                      color: Colors.grey[400],
                                    )),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            child: Theme(
                              data: ThemeData(),
                              child: widget.type == "Local"
                                  ? TextField(
                                      onTap: () {
                                        setErrorsFalse();
                                      },
                                      onChanged: (val) {
                                        nic = val;
                                      },
                                      decoration: InputDecoration(
                                          errorText: _nic ? _errornic : null,
                                          prefixIcon: Icon(
                                            Icons.format_indent_decrease,
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.grey,
                                                  width: 1)),
                                          border: OutlineInputBorder(),
                                          labelText: "NIC",

                                          // errorText:
                                          // emailValidation ? "Add Valid Email" : null,
                                          errorBorder: OutlineInputBorder()
                                              .copyWith(
                                                  borderSide: BorderSide(
                                                      color: Colors.red)),
                                          hintStyle: TextStyle(
                                            color: Colors.grey[400],
                                          )),
                                    )
                                  : TextField(
                                      onTap: () {
                                        setErrorsFalse();
                                      },
                                      onChanged: (val) {
                                        passportId = val;
                                      },
                                      decoration: InputDecoration(
                                          errorText: _passportId
                                              ? _errorpassportId
                                              : null,
                                          prefixIcon: Icon(
                                            Icons.format_indent_decrease,
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.grey,
                                                  width: 1)),
                                          border: OutlineInputBorder(),
                                          labelText: "Passport Id",

                                          // errorText:
                                          // emailValidation ? "Add Valid Email" : null,
                                          errorBorder: OutlineInputBorder()
                                              .copyWith(
                                                  borderSide: BorderSide(
                                                      color: Colors.red)),
                                          hintStyle: TextStyle(
                                            color: Colors.grey[400],
                                          )),
                                    ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          FlatButton(
                            padding: EdgeInsets.symmetric(
                                horizontal: 30, vertical: 15),
                            color: Color(0XFFFF7A2A),
                            child: Text(
                              "Register",
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () async {
                              if (widget.type == "Local") {
                                registerLocal(context);
                              } else {}
                              print('Register btn pressed');
                            },
                          ),
                          FlatButton(
                            child: Text(
                              "Have an account?",
                              style: TextStyle(color: Colors.black),
                            ),
                            onPressed: () {
                              Navigator.popAndPushNamed(
                                  context, LoginScreen.id);
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        }),
      ),
    );
  }
}
