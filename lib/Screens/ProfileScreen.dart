import 'package:eatplek/Components/BottomBar.dart';
import 'package:eatplek/Components/ProfileButton.dart';
import 'package:eatplek/Components/ProfileOption.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  static const String id = '/profile';

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  DateTime? currentBackPressTime;
  String name = 'Elizabeth Rachel Yohannan';

  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      print("helllo");
      //showToast("Press back again to exit");

      // Toast.show("Press back again to exit",
      //     duration: Toast.lengthShort, gravity: Toast.bottom);
      return Future.value(false);
    }
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            CircleAvatar(
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
                      onTap: () {},
                    ),
                    ProfileOption(
                      text: "Notifications",
                      img: 'notification',
                      onTap: () {},
                    ),
                    ProfileOption(
                      text: "Send Feedback",
                      img: 'feedback',
                      onTap: () {},
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
              text: 'Log Out',
              onTap: () {
                //todo:Logout
              },
            ),
          ],
        ),
      ),
    );
  }
}
