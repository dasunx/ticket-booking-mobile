import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ticket_booking_client/class/DarkThemeProvider.dart';
import 'package:ticket_booking_client/components/CustomDrawer.dart';

class HomeScreen extends StatefulWidget {
  static const String id = "Home_screen";
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Travel app home'),
      ),
      body: Center(
        child: Text("hi"),
      ),
      drawer: CustomDrawer(
        id: HomeScreen.id,
      ),
    );
  }
}
