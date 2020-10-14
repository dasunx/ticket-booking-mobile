import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ticket_booking_client/HomeScreen.dart';
import 'package:ticket_booking_client/WelcomeScreen.dart';
import 'package:ticket_booking_client/class/SharedPref.dart';
import 'package:ticket_booking_client/class/User.dart';

class LoadingScreen extends StatefulWidget {
  static const String id = "loading_screen";
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  SharedPref sharedPref = SharedPref();
  User user;

  loadUser() async {
    var tempUser = await sharedPref.read("user");
    if (tempUser != null) {
      user = User.userFromJson(jsonDecode(tempUser));
      Navigator.popAndPushNamed(context, HomeScreen.id, arguments: user);
    } else {
      Navigator.pushNamed(context, WelcomeScreen.id);
    }
  }

  @override
  void initState() {
    loadUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
              image: AssetImage('images/logo.png'),
            ),
            Text(
              "Urban Travel",
              style: TextStyle(fontSize: 38, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
