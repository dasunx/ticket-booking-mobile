import 'package:ticket_booking_client/class/User.dart';

class ForeignUser {
  final String passportId;
  final String country;
  final User userDetails;

  ForeignUser({this.passportId, this.country, this.userDetails});
}
