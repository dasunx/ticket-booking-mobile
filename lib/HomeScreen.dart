import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ticket_booking_client/class/DarkThemeProvider.dart';
import 'package:ticket_booking_client/class/SharedPref.dart';
import 'package:ticket_booking_client/class/User.dart';
import 'package:ticket_booking_client/components/CustomDrawer.dart';
import 'package:ticket_booking_client/components/slider.dart';
import 'package:ticket_booking_client/screens/qrcode/qrcode.dart';

class HomeScreen extends StatefulWidget {
  static const String id = "Home_screen";
  final User user;

  const HomeScreen({Key key, this.user}) : super(key: key);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PanelController _pc = new PanelController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);

    BorderRadiusGeometry radius = BorderRadius.only(
      topLeft: Radius.circular(14.0),
      topRight: Radius.circular(14.0),
    );
    return Scaffold(
      appBar: AppBar(
        title: Text('Travel app home'),
      ),
      body: SlidingUpPanel(
        maxHeight: (MediaQuery.of(context).size.height - 200),
        minHeight: 60,
        controller: _pc,
        panel: Center(
          child: QrCode(
            user: widget.user,
          ),
        ),
        collapsed: Container(
          decoration: BoxDecoration(
              color: themeChange.darkTheme ? Color(0XFF1E453E) : Colors.white,
              borderRadius: radius),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(20),
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: themeChange.darkTheme ? Colors.white : Colors.black45,
                  borderRadius: new BorderRadius.only(
                    topLeft: const Radius.circular(40.0),
                    topRight: const Radius.circular(40.0),
                    bottomRight: const Radius.circular(40.0),
                    bottomLeft: const Radius.circular(40.0),
                  ),
                ),
                height: 7,
                width: 50,
              ),
              Center(
                child: Text(
                  "Swipe up to view qr code",
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
        body: GestureDetector(
          onTap: () => _pc.close(),
          child: Container(
            child: Text(widget.user.name),
          ),
        ),
        borderRadius: radius,
      ),
      drawer: CustomDrawer(
        id: HomeScreen.id,
      ),
    );
  }
}
