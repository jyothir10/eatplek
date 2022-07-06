import 'package:eatplek/Components/optionScreenTextField.dart';
import 'package:flutter/material.dart';

import 'DashBoardScreen.dart';

class OptionScreen extends StatefulWidget {
  static const String id = '/option';
  @override
  State<OptionScreen> createState() => _OptionScreenState();
}

class _OptionScreenState extends State<OptionScreen> {
  String name = '', email = '';
  int d = 0, t = 0;
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: onWillPop,
        child: Scaffold(
          key: _scaffoldKey,
          body: Container(
            color: Color(0xff042e60),
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * .08,
                  vertical: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text("Choose Your Option",
                          style: TextStyle(
                              color: Color(0xffffffff),
                              fontWeight: FontWeight.w700,
                              fontFamily: "SFUIText",
                              fontStyle: FontStyle.normal,
                              fontSize: 24.0),
                          textAlign: TextAlign.left),
                      Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: Text(
                            "You can select any of one option from these \n(you can change it later)",
                            style: TextStyle(
                                color: Color(0xffffffff),
                                fontWeight: FontWeight.w700,
                                fontFamily: "SFUIText",
                                fontStyle: FontStyle.normal,
                                fontSize: 16.0),
                            textAlign: TextAlign.left),
                      ),
                    ],
                  ),
                  optionScreenTextField(
                    onchanged: (value) {
                      name = value;
                    },
                    text: "Name",
                  ),
                  optionScreenTextField(
                    onchanged: (value) {
                      email = value;
                    },
                    text: "Email(Optional)",
                  ),
                  MediaQuery.of(context).viewInsets.bottom == 0
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              children: [
                                Container(
                                  height:
                                      MediaQuery.of(context).size.height * .1,
                                  width:
                                      MediaQuery.of(context).size.width * .21,
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(15),
                                    ),
                                    color: d == 0
                                        ? Color(0xff8196af)
                                        : Color(0xffffffff),
                                  ),
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        d = 1;
                                        t = 0;
                                      });
                                    },
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        // Dine In
                                        Image(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              .06,
                                          image:
                                              AssetImage("images/dinein.png"),
                                        ),
                                        const Opacity(
                                          opacity: 0.5,
                                          child: Padding(
                                            padding: EdgeInsets.only(top: 2),
                                            child: Text("Dine In",
                                                style: TextStyle(
                                                    color: Color(0xff042e60),
                                                    fontWeight: FontWeight.w700,
                                                    fontFamily: "SFUIText",
                                                    fontStyle: FontStyle.normal,
                                                    fontSize: 9.9),
                                                textAlign: TextAlign.left),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: MediaQuery.of(context).size.height *
                                          .01),
                                  child: Card(
                                    color: d == 0
                                        ? Color(0xff8196af)
                                        : Color(0xffffffff),
                                    elevation: 5,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: const Icon(
                                      Icons.check,
                                      size: 25,
                                      color: Color(0xff042e60),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Container(
                                  height:
                                      MediaQuery.of(context).size.height * .1,
                                  width:
                                      MediaQuery.of(context).size.width * .21,
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(15),
                                    ),
                                    color: t == 0
                                        ? Color(0xff8196af)
                                        : Color(0xffffffff),
                                  ),
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        t = 1;
                                        d = 0;
                                      });
                                    },
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        // Dine In
                                        Image(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              .08,
                                          image:
                                              AssetImage("images/takeaway.png"),
                                        ),
                                        const Opacity(
                                          opacity: 0.5,
                                          child: Text("Take Away",
                                              style: TextStyle(
                                                  color: Color(0xff042e60),
                                                  fontWeight: FontWeight.w700,
                                                  fontFamily: "SFUIText",
                                                  fontStyle: FontStyle.normal,
                                                  fontSize: 9.9),
                                              textAlign: TextAlign.left),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: MediaQuery.of(context).size.height *
                                          .01),
                                  child: Card(
                                    color: t == 0
                                        ? Color(0xff8196af)
                                        : Color(0xffffffff),
                                    elevation: 5,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: const Icon(
                                      Icons.check,
                                      size: 25,
                                      color: Color(0xff042e60),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )
                      : Container(),
                  MediaQuery.of(context).viewInsets.bottom == 0
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * .8,
                              height: MediaQuery.of(context).size.height * .05,
                              child: ElevatedButton(
                                onPressed: () {
                                  if ((d != 0 || t != 0) & (name.isNotEmpty)) {
                                    Navigator.pushNamedAndRemoveUntil(context,
                                        DashBoardScreen.id, (route) => false);
                                  } else {
                                    _scaffoldKey.currentState?.showSnackBar(
                                        const SnackBar(
                                            behavior: SnackBarBehavior.floating,
                                            duration: Duration(seconds: 1),
                                            content: Text(
                                                "Please fill all details")));
                                  }
                                },
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.white),
                                ),
                                child: const Text(
                                  'Next',
                                  style: TextStyle(
                                    color: Color(0xff042e60),
                                    fontSize: 18,
                                    fontFamily: 'SFUIText',
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      : Container(),
                  // You can select any of one option from these (you can change it later
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
