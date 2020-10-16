import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ticket_booking_client/class/DarkThemeProvider.dart';
import 'package:ticket_booking_client/class/User.dart';
import 'package:ticket_booking_client/class/UserDetails.dart';
import 'package:ticket_booking_client/components/CustomDrawer.dart';
import 'package:ticket_booking_client/components/ModalProgressHud.dart';
import 'package:ticket_booking_client/components/slider.dart';
import 'package:ticket_booking_client/screens/payment/make_payment.dart';
import 'package:ticket_booking_client/screens/payment/payment_history.dart';
import 'package:ticket_booking_client/screens/qrcode/qrcode.dart';
import 'package:http/http.dart' as http;
import 'package:ticket_booking_client/screens/travel/travel_history.dart';

class HomeScreen extends StatefulWidget {
  static const String id = "Home_screen";
  final User user;

  const HomeScreen({Key key, this.user}) : super(key: key);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String greetingMessage = "Welcome";
  PanelController _pc = new PanelController();
  UserDetails userDetails;
  Color color1 = Color(0xff87db89);
  Color color2 = Color(0XFF93e4f8);
  String imageName = 'morning.png';
  String url = "https://urbanticket.herokuapp.com/api/auth/me/";
  String subGreeting = 'Have a nice day';
  bool isLoaded = false;
  DateTime time = DateTime.now();
  Timer timer;
  loadUserDetails() async {
    final http.Response response =
        await http.get(url + widget.user.userId, headers: <String, String>{
      'Content-Type': 'application/json',
    });
    if (response.statusCode == 200) {
      // print(jsonDecode(response.body)['journeyHistory']);
      userDetails = await userDetailsFromJson(jsonDecode(response.body));
      print(userDetails.travelHistory.length);
    }
    setState(() {
      isLoaded = true;
    });
  }

  setMessages() {
    print(time.hour);
    if (time.hour >= 6 && time.hour <= 10) {
      setState(() {
        imageName = "morning.png";
        color1 = Color(0xffa8e180);
        color2 = Color(0xff96efef);
        subGreeting = "Hope you have an amazing day";
      });
    } else if (time.hour >= 11 && time.hour <= 14) {
      setState(() {
        color2 = Color(0xff73cc8d);
        color1 = Color(0xff88e1f5);
        imageName = 'noon.png';
        subGreeting = "Have a safe and smooth journey";
      });
    } else if (time.hour >= 15 && time.hour <= 18) {
      setState(() {
        color2 = Color(0xff73cc8d);
        color1 = Color(0xff88e1f5);
        imageName = "evening.png";
        subGreeting = "Wishing you a safe journey!";
      });
    } else if (time.hour >= 19 && time.hour <= 20) {
      setState(() {
        color1 = Color(0xffa6a3dd);
        color2 = Color(0xff3e709f);
        imageName = 'earlienight.png';
        subGreeting = "Busy Streets, be safe!";
      });
    } else if ((time.hour >= 21 && time.hour <= 24) ||
        (time.hour >= 0 && time.hour <= 2)) {
      setState(() {
        color2 = Color(0xff182f4a);
        color1 = Color(0xff345c75);
        imageName = 'midnight.png';
        subGreeting = "It's midnight, Safe travel!";
      });
    } else {
      setState(() {
        color2 = Color(0xff8cabdd);
        color1 = Color(0xff345c75);
        imageName = 'earliemorning.png';
        subGreeting = "It's new day! start fresh";
      });
    }
    if (time.hour > 12) {
      setState(() {
        greetingMessage = "Good evening";
      });
    } else if (time.hour < 12) {
      print("h");
      setState(() {
        greetingMessage = "Good Morning";
      });
    }
  }

  @override
  void initState() {
    loadUserDetails();
    // timer =
    //     Timer.periodic(Duration(seconds: 5), (Timer t) => loadUserDetails());
    setMessages();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    BorderRadiusGeometry radius = BorderRadius.only(
      topLeft: Radius.circular(14.0),
      topRight: Radius.circular(14.0),
    );
    return Scaffold(
      appBar: AppBar(
        title: Text('Travel app home'),
      ),
      body: SlidingUpPanel(
        onPanelOpened: () async {
          await loadUserDetails();
        },
        // onPanelSlide: (t) async {
        //   await loadUserDetails();
        // },
        onPanelClosed: () async {
          await loadUserDetails();
        },
        maxHeight: (height - 200),
        minHeight: 100,
        controller: _pc,
        panel: Center(
          child: QrCode(
            user: widget.user,
          ),
        ),
        collapsed: Container(
          decoration: BoxDecoration(
              color: themeChange.darkTheme ? Color(0XFF1E453E) : Colors.white,
              borderRadius: radius),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(20),
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: themeChange.darkTheme ? Colors.white : Colors.black,
                  borderRadius: new BorderRadius.only(
                    topLeft: const Radius.circular(40.0),
                    topRight: const Radius.circular(40.0),
                    bottomRight: const Radius.circular(40.0),
                    bottomLeft: const Radius.circular(40.0),
                  ),
                ),
                height: 7,
                width: 50,
              ),
              Center(
                child: Text(
                  "Swipe up to view qr code",
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
        body: GestureDetector(
          onTap: () => _pc.close(),
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Card(
                  color: themeChange.darkTheme ? Colors.black : Colors.white,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: new BorderRadius.only(
                        topLeft: const Radius.circular(20.0),
                        topRight: const Radius.circular(12.0),
                        bottomRight: const Radius.circular(12.0),
                        bottomLeft: const Radius.circular(20.0),
                      ),
                      gradient: new LinearGradient(
                        colors: [
                          color1,
                          color2,
                        ],
                        begin: const FractionalOffset(0.0, 0.0),
                        end: const FractionalOffset(1.0, 0.0),
                        stops: [0.0, 1.0],
                        tileMode: TileMode.clamp,
                      ),
                    ),
                    height: (height / 4),
                    padding: EdgeInsets.only(left: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: (width / 3) * 2,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "$greetingMessage,",
                                style: TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold,
                                    color: imageName == "midnight.png"
                                        ? Colors.white
                                        : themeChange.darkTheme
                                            ? Colors.white
                                            : Colors.black),
                              ),
                              Text(
                                "${widget.user.name.split(" ")[0]}",
                                style: TextStyle(
                                    fontSize: 28,
                                    color: imageName == "midnight.png"
                                        ? Colors.white
                                        : themeChange.darkTheme
                                            ? Colors.white
                                            : Colors.black),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Flexible(
                                child: Text(
                                  subGreeting,
                                  style: TextStyle(
                                      fontSize: 24,
                                      color: imageName == "midnight.png"
                                          ? Colors.white
                                          : themeChange.darkTheme
                                              ? Colors.white
                                              : Colors.black),
                                  textAlign: TextAlign.center,
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          width: (width / 3.5),
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('images/$imageName'),
                                  fit: BoxFit.cover,
                                  alignment: Alignment.centerLeft)),
                        )
                      ],
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, MakePayment.id,
                            arguments: widget.user);
                      },
                      child: Container(
                        width: width / 2,
                        height: height / 4,
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: Center(
                                    child: Text(
                                      'Account balance',
                                      style: TextStyle(fontSize: 20),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    !isLoaded
                                        ? "loading"
                                        : "LKR ${userDetails.balance.toString()}",
                                    style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold,
                                        color: isLoaded
                                            ? userDetails.balance == 0
                                                ? Colors.red
                                                : Colors.white
                                            : Colors.white),
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Container(
                                    width: width,
                                    color: color2,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.add,
                                            size: 40,
                                            color: imageName == "midnight.png"
                                                ? Colors.white
                                                : themeChange.darkTheme
                                                    ? Colors.white
                                                    : Colors.black),
                                        Text(
                                          " TOP UP",
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: imageName == "midnight.png"
                                                  ? Colors.white
                                                  : themeChange.darkTheme
                                                      ? Colors.white
                                                      : Colors.black),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: width / 2,
                      height: height / 4,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(context, PaymentHistory.id,
                                    arguments: widget.user);
                              },
                              child: Card(
                                child: Container(
                                  decoration: BoxDecoration(
                                    gradient: new LinearGradient(
                                        colors: [
                                          Color(0xff87db89),
                                          Colors.blueAccent
                                        ],
                                        begin: FractionalOffset(0.0, 1.0),
                                        end: FractionalOffset(1.0, 0.0)),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        height: height / 7,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image:
                                                AssetImage('images/bill.png'),
                                            fit: BoxFit.contain,
                                            alignment: Alignment.center,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        'payments',
                                        style: TextStyle(fontSize: 20),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        await loadUserDetails();
                      },
                      child: Container(
                        width: width / 2,
                        height: height / 4,
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 10.0, left: 10, right: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Text(
                                    isLoaded
                                        ? userDetails.onGoingJourney != null
                                            ? 'Current Journey'
                                            : 'No current journey'
                                        : 'loading',
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: isLoaded
                                      ? userDetails.onGoingJourney != null
                                          ? Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "From",
                                                  style:
                                                      TextStyle(fontSize: 18),
                                                ),
                                                Text(
                                                  "${userDetails.onGoingJourney.startingPlace.toUpperCase()}",
                                                  style:
                                                      TextStyle(fontSize: 22),
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                  "Via",
                                                  style:
                                                      TextStyle(fontSize: 18),
                                                ),
                                                Text(
                                                  "${userDetails.onGoingJourney.busId.substring(0, 2)}-${userDetails.onGoingJourney.busId.substring(2, 6)}",
                                                  style:
                                                      TextStyle(fontSize: 24),
                                                ),
                                              ],
                                            )
                                          : Column(
                                              children: [
                                                Container(
                                                    height: height / 8,
                                                    decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                        image: AssetImage(
                                                            'images/no-journey.png'),
                                                        fit: BoxFit.contain,
                                                        alignment:
                                                            Alignment.center,
                                                      ),
                                                    )),
                                              ],
                                            )
                                      : Center(
                                          child: CircularProgressIndicator()),
                                ),
                                Expanded(
                                  child: isLoaded
                                      ? userDetails.onGoingJourney != null
                                          ? getTimeDifferent(userDetails
                                              .onGoingJourney.startTime)
                                          : Text('')
                                      : Text(''),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: width / 2,
                      height: height / 4,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, TravelHistory.id,
                              arguments: userDetails);
                        },
                        child: Card(
                          child: Container(
                            decoration: BoxDecoration(
                                gradient: new LinearGradient(
                                    colors: [color2, Colors.blueAccent],
                                    begin: FractionalOffset(0.0, 0.0),
                                    end: FractionalOffset(1.0, 1.0))),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  height: height / 7,
                                  width: width,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage('images/bus.png'),
                                      fit: BoxFit.contain,
                                      alignment: Alignment.center,
                                    ),
                                  ),
                                ),
                                Text(
                                  'Journeys',
                                  style: TextStyle(fontSize: 20),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        borderRadius: radius,
      ),
      drawer: CustomDrawer(
        id: HomeScreen.id,
        user: widget.user,
        userDetails: userDetails,
      ),
    );
  }

  Chip getTimeDifferent(DateTime usertime) {
    var stHour = usertime.toLocal().hour;
    var stMin = usertime.toLocal().minute;
    var stinmins = (stHour * 60) + stMin;
    var thisHour = DateTime.now().hour;
    var thisMin = DateTime.now().minute;
    var thisInMins = (thisHour * 60) + thisMin;
    var gap = thisInMins - stinmins;
    var gapHour = gap ~/ 60;
    var gapMin = gap % 60;
    String msg;
    if (gapHour <= 0) {
      if (gapMin == 0)
        msg = 'just now';
      else if (gapMin == 1)
        msg = ' $gapMin min ago';
      else
        msg = '$gapMin mins ago';
    } else if (gapHour == 1) {
      if (gapMin == 0)
        msg = '1 hour ago';
      else if (gapMin == 1)
        msg = '1 hour $gapMin min ago';
      else
        msg = '1 hour $gapMin mins ago';
    } else {
      if (gapMin == 0)
        msg = '$gapHour hours ago';
      else if (gapMin == 1)
        msg = '$gapHour hours $gapMin min ago';
      else
        msg = '$gapHour hours $gapMin mins ago';
    }
    return Chip(
      label: Text(msg),
      backgroundColor: color2,
    );
  }
}
