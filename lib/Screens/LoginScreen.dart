import 'dart:convert';

import 'package:eatplek/Components/LoginButton.dart';
import 'package:eatplek/Constants.dart';
import 'package:eatplek/Screens/OtpScreen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../Exceptions/api_exception.dart';

class LoginScreen extends StatefulWidget {
  static const String id = '/login';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController phonecontroller = TextEditingController();
  DateTime? currentBackPressTime;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

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

  String phone = "";
  bool showSpinner = false;
  bool status = false;
  Color buttonColour = Color(0xffc6c6cc);

  static bool isRequestSucceeded(int statusCode) {
    return statusCode >= 200 && statusCode < 300;
  }

  logIn() async {
    setState(() {
      showSpinner = true;
      FocusManager.instance.primaryFocus?.unfocus();
    });
    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    Map body1 = {"phone": phonecontroller.text.trim().toString()};
    final body = jsonEncode(body1);

    var urlfinal = Uri.http(URL_Latest, '/user');

    var res = await http.post(urlfinal, headers: headers, body: body);

    final responseBody = json.decode(res.body);

    if (isRequestSucceeded(res.statusCode)) {
      status = true;
      final msg = await responseBody['message'];

      phonecontroller.clear();

      if (msg == "OTP sent successfully") {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => OtpScreen(
                    phone: phone,
                  )),
        );

        // Navigator.pushReplacementNamed(context, DashBoardScreen.id);
      } else {
        phonecontroller.clear();
        ScaffoldMessenger.of(context)
          ..showSnackBar(
            const SnackBar(
              behavior: SnackBarBehavior.floating,
              duration: Duration(seconds: 1),
              content: Text(
                "Could not send OTP ! Please try again",
              ),
            ),
          );
        print(status);
        throw APIException(res.statusCode, jsonDecode(res.body));
      }
    } else {
      ScaffoldMessenger.of(context)
        ..showSnackBar(
          SnackBar(
            behavior: SnackBarBehavior.floating,
            duration: Duration(seconds: 1),
            content: Text(
              "Could not send OTP ! Please try again",
            ),
          ),
        );
      setState(() {
        showSpinner = false;
      });
      throw APIException(res.statusCode, jsonDecode(res.body));
    }
    setState(() {
      showSpinner = false;
    });
  }

  @override
  void dispose() {
    phonecontroller.dispose();
    super.dispose();
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
            color: Colors.white,
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
                          height: MediaQuery.of(context).size.height * .57,
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
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          children: const [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 15),
                              child: Text(
                                'Log In',
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
                          padding:
                              EdgeInsets.only(left: 15, right: 15, top: 14),
                          child: TextField(
                            maxLength: 10,
                            controller: phonecontroller,
                            cursorColor: Colors.white,
                            keyboardType: TextInputType.phone,
                            onChanged: (text) {
                              phone = text;
                              if (phone.length == 10) {
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
                              fontSize: 18,
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
                              labelText: 'Phone Number',
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
                              ? EdgeInsets.only(top: 58, left: 15, right: 15)
                              : EdgeInsets.only(top: 50, left: 15, right: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              LoginButton(
                                onPressed: () {
                                  if (phone.length == 10) {
                                    logIn();
                                  } else {
                                    ScaffoldMessenger.of(context)
                                      ..showSnackBar(const SnackBar(
                                          behavior: SnackBarBehavior.floating,
                                          duration: Duration(seconds: 1),
                                          content:
                                              Text("Invalid phone number")));
                                  }
                                },
                                text: 'Get OTP',
                                clr: buttonColour,
                              ),
                            ],
                          ),
                        ),
                        // Padding(
                        //   padding: EdgeInsets.symmetric(
                        //       horizontal: 15, vertical: 15),
                        //   child: Row(
                        //     mainAxisAlignment: MainAxisAlignment.center,
                        //     children: [
                        //       Text(
                        //         'Don\'t have an account? ',
                        //         style: TextStyle(
                        //           color: Colors.white,
                        //           fontSize: 14,
                        //           fontFamily: 'SFUIText',
                        //           fontWeight: FontWeight.w500,
                        //         ),
                        //       ),
                        //       InkWell(
                        //         onTap: () {
                        //           Navigator.pushNamed(
                        //               context, RegisterScreen.id);
                        //         },
                        //         child: Padding(
                        //           padding: const EdgeInsets.all(3.0),
                        //           child: Text(
                        //             'Register',
                        //             style: TextStyle(
                        //               color: Colors.white,
                        //               fontSize: 14,
                        //               fontFamily: 'SFUIText',
                        //               fontWeight: FontWeight.w700,
                        //               decoration: TextDecoration.underline,
                        //             ),
                        //           ),
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                        // ),
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
