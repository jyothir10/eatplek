import 'package:eatplek/Constants.dart';
import 'package:flutter/material.dart';

class EditProfileTextField extends StatelessWidget {
  final TextEditingController myController;
  final String text;
  const EditProfileTextField({
    Key? key,
    required this.myController,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 21),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                text,
                style: editprofilestyle,
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 21),
          child: TextField(
            controller: myController,
            cursorColor: const Color(0x80000000),
            onChanged: (text) {},
            style: const TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontFamily: 'SFUIText',
              fontWeight: FontWeight.w500,
            ),
            decoration: InputDecoration(
              suffixIcon: InkWell(
                onTap: () {
                  myController.clear();
                },
                child: Image.asset("images/cross.png"),
              ),
              enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0x80000000)),
              ),
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0x80000000)),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
