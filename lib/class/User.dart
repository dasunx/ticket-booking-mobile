import 'package:ticket_booking_client/class/Journey.dart';
import 'package:ticket_booking_client/class/Payment.dart';
import 'package:ticket_booking_client/class/UserDetails.dart';

class User {
  String userId;
  String name;
  String role;
  String email;
  String token;
  double balance;

  User(this.userId, this.email, this.name, this.role, this.token);
  User.w();
  Map<String, dynamic> userToJson() => {
        'userId': userId,
        'email': email,
        'name': name,
        'role': role,
        'token': token,
        'balance': balance
      };

  User.userFromJson(Map<String, dynamic> json)
      : userId = json['user']['_id'],
        email = json['user']['email'],
        name = json['user']['name'],
        role = json['user']['role'],
        token = json['token'],
        balance = double.parse(json['user']['balance'].toString());

  User.managerFromJson(Map<String, dynamic> json)
      : userId = json['_id'],
        email = json['email'],
        name = json['name'],
        role = json['role'];
}
