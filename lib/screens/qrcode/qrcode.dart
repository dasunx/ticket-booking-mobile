import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:ticket_booking_client/class/User.dart';

class QrCode extends StatefulWidget {
  static const String id = 'qr_code';
  final User user;

  const QrCode({Key key, this.user}) : super(key: key);
  @override
  _QrCodeState createState() => _QrCodeState();
}

class _QrCodeState extends State<QrCode> {
  GlobalKey globalKey = new GlobalKey();
  String _dataString;
  @override
  void initState() {
    print(widget.user.name);
    setState(() {
      _dataString = widget.user.userId;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Qr Code"),
      ),
      body: Center(
        child: Container(
          color: Colors.white,
          child: QrImage(
            data: _dataString,
            version: QrVersions.auto,
            size: 320,
            gapless: false,
            errorStateBuilder: (context, err) {
              return Container(
                child: Center(
                  child: Text(
                    "Uh oh! Something went wrong...",
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
