import 'dart:async';

import 'package:eatplek/Constants.dart';
import 'package:eatplek/Screens/LoginScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'DashBoardScreen.dart';

class OnboardingScreen extends StatefulWidget {
  static const String id = '/splash';

  OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  DateTime? currentBackPressTime;
  String? id = "";
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  void initState() {
    super.initState();
    startTime();
  }

  startTime() async {
    var _duration = Duration(seconds: 4);
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    id = (await sharedPreferences.getString("id"));
    return Timer(_duration, () {
      //Navigate to another screen or anyOther function, like i set duration 4 sec so this function run after 4 sec
      if (id == null) {
        Navigator.pushReplacementNamed(context, LoginScreen.id);
      } else {
        Navigator.pushNamedAndRemoveUntil(
            context, DashBoardScreen.id, (route) => false);
      }
    });
  }

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

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        key: _scaffoldKey,
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.height,
          color: primaryclr,
          child: AnimatedContainer(
            duration: Duration(milliseconds: 300),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Hero(
                  tag: "logo",
                  child: SvgPicture.asset(
                    "images/042e60.svg",
                    width: MediaQuery.of(context).size.width * .8,
                    height: MediaQuery.of(context).size.height *
                        .5, //just like you define in pubspec.yaml file
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
