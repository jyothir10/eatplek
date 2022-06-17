import 'package:eatplek/Screens/LoginScreen.dart';
import 'package:eatplek/Screens/OtpScreen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: OtpScreen.id,
        routes: {
          //OnboardingScreen.id: (context) => OnboardingScreen(),
          LoginScreen.id: (context) => LoginScreen(),
          OtpScreen.id: (context) => OtpScreen(),
        });
  }
}
