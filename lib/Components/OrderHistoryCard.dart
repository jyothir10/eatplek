import 'package:eatplek/Constants.dart';
import 'package:flutter/material.dart';

class OrderHistoryCard extends StatelessWidget {
  String resname;
  String date;
  String time;
  String totalAmount;
  String status;
  int n;
  String item1;
  void Function()? onTap;
  OrderHistoryCard({
    Key? key,
    required this.resname,
    required this.date,
    required this.totalAmount,
    required this.time,
    required this.status,
    required this.n,
    required this.item1,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 9),
      child: Container(
        height: MediaQuery.of(context).size.height * .27,
        width: MediaQuery.of(context).size.width * .9,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          color: Color(0xfff5f5f5),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // The Smocky Shack
                        Text(resname,
                            style: const TextStyle(
                                color: Color(0xff000000),
                                fontWeight: FontWeight.w600,
                                fontFamily: "SFUIText",
                                fontStyle: FontStyle.normal,
                                fontSize: 14.0),
                            textAlign: TextAlign.left),
                        // 21-10-2022
                        Text(date,
                            style: TextStyle(
                                color: Color(0xff000000),
                                fontWeight: FontWeight.w500,
                                fontFamily: "SFUIText",
                                fontStyle: FontStyle.normal,
                                fontSize: 10.0),
                            textAlign: TextAlign.left)
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Chengannur
                        Text("",
                            style: TextStyle(
                                color: Color(0xff000000),
                                fontWeight: FontWeight.w400,
                                fontFamily: "SFUIText",
                                fontStyle: FontStyle.normal,
                                fontSize: 10.0),
                            textAlign: TextAlign.left),
                        // 21-10-2022
                        // 10:00 AM
                        Text(time,
                            style: const TextStyle(
                                color: Color(0xff000000),
                                fontWeight: FontWeight.w500,
                                fontFamily: "SFUIText",
                                fontStyle: FontStyle.normal,
                                fontSize: 10.0),
                            textAlign: TextAlign.left),
                      ],
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Card(
                    color: const Color(0xffeeeeee),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Column(
                        children: [
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 9),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    // Zinger Burger
                                    n > 0
                                        ? Text("$item1  +$n items",
                                            style: const TextStyle(
                                                color: Color(0xff000000),
                                                fontWeight: FontWeight.w400,
                                                fontFamily: "SFUIText",
                                                fontStyle: FontStyle.normal,
                                                fontSize: 11.0),
                                            textAlign: TextAlign.left)
                                        : Text("$item1  ",
                                            style: const TextStyle(
                                                color: Color(0xff000000),
                                                fontWeight: FontWeight.w400,
                                                fontFamily: "SFUIText",
                                                fontStyle: FontStyle.normal,
                                                fontSize: 11.0),
                                            textAlign: TextAlign.left),
                                  ],
                                ),
                              ),
                              const Divider(
                                height: 1,
                                color: Color(0xff0f000000),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 9),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    // Zinger Burge

                                    Text("Total ",
                                        style: const TextStyle(
                                            color: Color(0xff000000),
                                            fontWeight: FontWeight.w400,
                                            fontFamily: "SFUIText",
                                            fontStyle: FontStyle.normal,
                                            fontSize: 12.0),
                                        textAlign: TextAlign.left),
                                    // ₹ 250
                                    Text(totalAmount,
                                        style: const TextStyle(
                                            color: Color(0xff000000),
                                            fontWeight: FontWeight.w400,
                                            fontFamily: "SFUIText",
                                            fontStyle: FontStyle.normal,
                                            fontSize: 12.0),
                                        textAlign: TextAlign.left)
                                  ],
                                ),
                              ),
                              const Divider(
                                height: 1,
                                color: Color(0xff0f000000),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.check_circle_sharp,
                          color: Color(0xffbfbebf),
                        ),
                        Text(status,
                            style: const TextStyle(
                                color: Color(0xff000000),
                                fontWeight: FontWeight.w600,
                                fontFamily: "SFUIText",
                                fontStyle: FontStyle.normal,
                                fontSize: 10.7),
                            textAlign: TextAlign.left),
                      ],
                    ), // Delivered
                    // InkWell(
                    //   radius: 5,
                    //   onTap: onTap,
                    //   child: const Text("View Bill",
                    //       style: TextStyle(
                    //           decoration: TextDecoration.underline,
                    //           color: Color(0xff284aff),
                    //           fontWeight: FontWeight.w700,
                    //           fontFamily: "SFUIText",
                    //           fontStyle: FontStyle.normal,
                    //           fontSize: 11),
                    //       textAlign: TextAlign.left),
                    // ), // View Bill
                    InkWell(
                      onTap: onTap,
                      child: Container(
                        width: MediaQuery.of(context).size.width * .25,
                        child: Card(
                          color: primaryclr,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: // Repeat Order
                              const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text("View Bill",
                                style: TextStyle(
                                    color: Color(0xffffffff),
                                    fontWeight: FontWeight.w600,
                                    fontFamily: "SFUIText",
                                    fontStyle: FontStyle.normal,
                                    fontSize: 10.9),
                                textAlign: TextAlign.center),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
