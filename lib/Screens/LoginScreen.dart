import 'package:eatplek/Components/LoginButton.dart';
import 'package:eatplek/Screens/OtpScreen.dart';
import 'package:flutter/material.dart';


class LoginScreen extends StatefulWidget {
  static const String id = '/login';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  DateTime? currentBackPressTime;

  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > const Duration(seconds: 2)) {
      currentBackPressTime = now;



      return Future.value(false);
    }
    return Future.value(true);
  }

  String number = "";
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop,
      child: SafeArea(
        child: Scaffold(
          body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              color: Color(0xff042e60),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 8, right: 15,bottom: 10),
                      child: InkWell(
                        onTap: () {
                          //todo:Add navigation
                        },
                        child: const Text(
                          'Skip',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontFamily: 'SFUIText',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                MediaQuery.of(context).viewInsets.bottom == 0
                    ? SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * .65,
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
                          cursorColor: Colors.white,
                          keyboardType: TextInputType.number,
                          onChanged: (text) {
                            number = text;
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
                                  Navigator.pushReplacementNamed(
                                      context, OtpScreen.id);
                                } else {

                                }
                              },
                              text: 'Get OTP',
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
    );
  }
}
