import 'package:flutter/material.dart';
import 'package:eatplek/Components/optionScreenTextField.dart';
import 'DashBoardScreen.dart';

class OptionScreen extends StatefulWidget {
  static const String id = '/option';
  @override
  State<OptionScreen> createState() => _OptionScreenState();
}

class _OptionScreenState extends State<OptionScreen> {
  int d = 0, t = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
                const optionScreenTextField(
                  text: "Name",
                ),
                const optionScreenTextField(
                  text: "Email(Optional)",
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height * .1,
                          width: MediaQuery.of(context).size.width * .21,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(15),
                            ),
                            color:
                                d == 0 ? Color(0xff8196af) : Color(0xffffffff),
                          ),
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                d = 1;
                                t = 0;
                              });
                            },
                            child: Column(
                              children: const [
                                // Dine In
                                Image(
                                  image: AssetImage("images/dinein.png"),
                                ),
                                Opacity(
                                  opacity: 0.5,
                                  child: Text("Dine In",
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
                              top: MediaQuery.of(context).size.height * .01),
                          child: Card(
                            color:
                                d == 0 ? Color(0xff8196af) : Color(0xffffffff),
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
                          height: MediaQuery.of(context).size.height * .1,
                          width: MediaQuery.of(context).size.width * .21,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(15),
                            ),
                            color:
                                t == 0 ? Color(0xff8196af) : Color(0xffffffff),
                          ),
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                t = 1;
                                d = 0;
                              });
                            },
                            child: Column(
                              children: const [
                                // Dine In
                                Image(
                                  image: AssetImage("images/takeaway.png"),
                                ),
                                Opacity(
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
                              top: MediaQuery.of(context).size.height * .01),
                          child: Card(
                            color:
                                t == 0 ? Color(0xff8196af) : Color(0xffffffff),
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
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * .8,
                      height: MediaQuery.of(context).size.height * .05,
                      child: ElevatedButton(
                        onPressed: () {
                          if (d != 0 || t != 0) {
                            Navigator.pushNamedAndRemoveUntil(
                                context, DashBoardScreen.id, (route) => false);
                          }
                        },
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
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
                ),
                // You can select any of one option from these (you can change it later
              ],
            ),
          ),
        ),
      ),
    );
  }
}

