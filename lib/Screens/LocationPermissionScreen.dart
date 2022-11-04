import 'package:eatplek/Components/LoginButton.dart';
import 'package:eatplek/Constants.dart';
import 'package:flutter/material.dart';

class LocationPermissionScreen extends StatefulWidget {
  static const String id = '/location';
  const LocationPermissionScreen({Key? key}) : super(key: key);

  @override
  State<LocationPermissionScreen> createState() =>
      _LocationPermissionScreenState();
}

class _LocationPermissionScreenState extends State<LocationPermissionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: primaryclr,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Location Permission Required",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontFamily: 'SFUIText',
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.location_on,
                      size: 200,
                      color: Colors.white,
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "Why we need location permission ? ",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontFamily: 'SFUIText',
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 9),
                      child: Text(
                        "Eatplek access your location solely for the purpose of showing the restaurants in your location.",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontFamily: 'SFUIText',
                        ),
                      ),
                    )
                  ],
                ),
                LoginButton(
                  text: "Allow",
                  clr: Colors.white,
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
