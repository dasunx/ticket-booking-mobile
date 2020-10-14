import 'package:flutter/material.dart';
import 'package:ticket_booking_client/HomeScreen.dart';
import 'package:ticket_booking_client/WelcomeScreen.dart';
import 'package:ticket_booking_client/screens/auth/login_screen.dart';
import 'package:ticket_booking_client/screens/auth/register_screen.dart';
import 'package:ticket_booking_client/screens/loading/LoadingScreen.dart';
import 'package:ticket_booking_client/screens/payment/make_payment.dart';
import 'package:ticket_booking_client/screens/payment/payment_history.dart';
import 'package:ticket_booking_client/screens/qrcode/qrcode.dart';
import 'package:ticket_booking_client/screens/travel/travel_history.dart';

class Routing {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final arguments = settings.arguments;
    switch (settings.name) {
      case HomeScreen.id:
        return MaterialPageRoute(
            builder: (_) => HomeScreen(
                  user: arguments,
                ));
      case LoadingScreen.id:
        return MaterialPageRoute(builder: (_) => LoadingScreen());
      case WelcomeScreen.id:
        return MaterialPageRoute(builder: (_) => WelcomeScreen());
      case RegisterScreen.id:
        return MaterialPageRoute(
            builder: (_) => RegisterScreen(
                  type: arguments,
                ));
      case LoginScreen.id:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case QrCode.id:
        return MaterialPageRoute(
            builder: (_) => QrCode(
                  user: arguments,
                ));
      case MakePayment.id:
        return MaterialPageRoute(builder: (_) => MakePayment());
      case PaymentHistory.id:
        return MaterialPageRoute(builder: (_) => PaymentHistory());
      case TravelHistory.id:
        return MaterialPageRoute(builder: (_) => TravelHistory());
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                    child: Text('no routes for ${settings.name}'),
                  ),
                ));
    }
  }
}
