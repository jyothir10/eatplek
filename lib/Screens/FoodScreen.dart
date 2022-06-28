import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FoodScreen extends StatefulWidget {
  static const String id = '/food';
  const FoodScreen({Key? key}) : super(key: key);

  @override
  State<FoodScreen> createState() => _FoodScreenState();
}

class _FoodScreenState extends State<FoodScreen> {
  bool v = false, n = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize:
              Size.fromHeight(MediaQuery.of(context).size.height * .166),
          child: AppBar(
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
            flexibleSpace: const Image(
              image: AssetImage("images/bg.png"),
              fit: BoxFit.cover,
            ),
            backgroundColor: Colors.transparent,
          ),
        ),
        body: Container(
          color: Colors.white,
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * .05),
            child: Column(
              children: [
                Switch(
                  value: v,
                  onChanged: (v) {},
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
                Card(
                  elevation: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Image(
                            image: AssetImage("images/fd.png"),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: MediaQuery.of(context).size.width * .05),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Zinger Burger
                                const Text("Zinger Burger",
                                    style: TextStyle(
                                        color: Color(0xff000000),
                                        fontWeight: FontWeight.w600,
                                        fontFamily: "SFUIText",
                                        fontStyle: FontStyle.normal,
                                        fontSize: 17.5),
                                    textAlign: TextAlign.left),
                                // ₹ 179
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical:
                                          MediaQuery.of(context).size.height *
                                              .02),
                                  child: const Text("₹ 179",
                                      style: TextStyle(
                                          color: Color(0xff000000),
                                          fontWeight: FontWeight.w500,
                                          fontFamily: "SFUIText",
                                          fontStyle: FontStyle.normal,
                                          fontSize: 12.0),
                                      textAlign: TextAlign.left),
                                ),
                                // French Fires
                                Text("French Fires",
                                    style: TextStyle(
                                        color: const Color(0xff000000),
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
                      const Icon(
                        Icons.add_circle,
                        color: Color(0xffffb800),
                      ),
                    ],
                  ),
                ),
                Card(
                  elevation: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Image(
                            image: AssetImage("images/fd.png"),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: MediaQuery.of(context).size.width * .05),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Zinger Burger
                                Text("Zinger Burger",
                                    style: TextStyle(
                                        color: Color(0xff000000),
                                        fontWeight: FontWeight.w600,
                                        fontFamily: "SFUIText",
                                        fontStyle: FontStyle.normal,
                                        fontSize: 17.5),
                                    textAlign: TextAlign.left),
                                // ₹ 179
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical:
                                          MediaQuery.of(context).size.height *
                                              .02),
                                  child: const Text("₹ 179",
                                      style: TextStyle(
                                          color: Color(0xff000000),
                                          fontWeight: FontWeight.w500,
                                          fontFamily: "SFUIText",
                                          fontStyle: FontStyle.normal,
                                          fontSize: 12.0),
                                      textAlign: TextAlign.left),
                                ),
                                // French Fires
                                Text("French Fires",
                                    style: TextStyle(
                                        color: const Color(0xff000000),
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
                      const Icon(
                        Icons.add_circle,
                        color: Color(0xffffb800),
                      ),
                    ],
                  ),
                ),
                Card(
                  elevation: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Image(
                            image: AssetImage("images/fd.png"),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: MediaQuery.of(context).size.width * .05),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Zinger Burger
                                const Text("Zinger Burger",
                                    style: TextStyle(
                                        color: Color(0xff000000),
                                        fontWeight: FontWeight.w600,
                                        fontFamily: "SFUIText",
                                        fontStyle: FontStyle.normal,
                                        fontSize: 17.5),
                                    textAlign: TextAlign.left),
                                // ₹ 179
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical:
                                          MediaQuery.of(context).size.height *
                                              .02),
                                  child: const Text("₹ 179",
                                      style: TextStyle(
                                          color: Color(0xff000000),
                                          fontWeight: FontWeight.w500,
                                          fontFamily: "SFUIText",
                                          fontStyle: FontStyle.normal,
                                          fontSize: 12.0),
                                      textAlign: TextAlign.left),
                                ),
                                // French Fires
                                const Text("French Fires",
                                    style: TextStyle(
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
                      const Icon(
                        Icons.add_circle,
                        color: Color(0xffffb800),
                      ),
                    ],
                  ),
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
