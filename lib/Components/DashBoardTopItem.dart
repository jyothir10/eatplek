import 'package:flutter/material.dart';

class DashBoardTopItem extends StatelessWidget {
  final String img;
  final String text;
  const DashBoardTopItem({Key? key, required this.text, required this.img})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.09,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CircleAvatar(
              radius: 23,
              backgroundImage: AssetImage(img),
              backgroundColor: Colors.transparent,
            ),
            Text(
              text,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 7,
                fontFamily: 'SFUIText',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
