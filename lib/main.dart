import 'package:eatplek/Screens/DashBoardScreen.dart';
import 'package:eatplek/Screens/EditProfileScreen.dart';
import 'package:eatplek/Screens/FeedbackScreen.dart';
import 'package:eatplek/Screens/FoodScreen.dart';
import 'package:eatplek/Screens/InvoiceScreen.dart';
import 'package:eatplek/Screens/LoginScreen.dart';
import 'package:eatplek/Screens/NotificationScreen.dart';
import 'package:eatplek/Screens/OnboardingScreen.dart';
import 'package:eatplek/Screens/OrderHistoryScreen.dart';
import 'package:eatplek/Screens/OrderScreen.dart';
import 'package:eatplek/Screens/OtpScreen.dart';
import 'package:eatplek/Screens/ProfileScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'Screens/optionScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: OnboardingScreen.id,
        routes: {
          OnboardingScreen.id: (context) => OnboardingScreen(),
          LoginScreen.id: (context) => LoginScreen(),
          OtpScreen.id: (context) => OtpScreen(),
          OptionScreen.id: (context) => OptionScreen(),
          ProfileScreen.id: (context) => ProfileScreen(),
          EditProfileScreen.id: (context) => EditProfileScreen(),
          FeedbackScreen.id: (context) => FeedbackScreen(),
          DashBoardScreen.id: (context) => DashBoardScreen(),
          NotificationScreen.id: (context) => NotificationScreen(),
          OrderHistoryScreen.id: (context) => OrderHistoryScreen(),
          InvoiceScreen.id: (context) => InvoiceScreen(),
          FoodScreen.id: (context) => FoodScreen(),
          OrderScreen.id: (context) => OrderScreen(),
        });
  }
}
