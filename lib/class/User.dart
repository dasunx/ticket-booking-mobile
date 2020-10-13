import 'package:ticket_booking_client/class/Journey.dart';
import 'package:ticket_booking_client/class/Payment.dart';

class User {
  String userId;
  String name;
  String type;
  final String email;
  String nic;
  String pid;
  String country;
  double balance;
  List<Payment> paymentHistory;
  bool ongoing;
  Journey onGoingJourney;
  List<Journey> travelHistory;

  User(
      {this.userId,
      this.email,
      this.name,
      this.nic,
      this.pid,
      this.country,
      this.balance,
      this.paymentHistory,
      this.ongoing,
      this.onGoingJourney,
      this.travelHistory});

  Map<String, dynamic> localUserToJson() => {
        'userId': userId,
        'email': email,
        'name': name,
        'type': type,
        'nic': nic,
        'balance': balance,
        'paymentHistory': paymentHistory,
        'ongoing': ongoing,
        'onGoingJourney': onGoingJourney,
        'travelHistory': travelHistory
      };

  Map<String, dynamic> foreignUserToJson() => {
        'userId': userId,
        'email': email,
        'name': name,
        'type': type,
        'pid': pid,
        'country': country,
        'balance': balance,
        'paymentHistory': paymentHistory,
        'ongoing': ongoing,
        'onGoingJourney': onGoingJourney,
        'travelHistory': travelHistory
      };

  User.localUserFromJson(Map<String, dynamic> json)
      : userId = json['_id'],
        email = json['email'],
        name = json['name'],
        type = 'local',
        nic = json['nic'],
        balance = json['balance'],
        paymentHistory = json['paymentHistory'],
        ongoing = json['ongoing'],
        onGoingJourney = Journey.onGoingJourneyFromJson(json['onGoingJourney']),
        travelHistory = journeyListFromJson(json['travelHistory']);

  User.foreignUserFromJson(Map<String, dynamic> json)
      : userId = json['_id'],
        email = json['email'],
        name = json['name'],
        type = 'foreign',
        pid = json['pid'],
        country = json['country'],
        balance = json['balance'],
        paymentHistory = paymentListFromJson(json['paymentHistory']),
        ongoing = json['ongoing'],
        onGoingJourney = Journey.onGoingJourneyFromJson(json['onGoingJourney']),
        travelHistory = journeyListFromJson(json['travelHistory']);
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
