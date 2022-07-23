import 'package:eatplek/Components/LoginButton.dart';
import 'package:eatplek/Constants.dart';
import 'package:eatplek/Screens/optionScreen.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OtpScreen extends StatefulWidget {
  static const String id = '/otp';
  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  DateTime? currentBackPressTime;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String otp = "";

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

  Color buttonColour = Colors.white54;

  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        key: _scaffoldKey,
        body: Container(
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
                      children: const [
                        Text(
                          'A verification code has been sent to\n(+91) 920702****', //todo:phone number
                          style: TextStyle(
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
                    const Padding(
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
                    Padding(
                      padding: const EdgeInsets.only(top: 9),
                      child: LoginButton(
                          clr: buttonColour,
                          onPressed: () {
                            if (otp.length == 6) {
                              Navigator.pushReplacementNamed(
                                  context, OptionScreen.id);
                            } else {
                              _scaffoldKey.currentState?.showSnackBar(
                                  const SnackBar(
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
    );
  }
}
