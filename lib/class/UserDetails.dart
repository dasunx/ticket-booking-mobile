import 'dart:convert';

import 'package:ticket_booking_client/class/Journey.dart';
import 'package:ticket_booking_client/class/Payment.dart';

import 'Fine.dart';

class UserDetails {
  double balance;
  List<Payment> paymentHistory;
  bool ongoing;
  Journey onGoingJourney;
  List<Journey> travelHistory;
  double fineBalance;
  List<Fine> fineHistory;

  UserDetails(
      this.balance,
      this.paymentHistory,
      this.ongoing,
      this.onGoingJourney,
      this.travelHistory,
      this.fineBalance,
      this.fineHistory);
}

Future<UserDetails> userDetailsFromJson(var json) async {
  UserDetails userDetails;
  List<Payment> paymentHistory;
  Journey onGoingJourney;
  List<Journey> travelHistory;
  List<Fine> fineHistory;
  double balance = double.parse(json['balance'].toString());
  bool ongoing = json['ongoing'];
  double fineBalance = double.parse(json['fineBalance'].toString());
  if (ongoing) {
    print(json['journey']);
    onGoingJourney = new Journey.fromJson(json['journey']);
  } else {
    onGoingJourney = null;
  }
  paymentHistory = paymentListFromJson(json["paymentHistory"]);
  travelHistory = journeyListFromJson(json['journeyHistory']);
  fineHistory = fineListFromJson(json['fineHistory']);
  userDetails = new UserDetails(balance, paymentHistory, ongoing,
      onGoingJourney, travelHistory, fineBalance, fineHistory);

  return userDetails;
}

List<Payment> paymentListFromJson(var json) {
  // This method is for save data as payment list.
  List<Payment> paymentList = new List<Payment>();
  json.forEach((ele) {
    Payment p = new Payment.fromJson(ele);
    paymentList.add(p);
  });
  return paymentList;
}

List<Journey> journeyListFromJson(var json) {
  List<Journey> journeyList = new List<Journey>();
  json.forEach((ele) {
    Journey j = new Journey.fromJsonFull(ele);
    journeyList.add(j);
  });
  return journeyList;
}

List<Fine> fineListFromJson(var json) {
  List<Fine> fineList = new List<Fine>();
  json.forEach((ele) {
    if (ele['paid'] == true) {
      Fine f = new Fine.fromJson(ele);
      fineList.add(f);
    } else {
      Fine f = new Fine.unPaidFinefromJson(ele);
      fineList.add(f);
    }
  });
  return fineList;
}
