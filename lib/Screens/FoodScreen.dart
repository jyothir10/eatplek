import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


class FoodScreen extends StatefulWidget {
  static const String id = '/food';
  const FoodScreen({Key? key}) : super(key: key);

  @override
  State<FoodScreen> createState() => _FoodScreenState();
}

class _FoodScreenState extends State<FoodScreen> {
  int count = 01;
  bool v = false, n = false, countEnable = false, tap = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(186),
          child: Stack(
            children: [
              AppBar(
                elevation: 0,
                leading: InkWell(
                  onTap: () {},
                  child: const Icon(
                    Icons.arrow_back_outlined,
                  ),
                ),
                actions: [
                  Padding(
                    padding: EdgeInsets.only(
                        right: MediaQuery.of(context).size.width * .05),
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () {},
                          child: const Icon(
                            Icons.search_rounded,
                          ),
                        ),
                        const Text("Search",
                            style: TextStyle(
                                color: Color(0xffffffff),
                                fontWeight: FontWeight.w400,
                                fontFamily: "SFUIText",
                                fontStyle: FontStyle.normal,
                                fontSize: 12.3),
                            textAlign: TextAlign.left),
                      ],
                    ),
                  ),
                ],
                flexibleSpace: Image(
                  width: MediaQuery.of(context).size.width,
                  height: 154,
                  image: AssetImage("images/bg.png"),
                  fit: BoxFit.cover,
                ),
                backgroundColor: Colors.white,
              ),
              Positioned(
                top: 65,
                left: 10,
                child: Container(
                  height: 121,
                  width: MediaQuery.of(context).size.width * .906,
                  child: Card(
                    elevation: 20,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          const Image(
                            image: AssetImage("images/rest.png"),
                            height: 101,
                            width: 107.3,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // The Smocky Shack
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text("The Smocky Shack",
                                      style: TextStyle(
                                          color: Color(0xff1d1d1d),
                                          fontWeight: FontWeight.w700,
                                          fontFamily: "SFUIText",
                                          fontStyle: FontStyle.normal,
                                          fontSize: 18.2),
                                      textAlign: TextAlign.left),
                                  Text("Arabian, Bevrages, Juices  Chengannur",
                                      style: TextStyle(
                                          color: Color(0xff1d1d1d),
                                          fontWeight: FontWeight.w400,
                                          fontFamily: "SFUIText",
                                          fontStyle: FontStyle.normal,
                                          fontSize: 9.1),
                                      textAlign: TextAlign.left),
                                ],
                              ),
                              // Arabian, Bevrages, Juices Chengannur
                              Row(
                                children: [
                                  const Icon(
                                    Icons.star,
                                    size: 15,
                                  ),
                                  // 3.9
                                  const Text(
                                    ' 3.9',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 9.968466758728027,
                                      fontFamily: 'SFUIText',
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 13),
                                    child: Row(
                                      children: const [
                                        Icon(
                                          Icons.location_on_outlined,
                                          size: 15,
                                        ),
                                        Text(
                                          ' 2.4 km',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 9.970605850219727,
                                            fontFamily: 'SFUIText',
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  // 2.4 km

                                  const Icon(
                                    Icons.hourglass_empty_outlined,
                                    size: 15,
                                  ),
                                  const Text(
                                    ' 15 min',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 9.970000267028809,
                                      fontFamily: 'SFUIText',
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        body: Container(
          color: Colors.white,
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * .05),
            child: Column(
              children: [
                Row(
                  children: [
                    Switch(
                      value: v,
                      activeColor: const Color(0xff042e60),
                      onChanged: (value) {
                        setState(() {
                          v = value;
                        });
                      },
                    ),
                    // Veg
                    const Text(
                      'Veg',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 10,
                        fontFamily: 'SFUIText',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Switch(
                      value: n,
                      activeColor: const Color(0xff042e60),
                      onChanged: (value) {
                        setState(() {
                          n = value;
                        });
                      },
                    ),
                    // Veg
                    const Text(
                      'Non- Veg',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 10,
                        fontFamily: 'SFUIText',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Recommended (14)
                    const Text("Recommended (14)",
                        style: TextStyle(
                            color: Color(0xff000000),
                            fontWeight: FontWeight.w600,
                            fontFamily: "SFUIText",
                            fontStyle: FontStyle.normal,
                            fontSize: 12.0),
                        textAlign: TextAlign.left),
                    Card(
                      color: const Color(0xff042e60),
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Row(
                          children: [
                            // Menu
                            const Text("Menu ",
                                style: TextStyle(
                                    color: Color(0xffffffff),
                                    fontWeight: FontWeight.w400,
                                    fontFamily: "SFUIText",
                                    fontStyle: FontStyle.normal,
                                    fontSize: 9.2),
                                textAlign: TextAlign.left),
                            InkWell(
                              onTap: () {},
                              child: const Icon(
                                Icons.file_open_outlined,
                                size: 15,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                const FoodScreenCard(
                  pic: "images/fd.png",
                  name: "Zinger Burger",
                  price: "₹ 179",
                  subname: "French Fires",
                ),
                const FoodScreenCard(
                  pic: "images/fd.png",
                  name: "Zinger Burger",
                  price: "₹ 179",
                  subname: "French Fires",
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: Color(0xff57000000),
                  blurRadius: 25,
                  offset: Offset(0, -10)),
            ],
          ),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * .087,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xff042e60),
                borderRadius: BorderRadius.circular(10),
              ),
              width: MediaQuery.of(context).size.width * .9,
              height: MediaQuery.of(context).size.height * .058,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // 1 Item
                        const Text("1 Item",
                            style: TextStyle(
                                color: Color(0xffffffff),
                                fontWeight: FontWeight.w400,
                                fontFamily: "SFUIText",
                                fontStyle: FontStyle.normal,
                                fontSize: 9.8),
                            textAlign: TextAlign.left),
                        // ₹ 179
                        Row(
                          children: const [
                            Text("₹ 179 ",
                                style: TextStyle(
                                    color: Color(0xffffffff),
                                    fontWeight: FontWeight.w600,
                                    fontFamily: "SFUIText",
                                    fontStyle: FontStyle.normal,
                                    fontSize: 14.6),
                                textAlign: TextAlign.left),
                            // plus taxes
                            Padding(
                              padding: EdgeInsets.only(top: 4),
                              child: Text("plus taxes",
                                  style: TextStyle(
                                      color: Color(0xffffffff),
                                      fontWeight: FontWeight.w400,
                                      fontFamily: "SFUIText",
                                      fontStyle: FontStyle.normal,
                                      fontSize: 7.3),
                                  textAlign: TextAlign.left),
                            )
                          ],
                        )
                      ],
                    ),
                    // View Cart
                    const Text("View Cart",
                        style: TextStyle(
                            color: Color(0xffffffff),
                            fontWeight: FontWeight.w600,
                            fontFamily: "SFUIText",
                            fontStyle: FontStyle.normal,
                            fontSize: 12.2),
                        textAlign: TextAlign.left)
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class FoodScreenCard extends StatefulWidget {
  final String pic;
  final String name;
  final String price;
  final String subname;

  const FoodScreenCard({
    Key? key,
    required this.pic,
    required this.name,
    required this.price,
    required this.subname,
  }) : super(key: key);

  @override
  State<FoodScreenCard> createState() => _FoodScreenCardState();
}

class _FoodScreenCardState extends State<FoodScreenCard> {
  int count = 01;
  bool countEnable = false;
  _showDetailsCard() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              actions: [
                Container(
                  height: MediaQuery.of(context).size.height * .323,
                  width: MediaQuery.of(context).size.width * .8,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children:[
                          InkWell(
                            onTap: (){
                              setState((){
                                Navigator.pop(context);
                              });
                            },
                            child: const Icon(
                              Icons.close_rounded,
                              color: Color(0xffde292d32),
                            ),
                          )
                        ],
                      ),
                      Image(
                        image: AssetImage("images/fd.png"),
                        height: MediaQuery.of(context).size.height * .132,
                        width: MediaQuery.of(context).size.width * .31,
                      ),
                      const Text(
                        "Lorem ipsum dolor sit amet, consectetur adipiscing\nelit. Nulla facilisis viverra magna, eu sodales mauris\nsodales non. Aliquam et pellentesque enim.Donec at\ncommodo mauris. Aliquam dapibus, elit fermentum\nfaucibus dictum, felis turpis ornare felis, eu dapibus\nleo ligula eu mauris.  ",
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
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _showDetailsCard();
      },
      child: Card(
        elevation: 0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Image(
                  image: AssetImage(widget.pic),
                  height: MediaQuery.of(context).size.height * .132,
                  width: MediaQuery.of(context).size.width * .31,
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * .05),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Zinger Burger
                      Text(widget.name,
                          style: const TextStyle(
                              color: Color(0xff000000),
                              fontWeight: FontWeight.w600,
                              fontFamily: "SFUIText",
                              fontStyle: FontStyle.normal,
                              fontSize: 17.5),
                          textAlign: TextAlign.left),
                      // ₹ 179
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: MediaQuery.of(context).size.height * .02),
                        child: Text(widget.price,
                            style: const TextStyle(
                                color: Color(0xff000000),
                                fontWeight: FontWeight.w500,
                                fontFamily: "SFUIText",
                                fontStyle: FontStyle.normal,
                                fontSize: 12.0),
                            textAlign: TextAlign.left),
                      ),
                      // French Fires
                      Text(widget.subname,
                          style: const TextStyle(
                              color: Color(0xff000000),
                              fontWeight: FontWeight.w500,
                              fontFamily: "SFUIText",
                              fontStyle: FontStyle.normal,
                              fontSize: 10.0),
                          textAlign: TextAlign.left)
                    ],
                  ),
                ),
              ],
            ),
            countEnable
                ? Row(
                    children: [
                      InkWell(
                        onTap: () {
                          setState(() {
                            if (count > 0) {
                              count--;
                            }
                          });
                        },
                        child: const Icon(
                          Icons.remove_circle,
                          color: Color(0xffc7c7c7),
                          size: 17,
                        ),
                      ),
                      Text(
                        " $count ",
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 11.076922416687012,
                          fontFamily: 'SFUIText',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            count++;
                          });
                        },
                        child: const Icon(
                          Icons.add_circle,
                          color: Color(0xffffb800),
                          size: 17,
                        ),
                      ),
                    ],
                  )
                : InkWell(
                    onTap: () {
                      setState(() {
                        countEnable = true;
                      });
                    },
                    child: const Icon(
                      Icons.add_circle,
                      color: Color(0xffffb800),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
