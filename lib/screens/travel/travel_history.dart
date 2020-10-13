import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:ticket_booking_client/class/DarkThemeProvider.dart';
import 'package:ticket_booking_client/class/Journey.dart';
import 'package:ticket_booking_client/components/DottedLine.dart';
import 'package:ticket_booking_client/components/TicketClipper.dart';
import 'package:ticket_booking_client/components/side_cut_clipper.dart';

class TravelHistory extends StatefulWidget {
  static const String id = 'travel_history';
  @override
  _TravelHistoryState createState() => _TravelHistoryState();
}

class _TravelHistoryState extends State<TravelHistory> {
  List<Journey> phItems = new List<Journey>();
  @override
  void initState() {
    phItems.add(new Journey(
        'Kaduwela',
        'Kollupitiya',
        DateTime.parse('2020-10-08 08:47:27.908'),
        DateTime.parse('2020-10-08 09:30:27.908'),
        65));
    phItems.add(new Journey(
        "Colombo-Fort",
        "Gampaha",
        DateTime.parse('2020-10-11 11:47:27.908'),
        DateTime.parse('2020-10-11 13:20:27.908'),
        85));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Payment history"),
      ),
      body: Container(
        child: ListView.builder(
            itemCount: phItems.length,
            itemBuilder: (context, index) {
              int time;
              int sthour = int.parse(
                  DateFormat.H().format(phItems[index].startTime).toString());
              int endhour = int.parse(
                  DateFormat.H().format(phItems[index].endTime).toString());
              int stMin = int.parse(
                  DateFormat.m().format(phItems[index].startTime).toString());
              int endMin = int.parse(
                  DateFormat.m().format(phItems[index].endTime).toString());
              time = ((endhour * 60) + endMin) - ((sthour * 60) + stMin);

              return ClipPath(
                clipper: TicketClipper(20),
                child: Container(
                  height: 200,
                  margin: EdgeInsets.only(right: 6, top: 10, left: 6),
                  child: Card(
                    color: themeChange.darkTheme
                        ? Color(0XFF1E453E)
                        : Color(0xffCBDCF8),
                    elevation: 3,
                    child: Padding(
                      padding:
                          const EdgeInsets.only(top: 12.0, left: 12, right: 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Text(
                                '${phItems[index].startingPlace.toString()}',
                                style: TextStyle(fontSize: 25),
                              ),
                              Spacer(),
                              Transform.rotate(
                                  angle: 90 * pi / 180,
                                  child: Icon(
                                    Icons.airplanemode_active,
                                    color: Colors.red,
                                  )),
                              Spacer(),
                              Text(
                                '${phItems[index].endingPlace.toString()}',
                                style: TextStyle(fontSize: 25),
                              ),
                            ],
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 15.0),
                            child: Row(
                              children: [
                                Text(
                                  '${DateFormat().add_jm().format(phItems[index].startTime).toString()}',
                                ),
                                Spacer(),
                                Text(
                                  '${DateFormat().add_jm().format(phItems[index].endTime).toString()}',
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          Text(
                            'LKR ${phItems[index].cost.toString()}',
                            style: TextStyle(fontSize: 18),
                          ),
                          Text(
                            (time ~/ 60).toInt() >= 1
                                ? '${((time ~/ 60).toInt()).toString()} h ${(time % 60).toString()} minutes trip'
                                : '${(time % 60).toString()} minutes trip',
                            style: TextStyle(fontSize: 18),
                          ),
                          DottedLine(
                            dashColor: themeChange.darkTheme
                                ? Colors.red
                                : Colors.white,
                            dashGapLength: 5,
                            lineThickness: 1,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 15.0),
                            child: Row(
                              children: [
                                Text(
                                  '${DateFormat().add_yMMMd().format(phItems[index].startTime).toString()}',
                                  style: TextStyle(fontSize: 16),
                                ),
                                Spacer(),
                                Chip(
                                  label: Text(
                                    'Completed',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  avatar: CircleAvatar(
                                    backgroundColor: Colors.black,
                                    child: Icon(
                                      Icons.done,
                                      color: Colors.green,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }
}
