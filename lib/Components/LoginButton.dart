import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {
  final void Function()? onPressed;
  final String text;

  LoginButton({Key? key, required this.onPressed, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Color(0xff042e60),
          fontSize: 18,
          fontFamily: 'SFUIText',
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
