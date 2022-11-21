import 'dart:convert';

import 'package:eatplek/Components/optionScreenTextField.dart';
import 'package:eatplek/Constants.dart';
import 'package:eatplek/Screens/LoginScreen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Exceptions/api_exception.dart';

class RegisterScreen extends StatefulWidget {
  static const String id = '/option';
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String name = '', email = '', password = '', phone = '';
  bool showSpinner = false;
  DateTime? currentBackPressTime;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  TextEditingController namecontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  bool status = false;
  String msg = "";

  static bool isRequestSucceeded(int statusCode) {
    return statusCode >= 200 && statusCode < 300;
  }

  register() async {
    setState(() {
      showSpinner = true;
    });

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Token": sharedPreferences.getString("token").toString(),
    };

    Map body1 = {
      "name": namecontroller.text.trim(),
      "email": emailcontroller.text.trim(),
      "phone": phoneController.text.trim(),
      "password": passwordController.text.trim(),
    };
    final body = jsonEncode(body1);

    var urlfinal = Uri.https(URL_Latest, '/user/register');

    var res = await http.post(urlfinal, headers: headers, body: body);

    final responseBody = json.decode(res.body);

    print(responseBody);

    if (isRequestSucceeded(res.statusCode)) {
      status = true;
      msg = await responseBody['message'];

      if (msg == "User registered successfully, verification email sent") {
        _scaffoldKey.currentState?.showSnackBar(const SnackBar(
            behavior: SnackBarBehavior.floating,
            duration: Duration(seconds: 3),
            content: Text(
                "A verification link has been sent to your email. Please verify to activate your account")));
        Navigator.pushNamedAndRemoveUntil(
            context, LoginScreen.id, (route) => false);
      } else {
        if (status == false) {
          _scaffoldKey.currentState?.showSnackBar(
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
      _scaffoldKey.currentState?.showSnackBar(
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

  Color buttonColour = Color(0xffc6c6cc);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Container(
          color: primaryclr,
          child: SafeArea(
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
                      Text("Register New User",
                          style: TextStyle(
                              color: Color(0xffffffff),
                              fontWeight: FontWeight.w700,
                              fontFamily: "SFUIText",
                              fontStyle: FontStyle.normal,
                              fontSize: 24.0),
                          textAlign: TextAlign.left),
                    ],
                  ),
                  optionScreenTextField(
                    controller: namecontroller,
                    onchanged: (value) {
                      name = value;
                    },
                    text: "Name",
                  ),
                  optionScreenTextField(
                    controller: emailcontroller,
                    onchanged: (value) {
                      email = value;
                    },
                    text: "Email",
                  ),
                  optionScreenTextField(
                    controller: phoneController,
                    onchanged: (value) {
                      phone = value;
                    },
                    text: "Phone",
                  ),
                  optionScreenTextField(
                    controller: passwordController,
                    onchanged: (value) {
                      password = value;
                    },
                    text: "Password",
                  ),
                  // MediaQuery.of(context).viewInsets.bottom == 0
                  //     ? Row(
                  //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //         children: [
                  //           Column(
                  //             children: [
                  //               Container(
                  //                 height:
                  //                     MediaQuery.of(context).size.height * .1,
                  //                 width:
                  //                     MediaQuery.of(context).size.width * .21,
                  //                 decoration: BoxDecoration(
                  //                   borderRadius: const BorderRadius.all(
                  //                     Radius.circular(15),
                  //                   ),
                  //                   color: d == 0
                  //                       ? Color(0xff8196af)
                  //                       : Color(0xffffffff),
                  //                 ),
                  //                 child: InkWell(
                  //                   onTap: () {
                  //                     setState(() {
                  //                       d = 1;
                  //                       t = 0;
                  //                       if ((d != 0 || t != 0) &
                  //                           (name.isNotEmpty)) {
                  //                         buttonColour = Colors.white;
                  //                       }
                  //                     });
                  //                   },
                  //                   child: Column(
                  //                     mainAxisAlignment:
                  //                         MainAxisAlignment.center,
                  //                     children: [
                  //                       // Dine In
                  //                       Image(
                  //                         height: MediaQuery.of(context)
                  //                                 .size
                  //                                 .height *
                  //                             .06,
                  //                         image:
                  //                             AssetImage("images/dinein.png"),
                  //                       ),
                  //                       const Opacity(
                  //                         opacity: 0.5,
                  //                         child: Padding(
                  //                           padding: EdgeInsets.only(top: 2),
                  //                           child: Text("Dine In",
                  //                               style: TextStyle(
                  //                                   color: primaryclr,
                  //                                   fontWeight:
                  //                                       FontWeight.w700,
                  //                                   fontFamily: "SFUIText",
                  //                                   fontStyle:
                  //                                       FontStyle.normal,
                  //                                   fontSize: 9.9),
                  //                               textAlign: TextAlign.left),
                  //                         ),
                  //                       )
                  //                     ],
                  //                   ),
                  //                 ),
                  //               ),
                  //               Padding(
                  //                 padding: EdgeInsets.only(
                  //                     top:
                  //                         MediaQuery.of(context).size.height *
                  //                             .01),
                  //                 child: Card(
                  //                   color: d == 0
                  //                       ? Color(0xff8196af)
                  //                       : Color(0xffffffff),
                  //                   elevation: 5,
                  //                   shape: RoundedRectangleBorder(
                  //                     borderRadius: BorderRadius.circular(15),
                  //                   ),
                  //                   child: const Icon(
                  //                     Icons.check,
                  //                     size: 25,
                  //                     color: primaryclr,
                  //                   ),
                  //                 ),
                  //               ),
                  //             ],
                  //           ),
                  //           Column(
                  //             children: [
                  //               Container(
                  //                 height:
                  //                     MediaQuery.of(context).size.height * .1,
                  //                 width:
                  //                     MediaQuery.of(context).size.width * .21,
                  //                 decoration: BoxDecoration(
                  //                   borderRadius: const BorderRadius.all(
                  //                     Radius.circular(15),
                  //                   ),
                  //                   color: t == 0
                  //                       ? Color(0xff8196af)
                  //                       : Color(0xffffffff),
                  //                 ),
                  //                 child: InkWell(
                  //                   onTap: () {
                  //                     setState(() {
                  //                       t = 1;
                  //                       d = 0;
                  //                       if ((d != 0 || t != 0) &
                  //                           (name.isNotEmpty)) {
                  //                         buttonColour = Colors.white;
                  //                       }
                  //                     });
                  //                   },
                  //                   child: Column(
                  //                     mainAxisAlignment:
                  //                         MainAxisAlignment.center,
                  //                     children: [
                  //                       // Dine In
                  //                       Image(
                  //                         height: MediaQuery.of(context)
                  //                                 .size
                  //                                 .height *
                  //                             .08,
                  //                         image: AssetImage(
                  //                             "images/takeaway.png"),
                  //                       ),
                  //                       const Opacity(
                  //                         opacity: 0.5,
                  //                         child: Text("Take Away",
                  //                             style: TextStyle(
                  //                                 color: primaryclr,
                  //                                 fontWeight: FontWeight.w700,
                  //                                 fontFamily: "SFUIText",
                  //                                 fontStyle: FontStyle.normal,
                  //                                 fontSize: 9.9),
                  //                             textAlign: TextAlign.left),
                  //                       )
                  //                     ],
                  //                   ),
                  //                 ),
                  //               ),
                  //               Padding(
                  //                 padding: EdgeInsets.only(
                  //                     top:
                  //                         MediaQuery.of(context).size.height *
                  //                             .01),
                  //                 child: Card(
                  //                   color: t == 0
                  //                       ? Color(0xff8196af)
                  //                       : Color(0xffffffff),
                  //                   elevation: 5,
                  //                   shape: RoundedRectangleBorder(
                  //                     borderRadius: BorderRadius.circular(15),
                  //                   ),
                  //                   child: const Icon(
                  //                     Icons.check,
                  //                     size: 25,
                  //                     color: primaryclr,
                  //                   ),
                  //                 ),
                  //               ),
                  //             ],
                  //           ),
                  //         ],
                  //       )
                  //     : Container(),
                  MediaQuery.of(context).viewInsets.bottom == 0
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * .83,
                              height: MediaQuery.of(context).size.height * .05,
                              child: ElevatedButton(
                                onPressed: () {
                                  if (email.isNotEmpty &
                                      name.isNotEmpty &
                                      password.isNotEmpty &
                                      phone.isNotEmpty) {
                                    register();
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
                                          buttonColour),
                                ),
                                child: const Text(
                                  'Register',
                                  style: TextStyle(
                                    color: primaryclr,
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