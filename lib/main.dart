import 'package:eatplek/Screens/LoginScreen.dart';
import 'package:eatplek/Screens/OtpScreen.dart';
import 'Screens/optionScreen.dart';
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
        initialRoute: OptionScreen.id,
        routes: {
          OptionScreen.id: (context) => OptionScreen(),
          LoginScreen.id: (context) => LoginScreen(),
          OtpScreen.id: (context) => OtpScreen(),
        });
  }
}
