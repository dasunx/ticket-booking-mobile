import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ticket_booking_client/HomeScreen.dart';
import 'package:ticket_booking_client/WelcomeScreen.dart';
import 'package:ticket_booking_client/class/DarkThemeProvider.dart';
import 'package:ticket_booking_client/class/Styles.dart';
import 'package:ticket_booking_client/screens/auth/login_screen.dart';
import 'package:ticket_booking_client/screens/auth/register_screen.dart';
import 'package:ticket_booking_client/screens/payment/make_payment.dart';
import 'package:ticket_booking_client/screens/payment/payment_history.dart';
import 'package:ticket_booking_client/screens/qrcode/qrcode.dart';
import 'package:ticket_booking_client/screens/travel/travel_history.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DarkThemeProvider themeChangeProvider = new DarkThemeProvider();

  @override
  void initState() {
    super.initState();
    getCurrentAppTheme();
  }

  void getCurrentAppTheme() async {
    themeChangeProvider.darkTheme =
        await themeChangeProvider.darkThemePreference.getTheme();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) {
        return themeChangeProvider;
      },
      child: Consumer<DarkThemeProvider>(
        builder: (BuildContext context, value, Widget child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Widgets',
            theme: Styles.themeData(themeChangeProvider.darkTheme, context),
            initialRoute: HomeScreen.id,
            routes: {
              WelcomeScreen.id: (context) => WelcomeScreen(),
              RegisterScreen.id: (context) => RegisterScreen(),
              LoginScreen.id: (context) => LoginScreen(),
              HomeScreen.id: (context) => HomeScreen(),
              MakePayment.id: (context) => MakePayment(),
              PaymentHistory.id: (context) => PaymentHistory(),
              QrCode.id: (context) => QrCode(),
              TravelHistory.id: (context) => TravelHistory()
            },
          );
        },
      ),
    );
  }
}
