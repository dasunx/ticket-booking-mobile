import 'package:flutter/material.dart';
import 'package:ticket_booking_client/components/CustomDrawer.dart';

class WelcomeScreen extends StatefulWidget {
  static const String id = 'welcome_screen';
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Travel card'),
      ),
      body: Center(
        child: Text("Hi"),
      ),
      drawer: CustomDrawer(
        id: WelcomeScreen.id,
      ),
    );
  }
}
