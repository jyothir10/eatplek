import 'package:eatplek/Components/BottomBar.dart';
import 'package:eatplek/Components/ProfileButton.dart';
import 'package:eatplek/Components/ProfileOption.dart';
import 'package:eatplek/Screens/ContactUsScreen.dart';
import 'package:eatplek/Screens/EditProfileScreen.dart';
import 'package:eatplek/Screens/FeedbackScreen.dart';
import 'package:eatplek/Screens/LoginScreen.dart';
import 'package:eatplek/Screens/NotificationScreen.dart';
import 'package:eatplek/Screens/RefundPolicyScreen.dart';
import 'package:flutter/material.dart';
import 'package:eatplek/Components/ProfileOption2.dart';
import 'DashBoardScreen.dart';

class ProfileScreen extends StatefulWidget {
  static const String id = '/profile';

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String name = 'Elizabeth Rachel Yohannan';

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
        ),
        body: SafeArea(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const CircleAvatar(
                    backgroundColor: Color(0xffefeeee),
                    radius: 51.2,
                    child: Text(
                      "S",
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
                    child: Text(
                      name,
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
                      children: const [
                        Padding(
                          padding: EdgeInsets.only(right: 8),
                          child: Text(
                            'eli00@gmail.com',
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
                          child: Text(
                            '9207025428',
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
                    padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 10),
                    child: Container(
                      height: MediaQuery.of(context).size.height * .3,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ProfileOption(
                              text: "Edit Profile",
                              img: 'edit',
                              onTap: () {
                                Navigator.pushNamed(
                                    context, EditProfileScreen.id);
                              }),
                          ProfileOption(
                            text: "Notifications",
                            img: 'notification',
                            onTap: () {
                              Navigator.pushNamed(
                                  context, NotificationScreen.id);
                            },
                          ),
                          ProfileOption(
                            text: "Send Feedback",
                            img: 'feedback',
                            onTap: () {
                              Navigator.pushNamed(context, FeedbackScreen.id);
                            },
                          ),
                          ProfileOption(
                            text: "Rate us on Play Store/App Store",
                            img: 'Star',
                            onTap: () {},
                          ),
                          const ProfileOption2(
                            name: "Privacy Policy",
                            icon: Icons.note_add_outlined,
                            url:
                                "https://www.privacypolicygenerator.info/live.php?token=QodIHXmWRXsLVGBtzyIneaLlyzAgQG0G",
                          ),
                          const ProfileOption2(
                              name: "Terms and Conditions",
                              icon: Icons.note,
                              url:
                                  "https://www.termsandconditionsgenerator.com/live.php?token=hfixwg5bdlwxlg7kcuqzbskqf59nr1xi"),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: const [
                                  Padding(
                                    padding: EdgeInsets.only(right: 11.5),
                                    child: Icon(
                                      Icons.attach_money_outlined,
                                      size: 17,
                                      color: Color(0x89292d32),
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
                              GestureDetector(
                                child: const Icon(
                                  Icons.arrow_forward_ios,
                                  size: 17,
                                  color: Color(0x89292d32),
                                ),
                                onTap: (){
                                  Navigator.pushNamed(context, RefundPolicyScreen.id);
                                },
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: const [
                                  Padding(
                                    padding: EdgeInsets.only(right: 11.5),
                                    child: Icon(
                                      Icons.phone,
                                      size: 17,
                                      color: Color(0x89292d32),
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
                              GestureDetector(
                                child: const Icon(
                                  Icons.arrow_forward_ios,
                                  size: 17,
                                  color: Color(0x89292d32),
                                ),
                                onTap: (){
                                  Navigator.pushNamed(context, ContactUsScreen.id);
                                },
                              ),
                            ],
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
                        //todo:Logout
                        Navigator.pushReplacementNamed(context, LoginScreen.id);
                      },
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
