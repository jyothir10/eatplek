import 'package:flutter/material.dart';

class OrderHistoryListCard extends StatelessWidget {
  final String name;
  final String rate;
  const OrderHistoryListCard({
    Key? key,
    required this.name,
    required this.rate
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Zinger Burger
              Text(name,
                  style: const TextStyle(
                      color: Color(0xff000000),
                      fontWeight: FontWeight.w400,
                      fontFamily: "SFUIText",
                      fontStyle: FontStyle.normal,
                      fontSize: 10.0),
                  textAlign: TextAlign.left),
              // ₹ 250
              Text(rate,
                  style: const TextStyle(
                      color: Color(0xff000000),
                      fontWeight: FontWeight.w400,
                      fontFamily: "SFUIText",
                      fontStyle: FontStyle.normal,
                      fontSize: 10.0),
                  textAlign: TextAlign.left)
            ],
          ),
        ),
        const Divider(
          height: 1,
          color: Color(0xff0f000000),
        ),
      ],
    );
  }
}
