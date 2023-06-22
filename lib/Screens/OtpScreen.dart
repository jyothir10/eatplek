import 'dart:async';
import 'dart:convert';

import 'package:eatplek/Components/LoginButton.dart';
import 'package:eatplek/Constants.dart';
import 'package:eatplek/Screens/LoginScreen.dart';
import 'package:eatplek/Screens/RegisterScreen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Exceptions/api_exception.dart';
import 'DashBoardScreen.dart';

class OtpScreen extends StatefulWidget {
  static const String id = '/otp';
  String? phone;
  OtpScreen({this.phone, Key? key}) : super(key: key);
  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  DateTime? currentBackPressTime;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool showSpinner = false;
  bool status = false;
  String msg = "", name = "", otp = "";

  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > const Duration(seconds: 2)) {
      currentBackPressTime = now;
      ScaffoldMessenger.of(context)
        ..showSnackBar(const SnackBar(
            behavior: SnackBarBehavior.floating,
            duration: Duration(seconds: 1),
            content: Text("Press back again to exit")));
      return Future.value(false);
    }
    return Future.value(true);
  }

  static bool isRequestSucceeded(int statusCode) {
    return statusCode >= 200 && statusCode < 300;
  }

  logIn() async {
    setState(() {
      showSpinner = true;
    });

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    Map body1 = {
      "phone": widget.phone,
      "otp": int.parse(otp),
    };

    final body = jsonEncode(body1);

    var urlfinal = Uri.http(URL_Latest, '/user/login');

    var res = await http.post(urlfinal, headers: headers, body: body);

    final responseBody = json.decode(res.body);

    print(responseBody);

    if (isRequestSucceeded(res.statusCode)) {
      status = true;
      msg = await responseBody['message'];

      print(responseBody);

      if (msg == "User logged in successfully") {
        sharedPreferences.setString("id", await responseBody['user']['id']);
        sharedPreferences.setString(
            "token", await responseBody['user']['token']);
        name = await responseBody['user']['name'];
        print(name);
        if (name.isEmpty) {
          Navigator.pushReplacementNamed(context, RegisterScreen.id);
        } else {
          Navigator.pushNamedAndRemoveUntil(
              context, DashBoardScreen.id, (route) => false);
        }
      } else {
        if (status == false) {
          ScaffoldMessenger.of(context)
            ..showSnackBar(
              SnackBar(
                behavior: SnackBarBehavior.floating,
                duration: Duration(seconds: 1),
                content: Text(
                  responseBody["error"].toString(),
                ),
              ),
            );
          setState(() {
            showSpinner = false;
          });
        }
        throw APIException(res.statusCode, jsonDecode(res.body));
      }
    } else {
      ScaffoldMessenger.of(context)
        ..showSnackBar(
          SnackBar(
            behavior: SnackBarBehavior.floating,
            duration: Duration(seconds: 1),
            content: Text(
              responseBody["error"],
            ),
          ),
        );
      setState(() {
        showSpinner = false;
      });
      throw APIException(res.statusCode, jsonDecode(res.body));
    }
  }

  Color buttonColour = Colors.white54;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        key: _scaffoldKey,
        body: ModalProgressHUD(
          inAsyncCall: showSpinner,
          progressIndicator: CircularProgressIndicator(
            color: Colors.white,
          ),
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: primaryclr,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: const [
                          Padding(
                            padding: EdgeInsets.only(bottom: 9),
                            child: Text(
                              'OTP Verification',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontFamily: 'SFUIText',
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'A verification code has been sent to\n(+91) ${widget.phone}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontFamily: 'SFUIText',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: PinCodeTextField(
                    keyboardType: TextInputType.number,
                    appContext: context,
                    length: 6,
                    onChanged: (value) {
                      otp = value;
                      if (otp.length == 6) {
                        setState(() {
                          buttonColour = Colors.white;
                        });
                      } else {
                        setState(() {
                          buttonColour = Color(0xffc6c6cc);
                        });
                      }
                    },
                    enableActiveFill: true,
                    enablePinAutofill: true,
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(5),
                      fieldHeight: 50,
                      fieldWidth: 40,
                      activeFillColor: otpColor,
                      inactiveFillColor: otpColor,
                      selectedFillColor: otpColor,
                      activeColor: otpColor,
                      inactiveColor: otpColor,
                      selectedColor: otpColor,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          // Timer(Duration(seconds: 30), () {

                          // });
                          Navigator.pushReplacementNamed(
                              context, LoginScreen.id);
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(15.0),
                          child: Text(
                            'Resend OTP',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontFamily: 'SFUIText',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 9),
                        child: LoginButton(
                            clr: buttonColour,
                            onPressed: () {
                              if (otp.length == 6 && otp.isNotEmpty) {
                                logIn();
                              } else {
                                ScaffoldMessenger.of(context)
                                  ..showSnackBar(const SnackBar(
                                      behavior: SnackBarBehavior.floating,
                                      duration: Duration(seconds: 1),
                                      content: Text("Invalid OTP")));
                              }
                            },
                            text: "Next"),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
