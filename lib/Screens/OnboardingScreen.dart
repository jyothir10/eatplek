// import 'package:eatplek/Screens/LoginScreen.dart';
// import 'package:flutter/material.dart';
// import 'package:splashscreen/splashscreen.dart';
// import 'package:toast/toast.dart';
//
// class OnboardingScreen extends StatefulWidget {
//   static const String id = '/splash';
//
//   @override
//   State<OnboardingScreen> createState() => _OnboardingScreenState();
// }
//
// class _OnboardingScreenState extends State<OnboardingScreen> {
//   @override
//   void _onIntroEnd(context) {
//     //todo:add navigation
//   }
//   late DateTime currentBackPressTime;
//
//   Future<bool> onWillPop() {
//     DateTime now = DateTime.now();
//     if (currentBackPressTime == null ||
//         now.difference(currentBackPressTime) > const Duration(seconds: 2)) {
//       currentBackPressTime = now;
//
//       Toast.show("Press back again to exit",
//           duration: Toast.lengthShort, gravity: Toast.bottom);
//       return Future.value(false);
//     }
//     return Future.value(true);
//   }
//
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: onWillPop,
//       child: SplashScreen(
//         navigateAfterSeconds: LoginScreen(),
//         seconds: 5,
//         backgroundColor: const Color(0xff042e60),
//         image: Image.asset(
//           "images/logo.png",
//         ),
//         useLoader: false,
//         photoSize: MediaQuery.of(context).size.height * .25,
//       ),
//     );
//   }
// }
