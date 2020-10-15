import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ticket_booking_client/HomeScreen.dart';
import 'package:ticket_booking_client/WelcomeScreen.dart';
import 'package:ticket_booking_client/class/DarkThemeProvider.dart';
import 'package:ticket_booking_client/class/SharedPref.dart';
import 'package:ticket_booking_client/class/User.dart';
import 'package:ticket_booking_client/class/UserDetails.dart';
import 'package:ticket_booking_client/screens/auth/login_screen.dart';

import 'package:ticket_booking_client/screens/payment/make_payment.dart';
import 'package:ticket_booking_client/screens/payment/payment_history.dart';
import 'package:ticket_booking_client/screens/qrcode/qrcode.dart';
import 'package:ticket_booking_client/screens/travel/travel_history.dart';

class CustomDrawer extends StatefulWidget {
  final String id;
  final User user;
  final UserDetails userDetails;

  const CustomDrawer({Key key, this.id, this.user, this.userDetails})
      : super(key: key);
  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  SharedPref sharedPref = SharedPref();
  User user;

  loadUser() async {
    var userJson = await sharedPref.read("user");
    if (userJson == null) {
      Navigator.pushReplacementNamed(context, LoginScreen.id);
    } else {
      setState(() {
        user = User.userFromJson(jsonDecode(userJson));
      });
    }
  }

  @override
  void initState() {
    user = widget.user;
    //loadUser();
    super.initState();
  }

  void makeRoutes(BuildContext context, String changeId) {
    Navigator.pop(context);
    if (widget.id != changeId) {
      if (widget.id == HomeScreen.id) {
        Navigator.pushNamed(context, changeId);
      } else {
        Navigator.popAndPushNamed(context, changeId);
      }
    } else {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);
    return Theme(
      data: Theme.of(context).copyWith(
          canvasColor:
              themeChange.darkTheme ? Color(0xff0E1D36) : Colors.white),
      child: Drawer(
        child: Column(
          children: [
            Expanded(
              flex: 12,
              child: ListView(
                //remove all padding from listview
                padding: const EdgeInsets.all(0.0),
                children: [
                  UserAccountsDrawerHeader(
                    margin: EdgeInsets.only(
                      bottom: 20.0,
                    ),
                    accountName: Text(
                      user != null ? user.name : '',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    accountEmail: Text(
                      user != null ? user.email : '',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                      ),
                    ),
                    currentAccountPicture: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Text(
                        user != null ? user.name[0] : 'D',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 40.0,
                        ),
                      ),
                    ),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                            'https://image.freepik.com/free-vector/abstract-wallpaper-concept_23-2148479714.jpg'),
                        fit: BoxFit.fitWidth,
                      ),
                      color: Colors.white,
                    ),
                  ),
                  DrawerListTile(
                    icon: Icons.card_travel,
                    onPress: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, QrCode.id, arguments: user);
                    },
                    title: "my qr",
                  ),
                  DrawerListTile(
                    icon: Icons.add_box,
                    onPress: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, MakePayment.id,
                          arguments: user);
                    },
                    title: "Top up",
                  ),
                  DrawerListTile(
                    icon: Icons.directions_bus,
                    onPress: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, TravelHistory.id,
                          arguments: widget.userDetails);
                    },
                    title: "Travel History",
                  ),
                  DrawerListTile(
                    icon: Icons.history,
                    onPress: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, PaymentHistory.id,
                          arguments: user);
                    },
                    title: "Payment History",
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: ListTile(
                leading: Icon(
                  themeChange.darkTheme
                      ? Icons.brightness_high
                      : Icons.brightness_3,
                  size: 30.0,
                ),
                title: Row(
                  children: [
                    Text("Dark Theme"),
                    Spacer(),
                    CupertinoSwitch(
                      value: themeChange.darkTheme,
                      onChanged: (value) {
                        themeChange.darkTheme = value;
                      },
                    ),
                  ],
                ),
                onTap: () {
                  themeChange.darkTheme = !themeChange.darkTheme;
                },
              ),
            ),
            Expanded(
              flex: 1,
              child: ListTile(
                leading: Icon(
                  Icons.exit_to_app,
                  size: 30.0,
                ),
                title: Text("Sign Out"),
                onTap: () async {
                  await sharedPref.remove("user");
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    LoginScreen.id,
                    (Route<dynamic> route) => false,
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  final IconData icon;
  final Function onPress;
  final String title;

  const DrawerListTile({Key key, this.icon, this.onPress, this.title});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        icon,
        color: Colors.red,
        size: 36.0,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 16.0,
        ),
      ),
      onTap: onPress,
    );
  }
}
