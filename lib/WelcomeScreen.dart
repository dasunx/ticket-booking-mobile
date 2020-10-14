import 'package:flutter/material.dart';
import 'package:ticket_booking_client/HomeScreen.dart';
import 'package:ticket_booking_client/class/SharedPref.dart';
import 'package:ticket_booking_client/class/User.dart';
import 'package:ticket_booking_client/components/CustomDrawer.dart';
import 'package:ticket_booking_client/screens/auth/login_screen.dart';
import 'package:ticket_booking_client/screens/auth/register_screen.dart';

class WelcomeScreen extends StatefulWidget {
  static const String id = 'welcome_screen';
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FlatButton(
              onPressed: () {
                Navigator.pushNamed(context, LoginScreen.id);
              },
              child: Text("Login"),
            ),
            FlatButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => RegisterScreen(
                              type: 'Local',
                            )));
              },
              child: Text("Register local account"),
            ),
            FlatButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => RegisterScreen(
                              type: 'Foreigner',
                            )));
              },
              child: Text("Register Foreign account"),
            ),
          ],
        ),
      ),
    );
  }
}
