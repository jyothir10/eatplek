import 'dart:convert';

import 'package:eatplek/Components/BottomBar.dart';
import 'package:eatplek/Components/ProfileButton.dart';
import 'package:eatplek/Components/ProfileOption.dart';
import 'package:eatplek/Components/ProfileOption2.dart';
import 'package:eatplek/Screens/ContactUsScreen.dart';
import 'package:eatplek/Screens/EditProfileScreen.dart';
import 'package:eatplek/Screens/FeedbackScreen.dart';
import 'package:eatplek/Screens/LoginScreen.dart';
import 'package:eatplek/Screens/RefundPolicyScreen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Constants.dart';
import 'DashBoardScreen.dart';

class ProfileScreen extends StatefulWidget {
  static const String id = '/profile';

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String msg = "", name = "";
  bool showSpinner = true, fetched = false;
  var profile = null;

  getUser() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? userid = sharedPreferences.getString("id");

    Map<String, String> headers = {
      "Content-Type": "application/json",
    };
    var urlfinal = Uri.https(URL_Latest, '/user/$userid');

    http.Response response = await http.get(urlfinal, headers: headers);

    if ((response.statusCode >= 200) && (response.statusCode < 300)) {
      final jsonData = jsonDecode(response.body);
      msg = await jsonData['message'];
      if (msg == "User retrieved successfully") {
        profile = await jsonData['user'];
        name = profile['name'];
      }

      setState(() {
        print(profile['name']);
        showSpinner = false;
        fetched = true;
      });
    }
  }

  logout() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.clear();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUser();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacementNamed(context, DashBoardScreen.id);
        return false;
      },
      child: Scaffold(
        bottomNavigationBar: const BottomBar(
          index: 3,
        ),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          centerTitle: true,
          title: const Text(
            'My Profile',
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'SFUIText',
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
          leading: InkWell(
            onTap: () {
              Navigator.pushReplacementNamed(context, DashBoardScreen.id);
            },
            child: const Icon(
              Icons.arrow_back_outlined,
              color: Color(0xff000000),
            ),
          ),
        ),
        body: ModalProgressHUD(
          inAsyncCall: showSpinner,
          progressIndicator: CircularProgressIndicator(
            color: primaryclr,
          ),
          child: SafeArea(
            child: SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: profile != null && fetched == true
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              backgroundColor: Color(0xffefeeee),
                              radius: 51.2,
                              child: name.isNotEmpty
                                  ? Text(
                                      profile['name'][0].toString(),
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 35.826087951660156,
                                        fontFamily: 'SFUIText',
                                        fontWeight: FontWeight.w500,
                                      ),
                                    )
                                  : Text(
                                      "U",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 35.826087951660156,
                                        fontFamily: 'SFUIText',
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 9),
                              child: name.isNotEmpty
                                  ? Text(
                                      name,
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontFamily: 'SFUIText',
                                        fontWeight: FontWeight.w500,
                                      ),
                                    )
                                  : Text(
                                      "User",
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontFamily: 'SFUIText',
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 11),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(right: 8),
                                    child: Text(
                                      profile['email'],
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 10,
                                        fontFamily: 'SFUIText',
                                      ),
                                    ),
                                  ),
                                  Icon(
                                    Icons.circle_rounded,
                                    color: Color(0xff585757),
                                    size: 9,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 8),
                                    child:
                                        profile['phone'].toString().isNotEmpty
                                            ? Text(
                                                profile['phone'],
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 10,
                                                  fontFamily: 'SFUIText',
                                                ),
                                              )
                                            : Text(
                                                "+91 xxxxxxxxxx",
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 10,
                                                  fontFamily: 'SFUIText',
                                                ),
                                              ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 30),
                              child: Container(
                                height:
                                    MediaQuery.of(context).size.height * .35,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    ProfileOption(
                                        text: "Edit Profile",
                                        img: 'edit',
                                        onTap: () {
                                          Navigator.pushNamed(
                                              context, EditProfileScreen.id);
                                        }),
                                    // ProfileOption(
                                    //   text: "Notifications",
                                    //   img: 'notification',
                                    //   onTap: () {
                                    //     Navigator.pushNamed(
                                    //         context, NotificationScreen.id);
                                    //   },
                                    // ),
                                    ProfileOption(
                                      text: "Send Feedback",
                                      img: 'feedback',
                                      onTap: () {
                                        Navigator.pushNamed(
                                            context, FeedbackScreen.id);
                                      },
                                    ),
                                    const ProfileOption2(
                                      name: "Rate us on Play Store/App Store",
                                      icon: Icons.star_border_outlined,
                                      url:
                                          "https://play.google.com/store/apps/details?id=com.eatplek1.eatplek1",
                                    ),
                                    const ProfileOption2(
                                      name: "Privacy Policy",
                                      icon: Icons.note_add_outlined,
                                      url: "https://eatplek.com/privacy",
                                    ),
                                    const ProfileOption2(
                                        name: "Terms and Conditions",
                                        icon: Icons.note,
                                        url:
                                            "https://www.termsandconditionsgenerator.com/live.php?token=hfixwg5bdlwxlg7kcuqzbskqf59nr1xi"),
                                    InkWell(
                                      onTap: () {
                                        Navigator.pushNamed(
                                            context, RefundPolicyScreen.id);
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: const [
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    right: 11.5),
                                                child: Icon(
                                                  Icons.attach_money_outlined,
                                                  size: 17,
                                                  color: Colors.black,
                                                ),
                                              ),
                                              Text(
                                                "Refund Policy",
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 13,
                                                  fontFamily: 'SFUIText',
                                                ),
                                              ),
                                            ],
                                          ),
                                          const Icon(
                                            Icons.arrow_forward_ios,
                                            size: 17,
                                            color: Color(0x89292d32),
                                          ),
                                        ],
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Navigator.pushNamed(
                                            context, ContactUsScreen.id);
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: const [
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    right: 11.5),
                                                child: Icon(
                                                  Icons.phone,
                                                  size: 17,
                                                  color: Colors.black,
                                                ),
                                              ),
                                              Text(
                                                "Contact Us",
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 13,
                                                  fontFamily: 'SFUIText',
                                                ),
                                              ),
                                            ],
                                          ),
                                          const Icon(
                                            Icons.arrow_forward_ios,
                                            size: 17,
                                            color: Color(0x89292d32),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 40),
                              child: ProfileButton(
                                text: '       Log Out       ',
                                onTap: () {
                                  logout();
                                  Navigator.pushReplacementNamed(
                                      context, LoginScreen.id);
                                },
                              ),
                            ),
                          ],
                        )
                      : Center(
                          child: fetched == true && profile == null
                              ? Text(
                                  "Unable to fetch profile information",
                                  style: TextStyle(
                                    color: Color(0xff000000),
                                    fontWeight: FontWeight.w700,
                                    fontFamily: "SFUIText",
                                    fontStyle: FontStyle.normal,
                                    fontSize: 12.0,
                                  ),
                                )
                              : Container(),
                        ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
