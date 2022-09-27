import 'package:eatplek/Screens/ProfileScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RefundPolicyScreen extends StatefulWidget {
  static const String id = '/refund';

  const RefundPolicyScreen({Key? key}) : super(key: key);

  @override
  State<RefundPolicyScreen> createState() => _RefundPolicyScreenState();
}

class _RefundPolicyScreenState extends State<RefundPolicyScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
      Navigator.pushReplacementNamed(context, ProfileScreen.id);
      return false;
    },
    child: Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_outlined,
            color: Color(0xff000000),
          ),
        ),
        title: Text(
          'Refund Policy',
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'SFUIText',
            fontWeight: FontWeight.w600,
            fontSize: 15,
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.white,
        child: Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Column(
                children: [
                  const Text(
                    'No Refunds on Cancellations',
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'SFUIText',
                      fontSize: 14,
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