import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:payhere_flutter/payhere_flutter.dart';
import 'package:provider/provider.dart';
import 'package:ticket_booking_client/HomeScreen.dart';
import 'package:ticket_booking_client/class/DarkThemeProvider.dart';
import 'package:ticket_booking_client/class/User.dart';
import 'package:ticket_booking_client/components/AlertDialog.dart';
import 'package:http/http.dart' as http;
import 'package:ticket_booking_client/screens/payment/payment_history.dart';
import 'package:url_launcher/url_launcher.dart';

class MakePayment extends StatefulWidget {
  static const String id = 'MakePayment';
  final User user;

  const MakePayment({Key key, this.user}) : super(key: key);

  @override
  _MakePaymentState createState() => _MakePaymentState();
}

class _MakePaymentState extends State<MakePayment> {
  FocusNode fnMobile = new FocusNode();
  FocusNode fnPass = new FocusNode();
  FocusNode fnAmount = new FocusNode();
  String url = 'https://urbanticket.herokuapp.com/api/payment/add-payment';

  InitRequest req = InitRequest();
  PHConfigs configs = PHConfigs();
  String responseText = "";
  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  initPlatformState() {
    req.setMerchantId("1212949"); // Your Merchant PayHere ID
    req.setMerchantSecret(
        "4ZJ4OZbNiPx4p73LBLJ9wU8QiQhDHyrbO4TohGgYNdTR"); // Your Merchant secret (Add your app at Settings > Domains & Credentials, to get this))
    req.setCurrency("LKR"); // Currency code LKR/USD/GBP/EUR/AUD
    req.setAmount(1000.00); // Final Amount to be charged
    req.setOrderId(
        "payment" + DateTime.now().toIso8601String()); // Unique Reference ID
    req.setItemsDescription("top up payment"); // Item description title
    req.setCustom1("This is the custom message 1");
    req.setCustom2("This is the custom message 2");
    req.getCustomer().setFirstName("Mr/Mrs");
    req.getCustomer().setLastName(widget.user.name);
    req.getCustomer().setEmail(widget.user.email);
    req.getCustomer().setPhone("+94771234567");
    req.getCustomer().getAddress().setAddress("No.1, Galle Road");
    req.getCustomer().getAddress().setCity("Colombo");
    req.getCustomer().getAddress().setCountry("Sri Lanka");

    req
        .getItems()
        .add(Item.create(id: null, name: "demo", quantity: 4, amount: 45.56));
  }

  GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    double keyboardH = MediaQuery.of(context).viewInsets.bottom;
    final themeChange = Provider.of<DarkThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Account top-up"),
      ),
      // drawer: CustomDrawer(
      //   id: MakePayment.id,
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      // floatingActionButton: Builder(
      //   builder: (BuildContext context) {
      //     return FloatingActionButton(
      //       backgroundColor: Colors.transparent,
      //       splashColor: Colors.white,
      //       elevation: 0,
      //       child: Icon(Icons.menu),
      //       onPressed: () {
      //         Scaffold.of(context).openDrawer();
      //       },
      //     );
      //   },
      // ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
          fnPass.unfocus();
          fnAmount.unfocus();
          fnMobile.unfocus();
        },
        child: Container(
          decoration: BoxDecoration(
            gradient: new LinearGradient(
              colors: [
                const Color(0xFF3366FF),
                const Color(0xFF00CCFF),
              ],
              begin: const FractionalOffset(0.0, 0.0),
              end: const FractionalOffset(1.0, 0.0),
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              AnimatedContainer(
                alignment: Alignment.center,
                height: keyboardH > 0 ? 100 : 450,
                duration: Duration(milliseconds: 600),
                curve: Curves.fastOutSlowIn,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: keyboardH > 0 ? 1 : 6,
                        child: Image(
                          image:
                              AssetImage("images/Payment Information-pana.png"),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(
                          "Secure payment",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: themeChange.darkTheme
                        ? Color(0XFF1A237E)
                        : Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(keyboardH > 0 ? 0 : 30),
                      topLeft: Radius.circular(keyboardH > 0 ? 0 : 30),
                    ),
                  ),
                  padding: EdgeInsets.only(top: 40, left: 30, right: 30),
                  child: Column(
                    children: [
                      Container(
                        child: TextField(
                          autofocus: false,
                          focusNode: fnMobile,
                          onChanged: (value) {
                            req.getCustomer().setPhone(value);
                          },
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.person),
                              border: OutlineInputBorder(),
                              labelText: "Mobile",
                              hintStyle: TextStyle(
                                color: Colors.grey[400],
                              )),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      // Container(
                      //   child: TextField(
                      //     focusNode: fnPass,
                      //     obscureText: true,
                      //     decoration: InputDecoration(
                      //         prefixIcon: Icon(Icons.remove_red_eye),
                      //         border: OutlineInputBorder(),
                      //         labelText: "Password",
                      //
                      //         // errorText:
                      //         // emailValidation ? "Add Valid Email" : null,
                      //         errorBorder: OutlineInputBorder().copyWith(
                      //             borderSide: BorderSide(color: Colors.red)),
                      //         hintStyle: TextStyle(
                      //           color: Colors.grey[400],
                      //         )),
                      //   ),
                      // ),
                      // SizedBox(
                      //   height: 10,
                      // ),
                      Container(
                        child: TextField(
                          focusNode: fnAmount,
                          onChanged: (value) {
                            req.setAmount(double.parse(value));
                          },
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.attach_money),
                              border: OutlineInputBorder(),
                              labelText: "Amount",
                              // errorText:
                              // emailValidation ? "Add Valid Email" : null,
                              errorBorder: OutlineInputBorder().copyWith(
                                  borderSide: BorderSide(color: Colors.red)),
                              hintStyle: TextStyle(
                                color: Colors.grey[400],
                              )),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      FlatButton(
                        padding:
                            EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                        color: Color(0XFFFF7A2A),
                        child: Text(
                          "Top-up",
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () async {
                          PhResponse response =
                              await PayhereFlutter.oneTimePaymentSandbox(
                                  request: req);

                          print(response.toJson().toString());
                          if (response.toJson()['status'].toString() == "1") {
                            final http.Response httpResponse =
                                await http.post(url,
                                    headers: <String, String>{
                                      'Content-Type': 'application/json',
                                    },
                                    body: jsonEncode(<String, dynamic>{
                                      "userId": widget.user.userId,
                                      "type": "Mobile",
                                      "amount": req.getAmount(),
                                      "payhereId": response.toJson()['data']
                                          ['paymentNo']
                                    }));
                            if (httpResponse.statusCode == 201) {
                              showAlertDialog(
                                  context,
                                  "Payment Successful",
                                  response
                                      .toJson()['data']['message']
                                      .toString(),
                                  "home",
                                  "view payments", () {
                                Navigator.pop(context);
                                Navigator.pushNamedAndRemoveUntil(
                                    context,
                                    HomeScreen.id,
                                    (Route<dynamic> route) => false,
                                    arguments: widget.user);
                              }, () {
                                Navigator.pop(context);
                                Navigator.popAndPushNamed(
                                  context,
                                  PaymentHistory.id,
                                  arguments: widget.user,
                                );
                              });
                            } else {
                              showAlertDialog(
                                  context,
                                  "Payment Successful but error while updating database",
                                  "Please contact us via hot-line number to solve this issue",
                                  "Make a call",
                                  "Home", () {
                                launch("tel://0715969888");
                                Navigator.pop(context);
                                Navigator.pushNamedAndRemoveUntil(
                                    context,
                                    HomeScreen.id,
                                    (Route<dynamic> route) => false,
                                    arguments: widget.user);
                              }, () {
                                Navigator.pop(context);
                                Navigator.popAndPushNamed(
                                  context,
                                  PaymentHistory.id,
                                  arguments: widget.user,
                                );
                              });
                            }
                          } else {
                            showAlertDialog(
                                context,
                                "Transaction failed",
                                "${response.toJson()['data']['message'].toString()} please check your details",
                                "ok",
                                "cancel", () {
                              Navigator.pop(context);
                            }, () {
                              Navigator.pop(context);
                            });
                          }

                          setState(() {
                            responseText = response.toJson().toString();
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
