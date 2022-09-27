import 'package:eatplek/Screens/ProfileScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ContactUsScreen extends StatefulWidget {
  static const String id = '/contact';

  const ContactUsScreen({Key? key}) : super(key: key);

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
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
            'Contact Us',
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
              padding: const EdgeInsets.only(top: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'Address: ',
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'SFUIText',
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            'Eatplek,Puthiya Keloth,Kayyankode\nCheleri PO,Kannur\nPIN:670604,Kerala,India',
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'SFUIText',
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Row(
                          children: const [
                            Text(
                              'Email: ',
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'SFUIText',
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              'eatplek@gmail.com',
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'SFUIText',
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              )
            ),
          ),
        ),
      ),
    );
  }
}