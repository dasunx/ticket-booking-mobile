import 'package:flutter/material.dart';
import 'package:ticket_booking_client/screens/auth/register_screen.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    double keyboardH = MediaQuery.of(context).viewInsets.bottom;
    String type = ModalRoute.of(context).settings.arguments;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomPadding: false,
        body: Container(
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
            children: [
              AnimatedContainer(
                alignment: Alignment.center,
                height: keyboardH > 0
                    ? 0
                    : (MediaQuery.of(context).size.height - 280),
                duration: Duration(milliseconds: 600),
                curve: Curves.fastOutSlowIn,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 6,
                        child: Image(
                          image: AssetImage("images/Address-bro.png"),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(
                          "Login",
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
                      topRight: Radius.circular(keyboardH > 0 ? 0 : 40),
                      topLeft: Radius.circular(keyboardH > 0 ? 0 : 40),
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
                            decoration: InputDecoration(
                                prefixIcon: Icon(Icons.person),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.grey, width: 1)),
                                border: OutlineInputBorder(),
                                labelText: "Email",
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
                            onTap: () {},
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
                      FlatButton(
                        padding:
                            EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                        color: Color(0XFFFF7A2A),
                        child: Text(
                          "Login",
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {
                          print('Register btn pressed');
                        },
                      ),
                      FlatButton(
                        child: Text(
                          "Create account?",
                          style: TextStyle(color: Colors.black),
                        ),
                        onPressed: () {
                          Navigator.popAndPushNamed(context, RegisterScreen.id);
                        },
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
