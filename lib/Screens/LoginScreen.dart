import 'dart:convert';

import 'package:eatplek/Components/LoginButton.dart';
import 'package:eatplek/Constants.dart';
import 'package:eatplek/Screens/OtpScreen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Exceptions/api_exception.dart';

class LoginScreen extends StatefulWidget {
  static const String id = '/login';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController numbercontroller = TextEditingController();

  DateTime? currentBackPressTime;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > const Duration(seconds: 2)) {
      currentBackPressTime = now;
      _scaffoldKey.currentState?.showSnackBar(const SnackBar(
          behavior: SnackBarBehavior.floating,
          duration: Duration(seconds: 1),
          content: Text("Press back again to exit")));
      return Future.value(false);
    }
    return Future.value(true);
  }

  String number = "";
  bool showSpinner = false;
  bool status = false;
  Color buttonColour = Color(0xffc6c6cc);

  static bool isRequestSucceeded(int statusCode) {
    return statusCode >= 200 && statusCode < 300;
  }

  logIn() async {
    setState(() {
      showSpinner = true;
    });
    String url = "${URL_Latest}/user";
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Map<String, String> headers = {
      "Content-Type": "application/json",
    };
    number = numbercontroller.text.trim();
    Map body1 = {
      "phone": numbercontroller.text.trim(),
    };
    final body = jsonEncode(body1);

    var urlfinal = Uri.https(URL_Latest, '/user');

    var res = await http.post(urlfinal, headers: headers, body: body);

    final responseBody = json.decode(res.body);

    if (isRequestSucceeded(res.statusCode)) {
      status = true;
      final msg = await responseBody['message'];

      numbercontroller.clear();
      setState(() {
        showSpinner = false;
      });

      if (msg != null) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OtpScreen(phone: number),
          ),
        );
      } else {
        if (status == false) {
          numbercontroller.clear();
          _scaffoldKey.currentState?.showSnackBar(
            SnackBar(
              behavior: SnackBarBehavior.floating,
              duration: Duration(seconds: 1),
              content: Text(
                responseBody["message"].toString(),
              ),
            ),
          );
          setState(() {
            showSpinner = false;
          });
          print(status);
        }
        throw APIException(res.statusCode, jsonDecode(res.body));
      }
    } else {
      _scaffoldKey.currentState?.showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          duration: Duration(seconds: 1),
          content: Text(
            responseBody["message"].toString(),
          ),
        ),
      );
      setState(() {
        showSpinner = false;
      });
      throw APIException(res.statusCode, jsonDecode(res.body));
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        key: _scaffoldKey,
        body: ModalProgressHUD(
          inAsyncCall: showSpinner,
          progressIndicator: CircularProgressIndicator(
            color: primaryclr,
          ),
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              color: primaryclr,
            ),
            child: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.end,
                  //   children: [
                  //     Padding(
                  //       padding: EdgeInsets.only(top: 8, right: 15, bottom: 10),
                  //       child: InkWell(
                  //         onTap: () {
                  //           Navigator.pushReplacementNamed(
                  //               context, DashBoardScreen.id);
                  //         },
                  //         child: const Text(
                  //           '',
                  //           style: TextStyle(
                  //             color: Colors.white,
                  //             fontSize: 16,
                  //             fontFamily: 'SFUIText',
                  //             fontWeight: FontWeight.w700,
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  MediaQuery.of(context).viewInsets.bottom == 0
                      ? SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * .65,
                          //child: SvgPicture.asset("images/logo.svg"),
                          child: Image.asset(
                            "images/login1.png",
                            fit: BoxFit.fill,
                          ),
                        )
                      : Container(),
                  Padding(
                    padding: MediaQuery.of(context).viewInsets.bottom == 0
                        ? const EdgeInsets.all(0.0)
                        : const EdgeInsets.symmetric(vertical: 25),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: const [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 15),
                              child: Text(
                                'Log in',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 36,
                                  fontFamily: 'SFUIText',
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: 15,
                              right: MediaQuery.of(context).size.width * .2),
                          child: TextField(
                            controller: numbercontroller,
                            cursorColor: Colors.white,
                            keyboardType: TextInputType.number,
                            onChanged: (text) {
                              number = text;
                              if (text.length == 10) {
                                setState(() {
                                  buttonColour = Colors.white;
                                });
                              } else {
                                setState(() {
                                  buttonColour = Color(0xffc6c6cc);
                                });
                              }
                            },
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontFamily: 'SFUIText',
                              fontWeight: FontWeight.w500,
                            ),
                            decoration: const InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              labelText: 'Enter your number',
                              labelStyle: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontFamily: 'SFUIText',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: MediaQuery.of(context).viewInsets.bottom == 0
                              ? EdgeInsets.only(top: 18, left: 15)
                              : EdgeInsets.only(top: 50, left: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              LoginButton(
                                onPressed: () {
                                  if (number.length == 10) {
                                    logIn();
                                  } else {
                                    _scaffoldKey.currentState?.showSnackBar(
                                        const SnackBar(
                                            behavior: SnackBarBehavior.floating,
                                            duration: Duration(seconds: 1),
                                            content:
                                                Text("Invalid mobile number")));
                                  }
                                },
                                text: 'Get OTP',
                                clr: buttonColour,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
