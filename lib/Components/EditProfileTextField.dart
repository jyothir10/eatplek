import 'package:eatplek/Constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EditProfileTextField extends StatelessWidget {
  final TextEditingController myController;
  final String text;
  final TextInputType type;
  final int maxLength;
  final List<TextInputFormatter>? inputFormatters;

  const EditProfileTextField({
    Key? key,
    required this.myController,
    required this.text,
    required this.type,
    required this.maxLength,
    required this.inputFormatters,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 13),
      child: Column(
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
              inputFormatters: inputFormatters,
              maxLength: maxLength,
              controller: myController,
              keyboardType: type,
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
      ),
    );
  }
}
