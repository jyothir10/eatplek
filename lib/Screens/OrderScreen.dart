import 'package:eatplek/Components/BottomBar.dart';
import 'package:eatplek/Components/ProfileButton.dart';
import 'package:flutter/material.dart';

class OrderScreen extends StatefulWidget {
  static const String id = '/order';
  const OrderScreen({Key? key}) : super(key: key);

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  int n = 2;
  //todo:update n as no:of orders
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const BottomBar(
        index: 1,
      ),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_outlined,
            color: Color(0xff000000),
          ),
        ),
        title: const Text("Order Confirmation",
            style: TextStyle(
                color: Color(0xff000000),
                fontWeight: FontWeight.w600,
                fontFamily: "SFUIText",
                fontStyle: FontStyle.normal,
                fontSize: 14.0),
            textAlign: TextAlign.left),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(left: 18, top: 8),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 9),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: const [
                          Text(
                            'From',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 10,
                              fontFamily: 'SFUIText',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height * .042,
                          width: MediaQuery.of(context).size.width * .91,
                          decoration: BoxDecoration(
                            color: Color(0xd1e1e1e1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 9),
                                child: Image.asset(
                                  "images/loc.png",
                                  height: 16,
                                ),
                              ),
                              Text(
                                'The Smocky Shack, Chengannur',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 10,
                                  fontFamily: 'SFUIText',
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      child: Row(
                        children: [
                          const Text(
                            'Choosen Option',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 10,
                              fontFamily: 'SFUIText',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 12),
                            child: Container(
                              height: MediaQuery.of(context).size.height * .042,
                              width: MediaQuery.of(context).size.width * .2,
                              decoration: BoxDecoration(
                                color: Color(0xd1e1e1e1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Center(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Image.asset(
                                      "images/cutlery.png",
                                      color: Color(0xff768BA3),
                                      height: 12,
                                      width: 15,
                                    ),
                                    Text(
                                      'Dine In',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 10,
                                        fontFamily: 'SFUIText',
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 9),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: const [
                          Text(
                            'Items',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 10,
                              fontFamily: 'SFUIText',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height * .056 * n,
                          width: MediaQuery.of(context).size.width * .91,
                          decoration: BoxDecoration(
                            color: Color(0xd1e1e1e1),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 9),
                            child: Column(
                              children: [
                                OrderSummary(
                                    name: "Zinger Burger",
                                    count: 1,
                                    price: "179",
                                    img: "images/order_index.png"),
                                OrderSummary(
                                    name: "Zinger Burger",
                                    count: 1,
                                    price: "179",
                                    img: "images/order_index.png"),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: 78,
              margin: const EdgeInsets.only(
                left: 1,
                right: 1,
              ),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(18),
                    topRight: Radius.circular(18)),
                boxShadow: [
                  BoxShadow(
                    color: Color(0x3f000000),
                    offset: Offset(0, 4),
                    blurRadius: 17,
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Total',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 11.40495777130127,
                            fontFamily: 'SFUIText',
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 3),
                          child: Text(
                            '₹ 179 ',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 17.107439041137695,
                              fontFamily: 'SFUIText',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * .38,
                      child: ProfileButton(
                          text: "Proceed",
                          onTap: () {
                            //todo:payment
                          }),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OrderSummary extends StatefulWidget {
  int count;
  String name;
  String price;
  String img;

  OrderSummary(
      {Key? key,
      required this.name,
      required this.count,
      required this.price,
      required this.img})
      : super(key: key);

  @override
  State<OrderSummary> createState() => _OrderSummaryState();
}

class _OrderSummaryState extends State<OrderSummary> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 12),
                child: Image.asset(widget.img),
              ),
              Text(
                widget.name,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 11,
                  fontFamily: 'SFUIText',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 21),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          if (widget.count > 0) {
                            widget.count--;
                          }
                        });
                      },
                      child: const Icon(
                        Icons.remove_circle,
                        color: Color(0xffc7c7c7),
                        size: 17,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Text(
                        " ${widget.count} ",
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 11.076922416687012,
                          fontFamily: 'SFUIText',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          widget.count++;
                        });
                      },
                      child: const Icon(
                        Icons.add_circle,
                        color: Color(0xffffb800),
                        size: 17,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                '₹ ${widget.price}',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 10,
                  fontFamily: 'SFUIText',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
