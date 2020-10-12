import 'package:ticket_booking_client/class/Journey.dart';
import 'package:ticket_booking_client/class/Payment.dart';

class User {
  final String email;
  final String password;
  double balance;
  List<Payment> paymentHistory;
  bool ongoing;
  Journey onGoingJourney;
  List<Journey> travelHistory;

  User.auth(this.email, this.password);

  User(
      {this.email,
      this.password,
      this.balance,
      this.paymentHistory,
      this.ongoing,
      this.onGoingJourney,
      this.travelHistory});
}
