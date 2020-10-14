import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ticket_booking_client/class/Payment.dart';
import 'package:ticket_booking_client/components/TicketAroundClipper.dart';

class PaymentHistory extends StatefulWidget {
  static const String id = "payment_history";
  @override
  _PaymentHistoryState createState() => _PaymentHistoryState();
}

class _PaymentHistoryState extends State<PaymentHistory> {
  List<Payment> phItems = new List<Payment>();
  @override
  void initState() {
    phItems.add(
        new Payment(1000, DateTime.parse('2020-10-11 20:47:27.908'), "card"));
    phItems.add(new Payment(2400, DateTime.now(), "CDM"));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Payment history"),
      ),
      body: Container(
        child: phItems.length > 0
            ? ListView.builder(
                itemCount: phItems.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.only(right: 6, top: 10, left: 6),
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  'LKR ${phItems[index].payAmount.toString()}',
                                ),
                                Spacer(),
                                Chip(
                                  label: Text(
                                    '${phItems[index].type.toString()}',
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
                            Text(
                              '${DateFormat.yMMMd().add_jm().format(phItems[index].date).toString()}',
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                })
            : Container(
                child: Center(
                  child: Text(
                    'No payment history',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
      ),
    );
  }
}
