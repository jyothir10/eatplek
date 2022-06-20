import 'package:flutter/material.dart';

class optionScreenTextField extends StatelessWidget {
  final String text;

  const optionScreenTextField({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Text(
              text,
              style: const TextStyle(
                  color: Color(0x61ffffff),
                  fontWeight: FontWeight.w500,
                  fontFamily: "SFUIText",
                  fontStyle: FontStyle.normal,
                  fontSize: 16.0),
              textAlign: TextAlign.left),
        ),
        const TextField(
          style: TextStyle(color: Colors.white),
          keyboardType: TextInputType.name,
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
                borderSide: BorderSide(
                  color: Color(0xffffffff),
                )),
            border: OutlineInputBorder(),
            hintText: "",
          ),
        ),
      ],
    );
  }
}
