import 'package:ticket_booking_client/class/Journey.dart';
import 'package:ticket_booking_client/class/Payment.dart';

class UserDetails {
  double balance;
  List<Payment> paymentHistory;
  bool ongoing;
  Journey onGoingJourney;
  List<Journey> travelHistory;
}

List<Payment> paymentListFromJson(Map<String, dynamic> json) {
  // This method is for save data as payment list.
  List<Payment> paymentList = new List<Payment>();
  json.forEach((key, value) {
    Payment p = new Payment.fromJson(value);
    paymentList.add(p);
  });
  return paymentList;
}

List<Journey> journeyListFromJson(Map<String, dynamic> json) {
  List<Journey> journeyList = new List<Journey>();
  json.forEach((key, value) {
    Journey j = new Journey.fromJson(value);
    journeyList.add(j);
  });
  return journeyList;
}
