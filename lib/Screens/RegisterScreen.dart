import 'dart:convert';

import 'package:eatplek/Components/RegisterScreenTextField.dart';
import 'package:eatplek/Constants.dart';
import 'package:eatplek/Screens/DashBoardScreen.dart';
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
  String name = '', email = '';
  bool showSpinner = false, isObscure = true;
  DateTime? currentBackPressTime;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  TextEditingController namecontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();

  bool status = false;
  String msg = "";

  static bool isRequestSucceeded(int statusCode) {
    return statusCode >= 200 && statusCode < 300;
  }

  register() async {
    setState(() {
      showSpinner = true;
      FocusManager.instance.primaryFocus?.unfocus();
    });

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString("token");

    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Token": token.toString(),
    };

    Map body1 = {
      "name": namecontroller.text.trim(),
      "email": emailcontroller.text.trim(),
    };
    final body = jsonEncode(body1);

    var urlfinal = Uri.http(URL_Latest, '/user');

    var res = await http.put(urlfinal, headers: headers, body: body);

    final responseBody = json.decode(res.body);

    if (isRequestSucceeded(res.statusCode)) {
      status = true;
      msg = await responseBody['message'];

      if (msg == "User updated successfully") {
        Navigator.pushNamedAndRemoveUntil(
            context, DashBoardScreen.id, (route) => false);
      } else {
        if (status == false) {
          ScaffoldMessenger.of(context)
            ..showSnackBar(
              SnackBar(
                behavior: SnackBarBehavior.floating,
                duration: Duration(seconds: 1),
                content: Text(
                  "Could not register user!",
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
      ScaffoldMessenger.of(context)
        ..showSnackBar(
          SnackBar(
            behavior: SnackBarBehavior.floating,
            duration: Duration(seconds: 1),
            content: Text(
              "Could not register user!",
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
  void dispose() {
    emailcontroller.dispose();
    namecontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        progressIndicator: CircularProgressIndicator(
          color: Colors.white,
        ),
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
                  RegisterScreenTextField(
                    controller: namecontroller,
                    onchanged: (value) {
                      name = value;
                      if (email.isNotEmpty & name.isNotEmpty) {
                        buttonColour = Colors.white;
                      }
                    },
                    text: "Name",
                  ),
                  RegisterScreenTextField(
                    controller: emailcontroller,
                    onchanged: (value) {
                      email = value;
                      if (email.isNotEmpty & name.isNotEmpty) {
                        buttonColour = Colors.white;
                      }
                    },
                    text: "Email",
                  ),
                  // RegisterScreenTextField(
                  //   controller: phoneController,
                  //   onchanged: (value) {
                  //     phone = value;
                  //   },
                  //   text: "Phone",
                  // ),
                  //
                  // Column(
                  //   crossAxisAlignment: CrossAxisAlignment.start,
                  //   children: [
                  //     Padding(
                  //       padding: const EdgeInsets.only(bottom: 10),
                  //       child: Text("Password",
                  //           style: const TextStyle(
                  //               color: Color(0x61ffffff),
                  //               fontWeight: FontWeight.w500,
                  //               fontFamily: "SFUIText",
                  //               fontStyle: FontStyle.normal,
                  //               fontSize: 16.0),
                  //           textAlign: TextAlign.left),
                  //     ),
                  //     TextField(
                  //       obscureText: isObscure,
                  //       controller: passwordController,
                  //       onChanged: (value) {
                  //         password = value;
                  //       },
                  //       style: const TextStyle(color: Colors.white),
                  //       keyboardType: TextInputType.name,
                  //       decoration: InputDecoration(
                  //         fillColor: Colors.white,
                  //         enabledBorder: OutlineInputBorder(
                  //           borderRadius: BorderRadius.all(
                  //             Radius.circular(10),
                  //           ),
                  //           borderSide: BorderSide(
                  //             color: Color(0xffffffff),
                  //           ),
                  //         ),
                  //         focusedBorder: OutlineInputBorder(
                  //           borderRadius: BorderRadius.all(
                  //             Radius.circular(10),
                  //           ),
                  //           borderSide: BorderSide(
                  //             color: Color(0xffffffff),
                  //           ),
                  //         ),
                  //         hintText: "",
                  //         suffixIcon: GestureDetector(
                  //           onTap: () {
                  //             setState(() {
                  //               isObscure == true
                  //                   ? isObscure = false
                  //                   : isObscure = true;
                  //             });
                  //           },
                  //           child: isObscure == true
                  //               ? Icon(
                  //                   Icons.visibility,
                  //                   color: Colors.white,
                  //                 )
                  //               : Icon(
                  //                   Icons.visibility_off,
                  //                   color: Colors.white,
                  //                 ),
                  //         ),
                  //       ),
                  //     ),
                  //   ],
                  // ),
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
                                  if (email.isNotEmpty & name.isNotEmpty) {
                                    register();
                                  } else {
                                    ScaffoldMessenger.of(context)
                                      ..showSnackBar(const SnackBar(
                                          behavior: SnackBarBehavior.floating,
                                          duration: Duration(seconds: 1),
                                          content:
                                              Text("Please fill all details")));
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
