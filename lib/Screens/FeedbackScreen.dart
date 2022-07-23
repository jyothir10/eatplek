import 'package:eatplek/Components/ProfileButton.dart';
import 'package:eatplek/Constants.dart';
import 'package:flutter/material.dart';

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({Key? key}) : super(key: key);
  static const String id = '/feedback';

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Padding(
              padding: EdgeInsets.only(right: 39),
              child: Text(
                'Feedback',
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'SFUIText',
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back,
            color: Color(0xff1A191A),
          ),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextField(
                cursorWidth: 1,
                cursorColor: primaryclr,
                keyboardType: TextInputType.multiline,
                maxLines: 9,
                textAlign: TextAlign.start,
                decoration: InputDecoration(
                  alignLabelWithHint: true,
                  focusColor: primaryclr,
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 2.0),
                    borderRadius: BorderRadius.circular(21.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: primaryclr, width: 1.0),
                    borderRadius: BorderRadius.circular(21.0),
                  ),
                  label: const Text(
                    'Tell us what you love about the app, or what we could be doing better',
                    style: TextStyle(
                        color: Color(0x59000000),
                        fontSize: 11,
                        fontFamily: 'SFUIText',
                        height: 1.5),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 21),
                child: ProfileButton(
                    text: "       Sent       ",
                    onTap: () {
                      Navigator.pop(context);
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
