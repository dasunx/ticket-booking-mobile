import 'package:ticket_booking_client/class/Journey.dart';
import 'package:ticket_booking_client/class/Payment.dart';

class User {
  String userId;
  String name;
  String role;
  String email;
  String token;

  User(this.userId, this.email, this.name, this.role, this.token);
  User.w();
  Map<String, dynamic> userToJson() => {
        'userId': userId,
        'email': email,
        'name': name,
        'role': role,
        'token': token
      };

  User.userFromJson(Map<String, dynamic> json)
      : userId = json['user']['_id'],
        email = json['user']['email'],
        name = json['user']['name'],
        role = json['user']['role'],
        token = json['token'];
}
