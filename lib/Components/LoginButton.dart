import 'package:eatplek/Constants.dart';
import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {
  final void Function()? onPressed;
  final String text;
  final Color clr;

  LoginButton(
      {Key? key,
      required this.onPressed,
      required this.text,
      required this.clr})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * .85,
      height: MediaQuery.of(context).size.height * .05,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(clr),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8)))),
        child: Text(
          text,
          style: const TextStyle(
            color: primaryclr,
            fontSize: 18,
            fontFamily: 'SFUIText',
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
