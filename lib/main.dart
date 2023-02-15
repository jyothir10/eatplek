import 'package:eatplek/Screens/ContactUsScreen.dart';
import 'package:eatplek/Screens/DashBoardScreen.dart';
import 'package:eatplek/Screens/EditProfileScreen.dart';
import 'package:eatplek/Screens/FeedbackScreen.dart';
import 'package:eatplek/Screens/FoodScreen.dart';
import 'package:eatplek/Screens/InvoiceScreen.dart';
import 'package:eatplek/Screens/LocationPermissionScreen.dart';
import 'package:eatplek/Screens/LoginScreen.dart';
import 'package:eatplek/Screens/NotificationScreen.dart';
import 'package:eatplek/Screens/OnboardingScreen.dart';
import 'package:eatplek/Screens/OrderHistoryScreen.dart';
import 'package:eatplek/Screens/ProfileScreen.dart';
import 'package:eatplek/Screens/RefundPolicyScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'Screens/CartScreen.dart';
import 'Screens/RegisterScreen.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('Handling a background message ${message.messageId}');
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
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
        initialRoute: LoginScreen.id,
        routes: {
          OnboardingScreen.id: (context) => OnboardingScreen(),
          LoginScreen.id: (context) => LoginScreen(),
          // OtpScreen.id: (context) => OtpScreen(),
          RegisterScreen.id: (context) => RegisterScreen(),
          ProfileScreen.id: (context) => ProfileScreen(),
          EditProfileScreen.id: (context) => EditProfileScreen(),
          FeedbackScreen.id: (context) => FeedbackScreen(),
          DashBoardScreen.id: (context) => DashBoardScreen(),
          NotificationScreen.id: (context) => NotificationScreen(),
          OrderHistoryScreen.id: (context) => OrderHistoryScreen(),
          InvoiceScreen.id: (context) => InvoiceScreen(
                orderId: "",
              ),
          FoodScreen.id: (context) => FoodScreen(),
          CartScreen.id: (context) => CartScreen(),
          RefundPolicyScreen.id: (context) => RefundPolicyScreen(),
          ContactUsScreen.id: (context) => ContactUsScreen(),
          LocationPermissionScreen.id: (context) => LocationPermissionScreen(),
        });
  }
}
