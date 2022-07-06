import 'package:eatplek/Components/BottomBar.dart';
import 'package:eatplek/Components/ProfileButton.dart';
import 'package:eatplek/Components/ProfileOption.dart';
import 'package:eatplek/Screens/EditProfileScreen.dart';
import 'package:eatplek/Screens/FeedbackScreen.dart';
import 'package:eatplek/Screens/NotificationScreen.dart';
import 'package:flutter/material.dart';

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
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 9),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      'My Profile',
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'SFUIText',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
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
                padding: const EdgeInsets.only(top: 9),
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
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Container(
                  height: MediaQuery.of(context).size.height * .3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ProfileOption(
                          text: "Edit Profile",
                          img: 'edit',
                          onTap: () {
                            Navigator.pushNamed(context, EditProfileScreen.id);
                          }),
                      ProfileOption(
                        text: "Notifications",
                        img: 'notification',
                        onTap: () {
                          Navigator.pushNamed(context, NotificationScreen.id);
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
                    ],
                  ),
                ),
              ),
              ProfileButton(
                text: '       Log Out       ',
                onTap: () {
                  //todo:Logout
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
