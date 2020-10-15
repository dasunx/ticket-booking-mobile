import 'package:ticket_booking_client/class/Journey.dart';
import 'package:ticket_booking_client/class/Payment.dart';

class UserDetails {
  double balance;
  List<Payment> paymentHistory;
  bool ongoing;
  Journey onGoingJourney;
  List<Journey> travelHistory;

  UserDetails(this.balance, this.paymentHistory, this.ongoing,
      this.onGoingJourney, this.travelHistory);
}

Future<UserDetails> userDetailsFromJson(var json) async {
  UserDetails userDetails;
  List<Payment> paymentHistory;
  Journey onGoingJourney;
  List<Journey> travelHistory;
  double balance = double.parse(json['balance'].toString());
  bool ongoing = json['ongoing'];
  if (ongoing) {
    print(json['journey']);
    onGoingJourney = new Journey.fromJson(json['journey']);
  } else {
    onGoingJourney = null;
  }
  paymentHistory = paymentListFromJson(json["paymentHistory"]);
  userDetails =
      new UserDetails(balance, paymentHistory, ongoing, onGoingJourney, []);
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
    Journey j = new Journey.fromJson(ele);
    journeyList.add(j);
  });
  return journeyList;
}
