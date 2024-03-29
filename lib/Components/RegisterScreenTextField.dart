import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RegisterScreenTextField extends StatelessWidget {
  final String text;
  final void Function(String)? onchanged;
  final TextEditingController controller;
  final TextInputType type;
  final int maxLength;
  final List<TextInputFormatter>? inputFormatters;

  const RegisterScreenTextField({
    Key? key,
    required this.text,
    required this.onchanged,
    required this.controller,
    required this.type,
    required this.maxLength,
    required this.inputFormatters,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Text(text,
              style: const TextStyle(
                  color: Color(0x61ffffff),
                  fontWeight: FontWeight.w500,
                  fontFamily: "SFUIText",
                  fontStyle: FontStyle.normal,
                  fontSize: 16.0),
              textAlign: TextAlign.left),
        ),
        TextField(
          inputFormatters: inputFormatters,
          maxLength: maxLength,
          keyboardType: type,
          controller: controller,
          onChanged: onchanged,
          cursorColor: Colors.white,
          style: const TextStyle(color: Colors.white, fontSize: 18),
          decoration: const InputDecoration(
            fillColor: Colors.white,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
              borderSide: BorderSide(
                color: Color(0xffffffff),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
              borderSide: BorderSide(
                color: Color(0xffffffff),
              ),
            ),
            hintText: "",
          ),
        ),
      ],
    );
  }
}
