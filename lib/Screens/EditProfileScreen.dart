import 'package:eatplek/Components/EditProfileTextField.dart';
import 'package:eatplek/Components/ProfileButton.dart';
import 'package:flutter/material.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);
  static const String id = '/editprofile';

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final myController1 = TextEditingController();
  final myController2 = TextEditingController();
  final myController3 = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    myController1.dispose();
    myController2.dispose();
    myController3.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Padding(
                padding: EdgeInsets.only(right: 39),
                child: Text(
                  'Edit Profile',
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'SFUIText',
                    fontWeight: FontWeight.w600,
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Stack(
                children: [
                  CircleAvatar(
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
                  Positioned(
                    top: 65,
                    left: 65,
                    child: InkWell(
                      onTap: () {},
                      child: Image.asset(
                        "images/edit_profile.png",
                        height: 45,
                      ),
                    ),
                  )
                ],
              ),
              EditProfileTextField(
                myController: myController1,
                text: 'Name',
              ),
              EditProfileTextField(
                myController: myController2,
                text: 'Phone',
              ),
              EditProfileTextField(
                myController: myController3,
                text: 'E-mail(Optional)',
              ),
              ProfileButton(
                  text: "Save",
                  onTap: () {
                    //todo:Save settings
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
