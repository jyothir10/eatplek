import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OptionScreen extends StatefulWidget {
  static const String id = '/option';

  @override
  State<OptionScreen> createState() => _OptionScreenState();

}

class _OptionScreenState extends State<OptionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xff042e60),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * .1,vertical: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: const [
                  Text(
                      "Choose Your Option",
                      style: TextStyle(
                          color:  Color(0xffffffff),
                          fontWeight: FontWeight.w700,
                          fontFamily: "SFUIText",
                          fontStyle:  FontStyle.normal,
                          fontSize: 24.0
                      ),
                      textAlign: TextAlign.left
                  ),
                  Text(
                      "You can select any of one option from these \n(you can change it later)",
                      style: TextStyle(
                          color:  Color(0xffffffff),
                          fontWeight: FontWeight.w700,
                          fontFamily: "SFUIText",
                          fontStyle:  FontStyle.normal,
                          fontSize: 16.0
                      ),
                      textAlign: TextAlign.left
                  ),
                ],
              ),
              Column(
                children: const [
                  Text(
                      "Name",
                      style: TextStyle(
                          color:  Color(0x61ffffff),
                          fontWeight: FontWeight.w500,
                          fontFamily: "SFUIText",
                          fontStyle:  FontStyle.normal,
                          fontSize: 16.0
                      ),
                      textAlign: TextAlign.left
                  ),
                  TextField(
                    style: TextStyle(color: Colors.white),
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xffffffff),
                          )
                      ),
                      border: OutlineInputBorder(
                      ),
                      hintText: "",
                    ),
                  ),
                ],
              ),
              Column(
                children: const [
                  Text(
                      "Email(Optional)",
                      style: TextStyle(
                          color:  Color(0x61ffffff),
                          fontWeight: FontWeight.w500,
                          fontFamily: "SFUIText",
                          fontStyle:  FontStyle.normal,
                          fontSize: 16.0
                      ),
                      textAlign: TextAlign.left
                  ),
                  TextField(
                    style: TextStyle(color: Colors.white),
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xffffffff),
                          )
                      ),
                      border: OutlineInputBorder(
                      ),
                      labelText: "",
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Column(
                    children: [
                      Card(
                        elevation: 5,
                       shape: RoundedRectangleBorder(
                         borderRadius: BorderRadius.circular(10),
                       ),
                       child: Padding(
                         padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                         child: Column(
                           children: const [
                             // Dine In
                             Image(image: AssetImage("images/dinein.png"),),
                             Opacity(
                               opacity : 0.5,
                               child:   Text(
                                   "Dine In",
                                   style: TextStyle(
                                       color:  Color(0xff042e60),
                                       fontWeight: FontWeight.w700,
                                       fontFamily: "SFUIText",
                                       fontStyle:  FontStyle.normal,
                                       fontSize: 9.9
                                   ),
                                   textAlign: TextAlign.left
                               ),
                             )
                           ],
                         ),
                       ),
                      ),

                      Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: const Icon(
                          Icons.check,
                          color: Color(0xff042e60),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                          child: Column(
                            children: const [
                              // Dine In
                              Image(image: AssetImage("images/takeaway.png"),),
                              Opacity(
                                opacity : 0.5,
                                child:   Text(
                                    "Take Away",
                                    style: TextStyle(
                                        color:  Color(0xff042e60),
                                        fontWeight: FontWeight.w700,
                                        fontFamily: "SFUIText",
                                        fontStyle:  FontStyle.normal,
                                        fontSize: 9.9
                                    ),
                                    textAlign: TextAlign.left
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: const Icon(
                          Icons.check,
                          color: Color(0xff042e60),
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
                        /*Navigator.pushNamedAndRemoveUntil(
                            context, OtpScreen.id, (route) => false);*/
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
              ),
              // You can select any of one option from these (you can change it later
            ],
          ),
        ),
      ),
    );
  }
}
