import 'dart:convert';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:eatplek/Constants.dart';
import 'package:eatplek/Screens/OrderScreen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../Exceptions/api_exception.dart';

final key = GlobalKey();

class FoodScreen extends StatefulWidget {
  static const String id = '/food';
  String? resId;
  FoodScreen({this.resId, Key? key}) : super(key: key);

  @override
  State<FoodScreen> createState() => _FoodScreenState();
}

class _FoodScreenState extends State<FoodScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  int count = 01;
  static double total = 0;

  bool ac = false, non = true, countEnable = false, tap = false;
  var restaurant;
  List foods = [];
  List categories = [];
  List categorylist = [];
  List categoryids = [];
  static const except = {'exc': 'An error occured'};
  bool isEmpty = false;
  bool showList = false;
  bool isEmpty1 = false;
  bool showList1 = false;
  bool isCategory = false;
  String price = "non_ac_price";

  mysetstate() {
    setState(() {});
  }

  getRestaurant() async {
    Map<String, String> headers = {
      "Content-Type": "application/json",
    };
    var urlfinal = Uri.https(URL_Latest, '/restaurant/${widget.resId}');

    http.Response response = await http.get(urlfinal, headers: headers);
    if ((response.statusCode >= 200) && (response.statusCode < 300)) {
      final jsonData = jsonDecode(response.body);
      restaurant = await jsonData['restaurant'];
      if (restaurant.length == 0) {
        isEmpty = true;
        showList = true;
      } else {
        showList = true;
      }
      setState(() {});
    } else
      APIException(response.statusCode, except);
  }

  getFood() async {
    Map<String, String> headers = {
      "Content-Type": "application/json",
    };
    var urlfinal =
        Uri.https(URL_Latest, '/food/filter/restaurant/${widget.resId}');

    http.Response response = await http.get(urlfinal, headers: headers);
    if ((response.statusCode >= 200) && (response.statusCode < 300)) {
      final jsonData = jsonDecode(response.body);

      if (jsonData['foods'] == null) {
        isEmpty1 = true;
        showList1 = true;
      } else {
        foods = await jsonData['foods'];
        showList1 = true;
        categories.clear();
        categoryids.clear();
        categorylist.clear();
        for (int i = 0; i < foods.length; i++) {
          categories.add(foods[i]['category_name']);
          categorylist.add(foods[i]['category_name']);
          categoryids.add(foods[i]['category_id']);
        }
      }

      setState(() {
        isCategory = false;
      });
    } else
      APIException(response.statusCode, except);
  }

  getCategoryFood(String categoryId) async {
    setState(() {
      isEmpty1 = false;
      showList1 = false;
    });

    Map<String, String> headers = {
      "Content-Type": "application/json",
    };
    final Map<String, String> _queryParameters = <String, String>{
      'category': categoryId,
    };
    var urlfinal = Uri.https(URL_Latest,
        '/food/filter/restaurant/${widget.resId}', _queryParameters);

    http.Response response = await http.get(urlfinal, headers: headers);

    if ((response.statusCode >= 200) && (response.statusCode < 300)) {
      final jsonData = jsonDecode(response.body);

      if (jsonData['foods'] == null) {
        isEmpty1 = true;
        showList1 = true;
      } else {
        foods = await jsonData['foods'];
        showList1 = true;
        categories.clear();
        categories.add(foods[0]['category_name']);
      }
      setState(() {
        isCategory = true;
      });
    } else
      APIException(response.statusCode, except);
  }

  @override
  void initState() {
    // TODO: implement initState
    getRestaurant();
    getFood();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      key: _scaffoldKey,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(186),
        child: Stack(
          children: [
            AppBar(
              elevation: 0,
              leading: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(
                  Icons.arrow_back_outlined,
                ),
              ),
              // actions: [
              //   Padding(
              //     padding: EdgeInsets.only(
              //         right: MediaQuery.of(context).size.width * .05),
              //     child: Row(
              //       children: [
              //         InkWell(
              //           onTap: () {},
              //           child: Image.asset(
              //             "images/search.png",
              //             height: 17,
              //             width: 17,
              //             color: Colors.white,
              //           ),
              //         ),
              //         const Text(" Search",
              //             style: TextStyle(
              //                 color: Color(0xffffffff),
              //                 fontWeight: FontWeight.w400,
              //                 fontFamily: "SFUIText",
              //                 fontStyle: FontStyle.normal,
              //                 fontSize: 13),
              //             textAlign: TextAlign.left),
              //       ],
              //     ),
              //   ),
              // ],
              flexibleSpace: Image(
                width: MediaQuery.of(context).size.width,
                height: 154,
                image: AssetImage("images/bg.png"),
                fit: BoxFit.cover,
              ),
              backgroundColor: Colors.white,
            ),
            Positioned(
              top: 90,
              left: MediaQuery.of(context).size.width * .047,
              child: Container(
                height: 121,
                width: MediaQuery.of(context).size.width * .906,
                child: Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: showList == true
                      ? Container(
                          child: isEmpty == false
                              ? Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5, vertical: 8),
                                      child: Row(
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                            child: CachedNetworkImage(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  .27,
                                              height: 96,
                                              fit: BoxFit.cover,
                                              imageUrl: restaurant["image"],
                                              placeholder: (context, url) =>
                                                  const Center(
                                                      child:
                                                          CircularProgressIndicator(
                                                color: primaryclr,
                                              )),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      new Icon(Icons.error),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 10),
                                            child: Container(
                                              height: 96,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  // The Smocky Shack
                                                  Container(
                                                    height: 96,
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(restaurant["name"],
                                                            style: const TextStyle(
                                                                color: Color(
                                                                    0xff1d1d1d),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                                fontFamily:
                                                                    "SFUIText",
                                                                fontStyle:
                                                                    FontStyle
                                                                        .normal,
                                                                fontSize: 18.5),
                                                            textAlign:
                                                                TextAlign.left),
                                                        Text(restaurant["type"],
                                                            style: const TextStyle(
                                                                color: Color(
                                                                    0xff1d1d1d),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                fontFamily:
                                                                    "SFUIText",
                                                                fontStyle:
                                                                    FontStyle
                                                                        .normal,
                                                                fontSize: 10.5),
                                                            textAlign:
                                                                TextAlign.left),
                                                        Text(
                                                            restaurant[
                                                                "location"],
                                                            style: const TextStyle(
                                                                color: Color(
                                                                    0xff1d1d1d),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                fontFamily:
                                                                    "SFUIText",
                                                                fontStyle:
                                                                    FontStyle
                                                                        .normal,
                                                                fontSize: 10.5),
                                                            textAlign:
                                                                TextAlign.left),
                                                      ],
                                                    ),
                                                  ),
                                                  // Arabian, Bevrages, Juices Chengannur
                                                  // Row(
                                                  //   children: [
                                                  //     const Icon(
                                                  //       Icons.star,
                                                  //       size: 15,
                                                  //     ),
                                                  //     // 3.9
                                                  //     const Text(
                                                  //       ' 3.9',
                                                  //       style: TextStyle(
                                                  //         color: Colors.black,
                                                  //         fontSize:
                                                  //             9.968466758728027,
                                                  //         fontFamily:
                                                  //             'SFUIText',
                                                  //         fontWeight:
                                                  //             FontWeight.w600,
                                                  //       ),
                                                  //     ),
                                                  //     Padding(
                                                  //       padding:
                                                  //           const EdgeInsets
                                                  //                   .symmetric(
                                                  //               horizontal: 13),
                                                  //       child: Row(
                                                  //         children: const [
                                                  //           Icon(
                                                  //             Icons
                                                  //                 .location_on_outlined,
                                                  //             size: 15,
                                                  //           ),
                                                  //           Text(
                                                  //             ' 2.4 km',
                                                  //             style: TextStyle(
                                                  //               color: Colors
                                                  //                   .black,
                                                  //               fontSize:
                                                  //                   9.970605850219727,
                                                  //               fontFamily:
                                                  //                   'SFUIText',
                                                  //               fontWeight:
                                                  //                   FontWeight
                                                  //                       .w600,
                                                  //             ),
                                                  //           ),
                                                  //         ],
                                                  //       ),
                                                  //     ),
                                                  //     // 2.4 km
                                                  //     const Icon(
                                                  //       Icons
                                                  //           .hourglass_empty_outlined,
                                                  //       size: 15,
                                                  //     ),
                                                  //     const Text(
                                                  //       ' 15 min',
                                                  //       style: TextStyle(
                                                  //         color: Colors.black,
                                                  //         fontSize:
                                                  //             9.970000267028809,
                                                  //         fontFamily:
                                                  //             'SFUIText',
                                                  //         fontWeight:
                                                  //             FontWeight.w600,
                                                  //       ),
                                                  //     ),
                                                  //   ],
                                                  // ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Card(
                                      color: Color(0xfffd8181),
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(10),
                                        ),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 3, vertical: 5),
                                        child: Row(
                                          children: const [
                                            Icon(Icons.circle_rounded,
                                                color: Color(0xffffb800),
                                                size: 10),
                                            Text(
                                              ' AC',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 8,
                                                fontFamily: 'SFUIText',
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              : const Center(
                                  child: Text(
                                    "Nothing to show",
                                    style: TextStyle(
                                        color: Color(0xff000000),
                                        fontWeight: FontWeight.w600,
                                        fontFamily: "SFUIText",
                                        fontStyle: FontStyle.normal,
                                        fontSize: 17.5),
                                  ),
                                ),
                        )
                      : const Center(
                          child: CircularProgressIndicator(
                            color: primaryclr,
                          ),
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * .05),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Switch(
                            value: ac,
                            activeColor: primaryclr,
                            onChanged: (value) {
                              setState(() {
                                ac = value;
                                non = !ac;
                                price = "ac_price";
                              });
                            },
                          ),
                          // Veg
                          const Text(
                            'AC',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 10,
                              fontFamily: 'SFUIText',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Switch(
                            value: non,
                            activeColor: primaryclr,
                            onChanged: (value) {
                              setState(() {
                                non = value;
                                ac = !non;
                                price = "non_ac_price";
                              });
                            },
                          ),
                          // Veg
                          const Text(
                            'Non-AC',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 10,
                              fontFamily: 'SFUIText',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      InkWell(
                        onTap: () {
                          _scaffoldKey.currentState!.openDrawer();
                        },
                        child: Card(
                          color: primaryclr,
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
                                const Icon(
                                  Icons.file_open_outlined,
                                  size: 15,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  showList1 == true
                      ? Container(
                          height: MediaQuery.of(context).size.height - 343,
                          child: isEmpty1 == false
                              ? ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: categories.length,
                                  itemBuilder: (context, index) {
                                    List foodlist = [];
                                    if (isCategory == false) {
                                      foodlist = foods[index]['foods'];
                                    } else {
                                      foodlist = foods;
                                    }
                                    double height = 230;

                                    if (foodlist.length == 1) {
                                      height = 118;
                                    }

                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 9),
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              // Recommended (14)
                                              Text("${categories[index]} ",
                                                  style: const TextStyle(
                                                      color: Color(0xff000000),
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontFamily: "SFUIText",
                                                      fontStyle:
                                                          FontStyle.normal,
                                                      fontSize: 12.5),
                                                  textAlign: TextAlign.left),
                                            ],
                                          ),
                                          Container(
                                            height: isCategory == true
                                                ? MediaQuery.of(context)
                                                        .size
                                                        .height -
                                                    340
                                                : height,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width -
                                                35,
                                            child: ListView.builder(
                                                physics:
                                                    ClampingScrollPhysics(),
                                                shrinkWrap: true,
                                                itemCount: foodlist.length,
                                                itemBuilder: (context, i) {
                                                  return FoodScreenCard(
                                                    id: foodlist[i]['id'],
                                                    pic: foodlist[i]['image'],
                                                    name: foodlist[i]['name'],
                                                    price: foodlist[i][price]
                                                        .toString(),
                                                    description: foodlist[i]
                                                        ['description'],
                                                  );
                                                }),
                                          ),
                                        ],
                                      ),
                                    );
                                  })
                              : const Center(
                                  child: Text(
                                    "Nothing to show",
                                    style: TextStyle(
                                        color: Color(0xff000000),
                                        fontWeight: FontWeight.w600,
                                        fontFamily: "SFUIText",
                                        fontStyle: FontStyle.normal,
                                        fontSize: 17.5),
                                  ),
                                ),
                        )
                      : Container(
                          height: MediaQuery.of(context).size.height - 343,
                          child: const Center(
                            child: CircularProgressIndicator(
                              color: primaryclr,
                            ),
                          ),
                        ),
                ],
              ),
            ),
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
              color: primaryclr,
              borderRadius: BorderRadius.circular(10),
            ),
            width: MediaQuery.of(context).size.width * .9,
            height: MediaQuery.of(context).size.height * .058,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // 1 Item
                      // ₹ 179
                      // Container(
                      //   child: Text(total.toString(),
                      //       style: const TextStyle(
                      //           color: Color(0xffffffff),
                      //           fontWeight: FontWeight.w600,
                      //           fontFamily: "SFUIText",
                      //           fontStyle: FontStyle.normal,
                      //           fontSize: 14.6),
                      //       textAlign: TextAlign.left),
                      // )
                    ],
                  ),
                  // View Cart
                  InkWell(
                    onTap: () {
                      Navigator.pushReplacementNamed(context, OrderScreen.id);
                    },
                    child: const Text("View Cart",
                        style: TextStyle(
                            color: Color(0xffffffff),
                            fontWeight: FontWeight.w600,
                            fontFamily: "SFUIText",
                            fontStyle: FontStyle.normal,
                            fontSize: 13),
                        textAlign: TextAlign.left),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: primaryclr,
              ),
              child: Center(
                child: Text(
                  'Menu',
                  style: TextStyle(
                    color: Color(0xffffffff),
                    fontWeight: FontWeight.w600,
                    fontFamily: "SFUIText",
                    fontStyle: FontStyle.normal,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
            Container(
              height: 70,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    getFood();
                  });
                  Navigator.pop(context);
                },
                child: Card(
                  child: Center(
                    child: Text(
                      "All",
                      style: TextStyle(
                        color: primaryclr,
                        fontWeight: FontWeight.w400,
                        fontFamily: "SFUIText",
                        fontStyle: FontStyle.normal,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              height: 500,
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: categorylist.length,
                  itemBuilder: (context, index) {
                    return Container(
                      height: 70,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            getCategoryFood(categoryids[index]);
                          });
                          Navigator.pop(context);
                        },
                        child: Card(
                          child: Center(
                            child: Text(
                              categorylist[index],
                              style: TextStyle(
                                color: primaryclr,
                                fontWeight: FontWeight.w400,
                                fontFamily: "SFUIText",
                                fontStyle: FontStyle.normal,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}

class FoodScreenCard extends StatefulWidget {
  final String pic;
  final String name;
  final String price;
  final String description;
  final String id;

  const FoodScreenCard({
    Key? key,
    required this.id,
    required this.pic,
    required this.name,
    required this.price,
    required this.description,
  }) : super(key: key);

  @override
  State<FoodScreenCard> createState() => _FoodScreenCardState();
}

class _FoodScreenCardState extends State<FoodScreenCard> {
  int count = 1;
  bool countEnable = false;
  static const except = {'exc': 'An error occured'};

  addtoCart(qty) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Token": sharedPreferences.getString("token").toString(),
    };
    var urlfinal = Uri.https(URL_Latest, '/cart');

    Map body1 = {
      "user_id": sharedPreferences.getString("id"),
      "item": {
        "food_id": widget.id,
        "name": widget.name,
        "image": widget.pic,
        "price": int.parse(widget.price),
        "quantity": qty
      }
    };
    final body = jsonEncode(body1);

    http.Response response =
        await http.put(urlfinal, headers: headers, body: body);

    if ((response.statusCode >= 200) && (response.statusCode < 300)) {
      final jsonData = await jsonDecode(response.body);

      if (jsonData['message'] == "item added to cart") {
        _FoodScreenState.total += await jsonData['item']['total'];
      }

      setState(() {});
    } else
      APIException(response.statusCode, except);
  }

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
                    //mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                            onTap: () {
                              setState(() {
                                Navigator.pop(context);
                              });
                            },
                            child: const Padding(
                              padding: EdgeInsets.all(3.0),
                              child: Icon(
                                Icons.close_rounded,
                                size: 15,
                                color: Color(0xffde292d32),
                              ),
                            ),
                          )
                        ],
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: CachedNetworkImage(
                          width: MediaQuery.of(context).size.width * .31,
                          height: MediaQuery.of(context).size.height * .132,
                          fit: BoxFit.cover,
                          imageUrl: widget.pic,
                          placeholder: (context, url) => const Center(
                              child: CircularProgressIndicator(
                            color: primaryclr,
                          )),
                          errorWidget: (context, url, error) =>
                              new Icon(Icons.error),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 7),
                        child: Text(
                          widget.name,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontFamily: 'SFUIText',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 3),
                        child: Text(
                          widget.description,
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 11,
                              fontFamily: 'SFUIText',
                              height: 1.5),
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
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Card(
        elevation: 0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                _showDetailsCard();
              },
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: CachedNetworkImage(
                      width: MediaQuery.of(context).size.width * .31,
                      height: MediaQuery.of(context).size.height * .132,
                      fit: BoxFit.cover,
                      imageUrl: widget.pic,
                      placeholder: (context, url) => const Center(
                          child: CircularProgressIndicator(
                        color: primaryclr,
                      )),
                      errorWidget: (context, url, error) =>
                          new Icon(Icons.error),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * .05),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Zinger Burger

                        Container(
                          constraints: const BoxConstraints(maxWidth: 120),
                          child: Text(widget.name,
                              style: const TextStyle(
                                  color: Color(0xff000000),
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "SFUIText",
                                  fontStyle: FontStyle.normal,
                                  fontSize: 17.5),
                              textAlign: TextAlign.left),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(top: 10),
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
                      ],
                    ),
                  ),
                ],
              ),
            ),
            countEnable
                ? Row(
                    children: [
                      InkWell(
                        onTap: () {
                          setState(() {
                            if (count > 0) {
                              count--;
                              addtoCart(-1);
                            }
                          });
                        },
                        child: const Icon(
                          Icons.remove_circle,
                          color: Color(0xffc7c7c7),
                          size: 20,
                        ),
                      ),
                      Text(
                        "  $count  ",
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
                            addtoCart(1);
                          });
                        },
                        child: const Icon(
                          Icons.add_circle,
                          color: Color(0xffffb800),
                          size: 20,
                        ),
                      ),
                    ],
                  )
                : InkWell(
                    onTap: () {
                      setState(() {
                        countEnable = true;
                        addtoCart(1);
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
