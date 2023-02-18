import 'dart:convert';

import 'package:eatplek/Components/EditProfileTextField.dart';
import 'package:eatplek/Components/ProfileButton.dart';
import 'package:eatplek/Screens/ProfileScreen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Constants.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);
  static const String id = '/editprofile';

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String msg = "";
  bool showSpinner = false;

  updateUser() async {
    showSpinner = true;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString("token");

    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Token": token.toString(),
    };
    Map body1 = {
      "name": nameController.text.trim(),
      "email": emailController.text.trim(),
    };

    final body = jsonEncode(body1);
    var urlfinal = Uri.https(URL_Latest, '/user');

    http.Response response =
        await http.put(urlfinal, headers: headers, body: body);

    if ((response.statusCode >= 200) && (response.statusCode < 300)) {
      final jsonData = jsonDecode(response.body);
      msg = await jsonData['message'];
      if (msg == "User updated successfully") {
        _scaffoldKey.currentState?.showSnackBar(const SnackBar(
            behavior: SnackBarBehavior.floating,
            duration: Duration(seconds: 1),
            content: Text("User updated successfully")));
      } else {
        _scaffoldKey.currentState?.showSnackBar(const SnackBar(
            behavior: SnackBarBehavior.floating,
            duration: Duration(seconds: 1),
            content: Text("Could not update user")));
      }
      nameController.clear();
      emailController.clear();
      setState(() {
        showSpinner = false;
      });
    }
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    nameController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          'Edit Profile',
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'SFUIText',
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
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
        child: Container(
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              MediaQuery.of(context).viewInsets.bottom == 0
                  ? Stack(
                      children: [
                        const CircleAvatar(
                          backgroundColor: Color(0xffefeeee),
                          radius: 51.2,
                          child: Text(
                            "S",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 35.826087951660156,
                              fontFamily: 'SFUIText',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        // Positioned(
                        //   top: 65,
                        //   left: 65,
                        //   child: InkWell(
                        //     onTap: () {},
                        //     child: Image.asset(
                        //       "images/edit_profile.png",
                        //       height: 45,
                        //     ),
                        //   ),
                        // )
                      ],
                    )
                  : Container(),
              SizedBox(
                height: MediaQuery.of(context).size.height * .4,
                child: Column(
                  children: [
                    EditProfileTextField(
                      myController: nameController,
                      text: 'Name',
                      type: TextInputType.name,
                    ),
                    EditProfileTextField(
                      myController: emailController,
                      text: 'E-mail',
                      type: TextInputType.emailAddress,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 30),
                child: ProfileButton(
                    text: "        Save        ",
                    onTap: () {
                      Navigator.pushNamedAndRemoveUntil(
                          context, ProfileScreen.id, (route) => false);
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
