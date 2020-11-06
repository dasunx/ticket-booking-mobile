import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:ticket_booking_client/class/DarkThemeProvider.dart';
import 'package:ticket_booking_client/class/Fine.dart';
import 'package:ticket_booking_client/class/SharedPref.dart';
import 'package:ticket_booking_client/class/User.dart';
import 'package:ticket_booking_client/class/UserDetails.dart';
import 'package:http/http.dart' as http;
import 'package:ticket_booking_client/components/DottedLine.dart';
import 'package:ticket_booking_client/components/TicketAroundClipper.dart';

class FineHistory extends StatefulWidget {
  static const String id = 'fine_history';
  final UserDetails userDetails;

  const FineHistory({Key key, this.userDetails}) : super(key: key);
  @override
  _FineHistoryState createState() => _FineHistoryState();
}

class _FineHistoryState extends State<FineHistory> {
  List<Fine> items;
  String url = "https://urbanticket.herokuapp.com/api/auth/me/";
  List<Fine> paidItems;
  List<Fine> currentItems;

  bool isLoading = false;
  @override
  void initState() {
    items = widget.userDetails.fineHistory;
    paidItems = items.where((element) => element.paid == true).toList();
    currentItems = items.where((element) => element.paid == false).toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('My Fines'),
          bottom: TabBar(
            tabs: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Current'),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Paid'),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            RefreshIndicator(
              onRefresh: _getData,
              child: currentItems.length > 0
                  ? ListView.builder(
                      itemCount: currentItems.length,
                      itemBuilder: (context, index) {
                        return Container(
                          height: 285,
                          child: Card(
                            color: themeChange.darkTheme
                                ? Color(0XFF1E453E)
                                : Color(0xffCBDCF8),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: DottedLine(
                                      dashColor: Colors.white,
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Fine Amount:",
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.red),
                                      ),
                                      Text(
                                        'LKR ${currentItems[index].amount + currentItems[index].paidAmount}',
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.red),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: DottedLine(
                                      dashColor: Colors.white,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Paid amount :",
                                        style: TextStyle(fontSize: 18),
                                      ),
                                      Spacer(),
                                      Text(
                                        'LKR ${currentItems[index].paidAmount}',
                                        style: TextStyle(fontSize: 18),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Balance amount :",
                                        style: TextStyle(fontSize: 18),
                                      ),
                                      Spacer(),
                                      Text(
                                        'LKR ${currentItems[index].amount}',
                                        style: TextStyle(fontSize: 18),
                                      ),
                                    ],
                                  ),
                                  Divider(),
                                  Text(
                                    'Received',
                                    textAlign: TextAlign.left,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                          "Date : ${DateFormat.yMMMd().format(currentItems[index].date.toLocal())} "),
                                      Spacer(),
                                      Text(
                                          "By : ${currentItems[index].manager.name}")
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                          "Contact email : ${currentItems[index].manager.email} "),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Chip(
                                        backgroundColor:
                                            currentItems[index].paidAmount > 0
                                                ? Colors.black
                                                : Colors.redAccent,
                                        label: Text(
                                          currentItems[index].paidAmount > 0
                                              ? 'LKR ${currentItems[index].amount} to pay'
                                              : 'not paid yet',
                                          style: TextStyle(fontSize: 16),
                                        ),
                                      ),
                                      Spacer(),
                                      Chip(
                                        backgroundColor:
                                            currentItems[index].paidAmount > 0
                                                ? Colors.blue
                                                : Colors.redAccent,
                                        label: Text(
                                          currentItems[index].paidAmount > 0
                                              ? 'partialy completed'
                                              : 'not paid yet',
                                          style: TextStyle(fontSize: 16),
                                        ),
                                        avatar: CircleAvatar(
                                          backgroundColor: Colors.white,
                                          child: Icon(
                                            currentItems[index].paidAmount > 0
                                                ? Icons.done
                                                : Icons.close,
                                            color:
                                                currentItems[index].paidAmount >
                                                        0
                                                    ? Colors.green
                                                    : Colors.red,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    )
                  : ListView(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height / 1.5,
                          alignment: Alignment.bottomCenter,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('images/no-data.png'))),
                        ),
                        Container(
                            height: MediaQuery.of(context).size.height / 1,
                            alignment: Alignment.topCenter,
                            child: Text(
                              'No current fines',
                              style: TextStyle(fontSize: 20),
                            ))
                      ],
                    ),
            ),
            RefreshIndicator(
              onRefresh: _getData,
              child: paidItems.length > 0
                  ? ListView.builder(
                      itemCount: paidItems.length,
                      itemBuilder: (context, index) {
                        return Container(
                          height: 260,
                          child: Card(
                            color: themeChange.darkTheme
                                ? Color(0XFF1E453E)
                                : Color(0xffCBDCF8),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: DottedLine(
                                      dashColor: Colors.white,
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Fine Amount:",
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.red),
                                      ),
                                      Text(
                                        'LKR ${paidItems[index].paidAmount}',
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.red),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: DottedLine(
                                      dashColor: Colors.white,
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Full payment done",
                                        style: TextStyle(fontSize: 18),
                                      ),
                                    ],
                                  ),
                                  // Row(
                                  //   children: [
                                  //     Text(
                                  //       "Balance amount :",
                                  //       style: TextStyle(fontSize: 18),
                                  //     ),
                                  //     Spacer(),
                                  //     Text(
                                  //       'LKR ${paidItems[index].amount}',
                                  //       style: TextStyle(fontSize: 18),
                                  //     ),
                                  //   ],
                                  // ),
                                  Divider(),
                                  Text(
                                    'Fine details',
                                    textAlign: TextAlign.left,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                          "From : ${DateFormat.yMMMd().format(paidItems[index].date.toLocal())} "),
                                      Spacer(),
                                      Text(
                                          "Paid :${DateFormat.yMMMd().format(paidItems[index].paidDate.toLocal())}")
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                          "Contact email : ${paidItems[index].manager.email} "),
                                      Spacer(),
                                      Text(
                                          "By : ${paidItems[index].manager.name}")
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Chip(
                                        backgroundColor: Colors.blue,
                                        label: Text(
                                          'Paid',
                                          style: TextStyle(fontSize: 16),
                                        ),
                                        avatar: CircleAvatar(
                                          backgroundColor: Colors.white,
                                          child: Icon(
                                            Icons.done,
                                            color: Colors.green,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    )
                  : ListView(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height / 1.5,
                          alignment: Alignment.bottomCenter,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('images/no-data.png'))),
                        ),
                        Container(
                            height: MediaQuery.of(context).size.height / 1,
                            alignment: Alignment.topCenter,
                            child: Text(
                              'No paid fines',
                              style: TextStyle(fontSize: 20),
                            ))
                      ],
                    ),
            )
          ],
        ),
      ),
    );
  }

  Future<List<Fine>> loadUserDetails() async {
    SharedPref sharedPref = SharedPref();
    User user = User.userFromJson(jsonDecode(await sharedPref.read("user")));
    final http.Response response =
        await http.get(url + user.userId, headers: <String, String>{
      'Content-Type': 'application/json',
    });
    var userDetails;
    if (response.statusCode == 200) {
      // print(jsonDecode(response.body)['journeyHistory']);
      userDetails = await userDetailsFromJson(jsonDecode(response.body));
      print(userDetails.travelHistory.length);
    }
    setState(() {
      isLoading = false;
    });
    List<Fine> finehistory = userDetails.fineHistory;
    return finehistory;
  }

  Future<void> _getData() async {
    setState(() {
      isLoading = true;
    });
    List<Fine> tempItems = await loadUserDetails();
    setState(() {
      items = tempItems;
      paidItems = items.where((element) => element.paid == true).toList();
      currentItems = items.where((element) => element.paid == false).toList();
    });
  }
}
