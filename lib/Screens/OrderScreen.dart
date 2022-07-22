import 'package:eatplek/Components/BottomBar.dart';
import 'package:eatplek/Components/ProfileButton.dart';
import 'package:eatplek/Screens/FoodScreen.dart';
import 'package:eatplek/Screens/OrderHistoryScreen.dart';
import 'package:flutter/material.dart';

import 'DashBoardScreen.dart';

class OrderScreen extends StatefulWidget {
  static const String id = '/order';
  const OrderScreen({Key? key}) : super(key: key);

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  int n = 3;

  //todo:update n as no:of orders
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        MediaQuery.of(context).padding.bottom -
        196;
    double h1 = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        MediaQuery.of(context).viewInsets.bottom -
        100;
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacementNamed(context, DashBoardScreen.id);
        return false;
      },
      child: Scaffold(
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
              SizedBox(
                height: MediaQuery.of(context).viewInsets.bottom == 0 ? h : h1,
                child: SingleChildScrollView(
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
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 9),
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
                                  height:
                                      MediaQuery.of(context).size.height * .042,
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
                        MediaQuery.of(context).viewInsets.bottom == 0
                            ? Padding(
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
                              )
                            : Container(),
                        MediaQuery.of(context).viewInsets.bottom == 0
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    height: MediaQuery.of(context).size.height *
                                        .05 *
                                        n,
                                    width:
                                        MediaQuery.of(context).size.width * .91,
                                    decoration: BoxDecoration(
                                      color: Color(0xd1e1e1e1),
                                      borderRadius: BorderRadius.circular(14),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15, vertical: 8),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
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
                              )
                            : Container(),
                        MediaQuery.of(context).viewInsets.bottom == 0
                            ? Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 12),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    InkWell(
                                      child: Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                .043,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                .91,
                                        decoration: BoxDecoration(
                                          color: Color(0xd1e1e1e1),
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        child: Center(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: const [
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(right: 3),
                                                child: Icon(
                                                  Icons.add,
                                                  color: Colors.black,
                                                  size: 15,
                                                ),
                                              ),
                                              Text(
                                                'Add More',
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 11,
                                                  fontFamily: 'SFUIText',
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      onTap: () {
                                        Navigator.pushNamed(
                                            context, FoodScreen.id);
                                      },
                                    ),
                                  ],
                                ),
                              )
                            : Container(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: const [
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 12),
                              child: Text(
                                'Bill Details',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 10,
                                  fontFamily: 'SFUIText',
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              height: MediaQuery.of(context).size.height * .135,
                              width: MediaQuery.of(context).size.width * .91,
                              decoration: BoxDecoration(
                                color: Color(0xd1e1e1e1),
                                borderRadius: BorderRadius.circular(14),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 18, vertical: 12),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 9),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: const [
                                          Text(
                                            'Item Total',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 8,
                                              fontFamily: 'SFUIText',
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          Text(
                                            '₹ 739',
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
                                    const Padding(
                                      padding: EdgeInsets.only(bottom: 9),
                                      child: MySeparator(color: Colors.grey),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 9),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: const [
                                          Text(
                                            'Extra Charges',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 8,
                                              fontFamily: 'SFUIText',
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          Text(
                                            '₹ 0.0',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 8,
                                              fontFamily: 'SFUIText',
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: const [
                                        Text(
                                          'To Pay',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 10,
                                            fontFamily: 'SFUIText',
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        Text(
                                          '₹ 818',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 12,
                                            fontFamily: 'SFUIText',
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: const [
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 12),
                              child: Text(
                                'Comments (optional)',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 10,
                                  fontFamily: 'SFUIText',
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 9, right: 18),
                          child: Container(
                            height: 70,
                            decoration: BoxDecoration(
                              color: Color(0xd1e1e1e1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: TextField(
                              onSubmitted: (val) {
                                print(val);
                              },
                              cursorColor: Colors.black,
                              cursorWidth: 1,
                              keyboardType: TextInputType.multiline,
                              maxLines: 3,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.all(5),
                                hintText: 'Add your comment',
                                hintStyle: TextStyle(
                                  color: Color(0x59000000),
                                  fontSize: 10,
                                  fontFamily: 'SFUIText',
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              MediaQuery.of(context).viewInsets.bottom == 0
                  ? Container(
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
                        padding: const EdgeInsets.symmetric(
                            horizontal: 18, vertical: 12),
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
                                    Navigator.pushReplacementNamed(
                                        context, OrderHistoryScreen.id);
                                  }),
                            ),
                          ],
                        ),
                      ),
                    )
                  : Container(),
            ],
          ),
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
    return Row(
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
    );
  }
}

class MySeparator extends StatelessWidget {
  const MySeparator({Key? key, this.height = 1, this.color = Colors.black})
      : super(key: key);
  final double height;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final boxWidth = constraints.constrainWidth();
        const dashWidth = 3.0;
        final dashHeight = height;
        final dashCount = (boxWidth / (2 * dashWidth)).floor();
        return Flex(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          direction: Axis.horizontal,
          children: List.generate(dashCount, (_) {
            return SizedBox(
              width: dashWidth,
              height: dashHeight,
              child: DecoratedBox(
                decoration: BoxDecoration(color: color),
              ),
            );
          }),
        );
      },
    );
  }
}
