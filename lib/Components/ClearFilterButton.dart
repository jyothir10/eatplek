import 'package:flutter/material.dart';

class ClearFilterButton extends StatelessWidget {
  final String text;
  final void Function()? onTap;
  const ClearFilterButton({
    Key? key,
    required this.text,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * .38,
      height: MediaQuery.of(context).size.height * .039,
      child: ElevatedButton(
        onPressed: onTap,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
          shape: MaterialStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.1))),
        ),
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 13,
            fontFamily: 'SFUIText',
          ),
        ),
      ),
    );
  }
}
