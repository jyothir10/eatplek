import 'package:flutter/material.dart';

class ProfileOption extends StatelessWidget {
  final String text;
  final String img;
  final void Function()? onTap;
  const ProfileOption({
    Key? key,
    required this.text,
    required this.img,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 9),
                child: Image.asset(
                  'images/$img.png',
                  height: 17,
                ),
              ),
              Text(
                text,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 13,
                  fontFamily: 'SFUIText',
                ),
              ),
            ],
          ),
          const Icon(
            Icons.arrow_forward_ios,
            size: 18,
          ),
        ],
      ),
    );
  }
}
