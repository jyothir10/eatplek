import 'dart:convert';

import 'package:eatplek/Components/LoginButton.dart';
import 'package:eatplek/Constants.dart';
import 'package:eatplek/Screens/DashBoardScreen.dart';
import 'package:eatplek/Screens/RegisterScreen.dart';
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
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  bool isObscure = true;
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

  String email = "", password = "";
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
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    Map body1 = {
      "email": emailcontroller.text.trim(),
      "password": passwordcontroller.text.trim(),
    };
    final body = jsonEncode(body1);

    var urlfinal = Uri.https(URL_Latest, '/user/login');

    var res = await http.post(urlfinal, headers: headers, body: body);

    final responseBody = json.decode(res.body);

    if (isRequestSucceeded(res.statusCode)) {
      status = true;
      final msg = await responseBody['message'];

      emailcontroller.clear();
      passwordcontroller.clear();
      setState(() {
        showSpinner = false;
      });

      if (msg == "User logged in successfully") {
        sharedPreferences.setString("id", await responseBody['user']['id']);
        sharedPreferences.setString(
            "token", await responseBody['user']['token']);
        Navigator.pushReplacementNamed(context, DashBoardScreen.id);
      } else {
        if (status == false) {
          emailcontroller.clear();
          _scaffoldKey.currentState?.showSnackBar(
            const SnackBar(
              behavior: SnackBarBehavior.floating,
              duration: Duration(seconds: 1),
              content: Text(
                "Could not login! Username/password incorrect",
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
            "No acccount found",
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
  void dispose() {
    // TODO: implement dispose
    emailcontroller.dispose();
    passwordcontroller.dispose();
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
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
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
                          padding: EdgeInsets.only(left: 15, right: 15),
                          child: TextField(
                            controller: emailcontroller,
                            cursorColor: Colors.white,
                            keyboardType: TextInputType.emailAddress,
                            onChanged: (text) {
                              email = text;
                              if (email.isNotEmpty & password.isNotEmpty) {
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
                              labelText: 'E-mail',
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
                          padding: EdgeInsets.only(left: 15, right: 15),
                          child: TextField(
                            controller: passwordcontroller,
                            cursorColor: Colors.white,
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: isObscure,
                            onChanged: (text) {
                              password = text;
                              if (email.isNotEmpty & password.isNotEmpty) {
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
                            decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isObscure == true
                                        ? isObscure = false
                                        : isObscure = true;
                                  });
                                },
                                child: isObscure == true
                                    ? Icon(
                                        Icons.visibility,
                                        color: Colors.white,
                                      )
                                    : Icon(
                                        Icons.visibility_off,
                                        color: Colors.white,
                                      ),
                              ),
                              labelText: 'Password',
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
                              ? EdgeInsets.only(top: 18, left: 15, right: 15)
                              : EdgeInsets.only(top: 50, left: 15, right: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              LoginButton(
                                onPressed: () {
                                  if (email.isNotEmpty & password.isNotEmpty) {
                                    logIn();
                                  } else {
                                    _scaffoldKey.currentState?.showSnackBar(
                                        const SnackBar(
                                            behavior: SnackBarBehavior.floating,
                                            duration: Duration(seconds: 1),
                                            content: Text(
                                                "Invalid email or password")));
                                  }
                                },
                                text: 'Log In',
                                clr: buttonColour,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 15, vertical: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Don\'t have an account? ',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontFamily: 'SFUIText',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, RegisterScreen.id);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: Text(
                                    'Register',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontFamily: 'SFUIText',
                                      fontWeight: FontWeight.w700,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ),
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
