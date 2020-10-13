import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:payhere_flutter/payhere_flutter.dart';
import 'package:ticket_booking_client/components/CustomDrawer.dart';

class MakePayment extends StatefulWidget {
  static const String id = 'MakePayment';
  @override
  _MakePaymentState createState() => _MakePaymentState();
}

class _MakePaymentState extends State<MakePayment> {
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
    req.setOrderId("230000123"); // Unique Reference ID
    req.setItemsDescription("Door bell wireless"); // Item description title
    req.setCustom1("This is the custom message 1");
    req.setCustom2("This is the custom message 2");
    req.getCustomer().setFirstName("Saman");
    req.getCustomer().setLastName("Perera");
    req.getCustomer().setEmail("samanp@gmail.com");
    req.getCustomer().setPhone("+94771234567");
    req.getCustomer().getAddress().setAddress("No.1, Galle Road");
    req.getCustomer().getAddress().setCity("Colombo");
    req.getCustomer().getAddress().setCountry("Sri Lanka");

//Optional Params
    req.getCustomer().getDeliveryAddress().setAddress("No.2, Kandy Road");
    req.getCustomer().getDeliveryAddress().setCity("Kadawatha");
    req.getCustomer().getDeliveryAddress().setCountry("Sri Lanka");

    req
        .getItems()
        .add(Item.create(id: null, name: "demo", quantity: 4, amount: 45.56));
  }

  @override
  Widget build(BuildContext context) {
    double keyboardH = MediaQuery.of(context).viewInsets.bottom;
    return Scaffold(
      appBar: AppBar(
        title: Text("Account top-up"),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
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
                height: keyboardH > 0 ? 100 : 380,
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
                          image: AssetImage("images/reg_image.png"),
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
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(keyboardH > 0 ? 0 : 30),
                      topLeft: Radius.circular(keyboardH > 0 ? 0 : 30),
                    ),
                  ),
                  padding: EdgeInsets.only(top: 40, left: 30, right: 30),
                  child: Column(
                    children: [
                      Container(
                        child: Theme(
                          data: ThemeData(),
                          child: TextField(
                            onTap: () {},
                            onChanged: (value) {
                              req.getCustomer().setPhone(value);
                            },
                            decoration: InputDecoration(
                                prefixIcon: Icon(Icons.person),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.grey, width: 1)),
                                border: OutlineInputBorder(),
                                labelText: "Mobile",
                                hintStyle: TextStyle(
                                  color: Colors.grey[400],
                                )),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        child: Theme(
                          data: ThemeData(),
                          child: TextField(
                            obscureText: true,
                            decoration: InputDecoration(
                                prefixIcon: Icon(Icons.remove_red_eye),
                                border: OutlineInputBorder(),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.grey, width: 1)),
                                labelText: "Password",
                                // errorText:
                                // emailValidation ? "Add Valid Email" : null,
                                errorBorder: OutlineInputBorder().copyWith(
                                    borderSide: BorderSide(color: Colors.red)),
                                hintStyle: TextStyle(
                                  color: Colors.grey[400],
                                )),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        child: Theme(
                          data: ThemeData(),
                          child: TextField(
                            decoration: InputDecoration(
                                prefixIcon: Icon(Icons.attach_money),
                                border: OutlineInputBorder(),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.grey, width: 1)),
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
      drawer: CustomDrawer(
        id: MakePayment.id,
      ),
    );
  }
}
