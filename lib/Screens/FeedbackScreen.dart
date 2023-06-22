import 'dart:convert';

import 'package:eatplek/Components/ProfileButton.dart';
import 'package:eatplek/Constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../Exceptions/api_exception.dart';

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({Key? key}) : super(key: key);
  static const String id = '/feedback';

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  static const except = {'exc': 'An error occured'};
  TextEditingController feedbackController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool showSpinner = false;
  String feedback = "";

  giveFeedback() async {
    setState(() {
      showSpinner = true;
    });
    Map<String, String> headers = {
      "Content-Type": "application/json",
    };
    var urlfinal = Uri.http(URL_Latest, '/feedback');

    Map body1 = {
      "feedback": feedback,
    };
    final body = jsonEncode(body1);

    http.Response response =
        await http.post(urlfinal, headers: headers, body: body);

    if ((response.statusCode >= 200) && (response.statusCode < 300)) {
      final jsonData = await jsonDecode(response.body);

      if (jsonData['message'] == "Feedback created") {
        showSpinner = false;
        ScaffoldMessenger.of(context)
          ..showSnackBar(const SnackBar(
              behavior: SnackBarBehavior.floating,
              duration: Duration(seconds: 1),
              content: Text("Feedback sent successfully")));
        feedbackController.clear();
      }

      setState(() {});
    } else
      APIException(response.statusCode, except);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    feedbackController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
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
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        progressIndicator: CircularProgressIndicator(
          color: primaryclr,
        ),
        child: Container(
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
                  maxLength: 250,
                  textAlign: TextAlign.start,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]")),
                  ],
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
                  onChanged: (value) {
                    feedback = value;
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 21),
                  child: ProfileButton(
                      text: "       Sent       ",
                      onTap: () {
                        giveFeedback();
                      }),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
