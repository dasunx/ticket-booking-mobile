import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ticket_booking_client/HomeScreen.dart';
import 'package:ticket_booking_client/class/SharedPref.dart';
import 'package:ticket_booking_client/class/User.dart';
import 'package:ticket_booking_client/components/CustomSnackBar.dart';
import 'package:ticket_booking_client/components/ModalProgressHud.dart';
import 'package:ticket_booking_client/screens/auth/register_screen.dart';
import 'package:http/http.dart' as http;

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  SharedPref sharedPref = SharedPref();
  String email;
  String password;
  bool isLoading = false;
  bool _emailValidator = false;
  String emailError;
  bool _passWordValidator = false;
  String passwordError;
  String url = 'https://urbanticket.herokuapp.com/api/auth/login';
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  Future<User> login(email, password, BuildContext context) async {
    try {
      if (password.length < 8) {
        setState(() {
          passwordError = 'minimum password length is 8';
          _passWordValidator = true;
          isLoading = false;
        });
      } else if (RegExp(
              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
          .hasMatch(email)) {
        final http.Response response = await http.post(url,
            headers: <String, String>{
              'Content-Type': 'application/json',
            },
            body: jsonEncode(
                <String, String>{"email": email, 'password': password}));
        setState(() {
          _passWordValidator = false;
          _emailValidator = false;
          isLoading = false;
        });
        if (response.statusCode == 200) {
          User newUser = User.userFromJson(jsonDecode(response.body));
          sharedPref.save("user", response.body);
          Scaffold.of(context).showSnackBar(
              customSnackBar(context, "Sign in as ${newUser.name}"));
          Navigator.pushNamedAndRemoveUntil(
              context, HomeScreen.id, (Route<dynamic> route) => false,
              arguments: newUser);
        } else {
          Scaffold.of(context).showSnackBar(customSnackBar(
              context, "Failed to sign in, check your credentials"));
        }
      } else {
        setState(() {
          emailError = "Please enter a valid email";
          _emailValidator = true;
          isLoading = false;
        });
      }
    } catch (e) {
      Scaffold.of(context).showSnackBar(
          customSnackBar(context, "Failed to sign in, check your credentials"));
      print(e);
      setState(() {
        isLoading = false;
      });
    }
  }

  loadSharedPrefs() async {
    try {
      User user = User.userFromJson(jsonDecode(await sharedPref.read("user")));
      print(user.name);
      if (user != null) {
        Navigator.pop(context);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => HomeScreen(
                      user: user,
                    )));
      }
    } catch (Exception) {
      print(Exception);
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

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        key: _scaffoldKey,
        resizeToAvoidBottomPadding: false,
        body: Builder(
          builder: (BuildContext context) {
            return ModalProgressHUD(
              inAsyncCall: isLoading,
              child: Container(
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
                      height: keyboardH > 0
                          ? 0
                          : (MediaQuery.of(context).size.height / 4.5) * 3,
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
                                image: AssetImage("images/Address-bro.png"),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Text(
                                "Login",
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
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(keyboardH > 0 ? 0 : 40),
                            topLeft: Radius.circular(keyboardH > 0 ? 0 : 40),
                          ),
                        ),
                        padding: EdgeInsets.only(
                            top: keyboardH > 0 ? 80 : 40, left: 30, right: 30),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Container(
                                child: Theme(
                                  data: ThemeData(),
                                  child: TextField(
                                    onTap: () {
                                      setState(() {
                                        _emailValidator = false;
                                      });
                                    },
                                    onChanged: (val) {
                                      setState(() {
                                        email = val;
                                      });
                                    },
                                    decoration: InputDecoration(
                                        errorText:
                                            _emailValidator ? emailError : null,
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
                                    obscureText: true,
                                    onTap: () {
                                      setState(() {
                                        _passWordValidator = false;
                                      });
                                    },
                                    onChanged: (value) {
                                      setState(() {
                                        password = value;
                                      });
                                    },
                                    decoration: InputDecoration(
                                        errorText: _passWordValidator
                                            ? passwordError
                                            : null,
                                        prefixIcon: Icon(Icons.remove_red_eye),
                                        border: OutlineInputBorder(),
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.grey, width: 1)),
                                        labelText: "Password",
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
                                height: 10,
                              ),
                              FlatButton(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 60, vertical: 15),
                                color: Color(0XFFFF7A2A),
                                child: Text(
                                  "Login",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                                onPressed: () async {
                                  if (email == null) {
                                    setState(() {
                                      _emailValidator = true;
                                      emailError = "Email cannot be empty";
                                    });
                                  } else if (password == null) {
                                    setState(() {
                                      _passWordValidator = true;
                                      passwordError =
                                          "Password cannot be empty";
                                    });
                                  } else {
                                    setState(() {
                                      isLoading = true;
                                    });
                                    await login(email, password, context);
                                  }
                                },
                              ),
                              // FlatButton(
                              //   padding: EdgeInsets.symmetric(
                              //       horizontal: 34, vertical: 8),
                              //   color: Colors.blue,
                              //   child: Text(
                              //     "create Local account",
                              //     style: TextStyle(color: Colors.white),
                              //   ),
                              //   onPressed: () {
                              //     Navigator.pop(context);
                              //     Navigator.push(
                              //         context,
                              //         MaterialPageRoute(
                              //             builder: (context) => RegisterScreen(
                              //                   type: 'Local',
                              //                 )));
                              //   },
                              // ),
                              // FlatButton(
                              //   padding: EdgeInsets.symmetric(
                              //       horizontal: 20, vertical: 8),
                              //   color: Colors.blue,
                              //   child: Text(
                              //     "create Foreigner account",
                              //     style: TextStyle(color: Colors.white),
                              //   ),
                              //   onPressed: () {
                              //     Navigator.pop(context);
                              //     Navigator.push(
                              //         context,
                              //         MaterialPageRoute(
                              //             builder: (context) => RegisterScreen(
                              //                   type: 'Foreigner',
                              //                 )));
                              //   },
                              // )
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
