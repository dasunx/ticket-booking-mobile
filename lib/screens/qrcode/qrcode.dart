import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrCode extends StatefulWidget {
  static const String id = 'qr_code';
  @override
  _QrCodeState createState() => _QrCodeState();
}

class _QrCodeState extends State<QrCode> {
  GlobalKey globalKey = new GlobalKey();
  String _dataString = "Hello from this QR";

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
