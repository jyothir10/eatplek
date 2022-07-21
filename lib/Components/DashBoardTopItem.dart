import 'package:flutter/material.dart';

class DashBoardTopItem extends StatelessWidget {
  final String img;
  final String text;
  const DashBoardTopItem({Key? key, required this.text, required this.img})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Container(
        height: 44,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CircleAvatar(
              radius: 28,
              backgroundImage: AssetImage(img),
              backgroundColor: Colors.transparent,
            ),
            Text(
              text,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 9.5,
                fontFamily: 'SFUIText',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
