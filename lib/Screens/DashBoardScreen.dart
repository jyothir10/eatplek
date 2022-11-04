import 'dart:convert';
import 'dart:ui';
import 'package:eatplek/Components/BottomBar.dart';
import 'package:eatplek/Components/ClearFilterButton.dart';
import 'package:eatplek/Components/DashBoardCard.dart';
import 'package:eatplek/Components/DashBoardTopItem.dart';
import 'package:eatplek/Components/ProfileButton.dart';
import 'package:eatplek/Constants.dart';
import 'package:eatplek/services/local_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:numberpicker/numberpicker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Exceptions/api_exception.dart';
import 'FoodScreen.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class DashBoardScreen extends StatefulWidget {
  static const String id = '/dashboard';
  const DashBoardScreen({Key? key}) : super(key: key);

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  int d = 1, t = 0, veg = 1, ac = 0, type = 0;
  static const except = {'exc': 'An error occured'};
  List restaurants = [], dres = [], tres = [];
  bool isEmpty = false;
  bool showList = false;
  Placemark address = Placemark();

  getRestaurants() async {
    Map<String, String> headers = {
      "Content-Type": "application/json",
    };
    var urlfinal = Uri.https(URL_Latest, '/restaurant');

    http.Response response = await http.get(urlfinal, headers: headers);
    if ((response.statusCode >= 200) && (response.statusCode < 300)) {
      final jsonData = jsonDecode(response.body);
      restaurants = await jsonData['restaurants'];
      if (restaurants.length == 0) {
        isEmpty = true;
        showList = true;
      } else {
        showList = true;
        for (int i = 0; i < restaurants.length; i++) {
          if (restaurants[i]['dine_in'] == true) {
            dres.add(restaurants[i]);
          }
          if (restaurants[i]['take_away'] == true) {
            tres.add(restaurants[i]);
          }
        }
      }
      setState(() {});
    } else
      APIException(response.statusCode, except);
  }

  cartInitialise(String resId, String resName, int noGuest, String time) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? user_id = sharedPreferences.getString("id");
    print(sharedPreferences.getString("token"));
    print(user_id);
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Token": sharedPreferences.getString("token").toString(),
    };
    var urlfinal = Uri.https(URL_Latest, '/cart');

    String typename = "Take-Away";

    if (d == 0) {
      typename = "Dine In";
    }

    Map body1 = {
      "user_id": user_id,
      "restaurant_id": resId,
      "restaurant_name": resName,
      "number_of_guests": noGuest,
      "time": time,
      "type": typename,
    };
    final body = jsonEncode(body1);

    http.Response response =
        await http.post(urlfinal, headers: headers, body: body);

    if ((response.statusCode >= 200) && (response.statusCode < 300)) {
      final jsonData = await jsonDecode(response.body);

      if (jsonData['message'] == "cart initialized") {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FoodScreen(
              resId: resId,
            ),
          ),
        );
      }

      setState(() {});
    } else
      APIException(response.statusCode, except);
  }

  Future<Position?> getCordinates() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);

    print("hi");
    print(position);
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    address = placemarks[0];
    setState(() {});
  }

  _showDetailsCard(String resId, String resName) {
    int currentValue = 2;
    int currentValue1 = 5;
    int persons = 2, guests = 1;
    final list = ['AM', 'PM'];
    String dropdownval = "AM";
    String hours = "01", min = "00", meridian = "AM", time = "";

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                actions: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    child: Container(
                      height: t == 0 ? 175 : 120,
                      width: MediaQuery.of(context).size.width * .8,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 9),
                            child: SizedBox(
                              height: t == 0 ? 105 : 50,
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 15),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Time',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 12,
                                            fontFamily: 'SFUIText',
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        t == 0
                                            ? const Text(
                                                'No of guests',
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 12,
                                                  fontFamily: 'SFUIText',
                                                ),
                                              )
                                            : Container(),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 15),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Row(
                                              children: [
                                                Container(
                                                  height: 45,
                                                  width: 45,
                                                  decoration:
                                                      const BoxDecoration(
                                                          color: Colors.white,
                                                          boxShadow: [
                                                            BoxShadow(
                                                              color:
                                                                  Colors.black,
                                                              blurRadius: 2.0,
                                                              spreadRadius: 0.0,
                                                              offset: Offset(
                                                                  0.0,
                                                                  1.0), // shadow direction: bottom right
                                                            )
                                                          ],
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          10))),
                                                  child: NumberPicker(
                                                      textStyle:
                                                          const TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 12,
                                                        fontFamily: 'SFUIText',
                                                      ),
                                                      selectedTextStyle:
                                                          const TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 12,
                                                        fontFamily: 'SFUIText',
                                                      ),
                                                      zeroPad: true,
                                                      haptics: true,
                                                      infiniteLoop: true,
                                                      value: currentValue,
                                                      minValue: 1,
                                                      maxValue: 12,
                                                      onChanged: (value) {
                                                        setState(() {
                                                          currentValue = value;

                                                          hours = (value - 1)
                                                              .toString();
                                                        });
                                                      }),
                                                ),
                                                const Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 5),
                                                  child: Text(
                                                    ":",
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 12,
                                                        fontFamily: 'SFUIText',
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                ),
                                                Container(
                                                  height: 45,
                                                  width: 45,
                                                  decoration:
                                                      const BoxDecoration(
                                                          color: Colors.white,
                                                          boxShadow: [
                                                            BoxShadow(
                                                              color:
                                                                  Colors.black,
                                                              blurRadius: 2.0,
                                                              spreadRadius: 0.0,
                                                              offset: Offset(
                                                                  0.0,
                                                                  1.0), // shadow direction: bottom right
                                                            )
                                                          ],
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          10))),
                                                  child: NumberPicker(
                                                      zeroPad: true,
                                                      step: 5,
                                                      textStyle:
                                                          const TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 12,
                                                        fontFamily: 'SFUIText',
                                                      ),
                                                      selectedTextStyle:
                                                          const TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 12,
                                                        fontFamily: 'SFUIText',
                                                      ),
                                                      haptics: true,
                                                      infiniteLoop: true,
                                                      value: currentValue1,
                                                      minValue: 0,
                                                      maxValue: 59,
                                                      onChanged: (value) {
                                                        setState(() {
                                                          currentValue1 = value;

                                                          min = (value - 5)
                                                              .toString();
                                                        });
                                                      }),
                                                ),
                                              ],
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8),
                                              child: Container(
                                                  height: 45,
                                                  width: 45,
                                                  decoration:
                                                      const BoxDecoration(
                                                          color: Colors.white,
                                                          boxShadow: [
                                                            BoxShadow(
                                                              color:
                                                                  Colors.black,
                                                              blurRadius: 2.0,
                                                              spreadRadius: 0.0,
                                                              offset: Offset(
                                                                  0.0,
                                                                  1.0), // shadow direction: bottom right
                                                            )
                                                          ],
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          10))),
                                                  child: Center(
                                                    child:
                                                        DropdownButtonHideUnderline(
                                                      child: DropdownButton(
                                                        iconSize: 0,
                                                        style: const TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 12,
                                                          fontFamily:
                                                              'SFUIText',
                                                        ),
                                                        value: dropdownval,
                                                        items: list.map(
                                                            (String items) {
                                                          return DropdownMenuItem(
                                                            value: items,
                                                            child: Text(items),
                                                          );
                                                        }).toList(),
                                                        onChanged:
                                                            (String? newValue) {
                                                          setState(() {
                                                            dropdownval =
                                                                newValue!;
                                                            meridian = newValue;
                                                          });
                                                        },
                                                      ),
                                                    ),
                                                  )),
                                            ),
                                          ],
                                        ),
                                        t == 0
                                            ? Row(
                                                children: [
                                                  Container(
                                                    height: 45,
                                                    width: 45,
                                                    decoration:
                                                        const BoxDecoration(
                                                            color: Colors.white,
                                                            boxShadow: [
                                                              BoxShadow(
                                                                color: Colors
                                                                    .black,
                                                                blurRadius: 2.0,
                                                                spreadRadius:
                                                                    0.0,
                                                                offset: Offset(
                                                                    0.0,
                                                                    1.0), // shadow direction: bottom right
                                                              )
                                                            ],
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            10))),
                                                    child: NumberPicker(
                                                        zeroPad: true,
                                                        textStyle:
                                                            const TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 12,
                                                          fontFamily:
                                                              'SFUIText',
                                                        ),
                                                        haptics: true,
                                                        infiniteLoop: true,
                                                        value: persons,
                                                        minValue: 0,
                                                        maxValue: 25,
                                                        onChanged: (value) {
                                                          setState(() {
                                                            persons = value;

                                                            guests = value - 1;
                                                          });
                                                        }),
                                                  ),
                                                ],
                                              )
                                            : Container(),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 12),
                            child: ProfileButton(
                                text: "Proceed",
                                onTap: () {
                                  time = hours + ":" + min + " " + meridian;

                                  cartInitialise(resId, resName, guests, time);
                                }),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          });
        });
  }

  bool? vegcheck = false,
      noncheck = false,
      accheck = false,
      nonaccheck = false,
      type1 = false,
      type2 = false;
  var items = ['Home', 'Office'];
  String dropdownvalue = 'Home', filter = "veg", notificationMsg = "";
  DateTime? currentBackPressTime;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > const Duration(seconds: 2)) {
      currentBackPressTime = now;
      _scaffoldKey.currentState?.showSnackBar(const SnackBar(
          behavior: SnackBarBehavior.floating,
          duration: Duration(seconds: 1),
          content: Text("Press back again to exit")));
      return Future.value(false);
    }
    return Future.value(true);
  }

  @override
  void initState() {
    // TODO: implement initState
    getCordinates();
    getRestaurants();
    LocalNotificationService.initialise();
    super.initState();
    //terminated msg
    FirebaseMessaging.instance.getInitialMessage().then((event) {
      if (event != null) {
        setState(() {
          notificationMsg = "${event.notification!.body}";
          print("Foreground msg");
        });
      }
    });
    //Foreground msg
    FirebaseMessaging.onMessage.listen((event) {
      LocalNotificationService.showNotificationOnForeground(event);
      setState(() {
        notificationMsg = "${event.notification!.body}";
        print("Foreground msg");
      });
    });
    //bground msg
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      setState(() {
        notificationMsg = "${event.notification!.body}";
        print("bground msg");
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        key: _scaffoldKey,
        bottomNavigationBar: const BottomBar(
          index: 0,
        ),
        appBar: buildAppBar(context), //look at bottom for code
        body: Container(
          color: Colors.white,
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.only(top: 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 18),
                      child: Container(
                        width: MediaQuery.of(context).size.width * .26,
                        height: 28,
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              d = 1;
                              t = 0;
                            });
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                d == 1 ? primaryclr : const Color(0xfff0ecec)),
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6.1))),
                          ),
                          child: Text(
                            " Dine in ",
                            style: TextStyle(
                              color: d == 1 ? Colors.white : Colors.black,
                              fontSize: 13,
                              fontFamily: 'SFUIText',
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * .27,
                      height: 28,
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            d = 0;
                            t = 1;
                          });
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              t == 1 ? primaryclr : const Color(0xfff0ecec)),
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6.1))),
                        ),
                        child: Text(
                          "Take Away",
                          style: TextStyle(
                            color: t == 1 ? Colors.white : Colors.black,
                            fontSize: 13,
                            fontFamily: 'SFUIText',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 21, vertical: 14),
                  child: SizedBox(
                    height: 15,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Restaurants Near You',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            fontFamily: 'SFUIText',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        InkWell(
                          child: Container(
                              height: 20,
                              width: 20,
                              decoration: BoxDecoration(
                                color: primaryclr,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(1.0),
                                child: Image.asset(
                                  "images/filter.png",
                                  color: Colors.white,
                                  height: 12,
                                ),
                              )),
                          onTap: () {
                            showModalBottomSheet(
                                context: context,
                                builder: (context) {
                                  return StatefulBuilder(builder:
                                      (BuildContext context,
                                          StateSetter setState) {
                                    return SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              .421,
                                      child: Center(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Column(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 18,
                                                          right: 18,
                                                          top: 12),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      const Text(
                                                        'Filter',
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 16,
                                                          fontFamily:
                                                              'SFUIText',
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                      ),
                                                      InkWell(
                                                        onTap: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: const Icon(
                                                          Icons.close,
                                                          color: Colors.black,
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                const Divider(
                                                  color: Color(0x1e000000),
                                                  thickness: 1,
                                                ),
                                              ],
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 18,
                                                  right: 18,
                                                  bottom: 12),
                                              child: Container(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    .21,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  vertical: 8),
                                                          child: InkWell(
                                                            onTap: () {
                                                              setState(() {
                                                                ac = 0;
                                                                veg = 1;
                                                                type = 0;
                                                                filter = 'veg';
                                                              });
                                                            },
                                                            child: Text(
                                                              'Veg/Non-veg',
                                                              style: TextStyle(
                                                                color: veg == 0
                                                                    ? const Color(
                                                                        0x7f000000)
                                                                    : const Color(
                                                                        0xffffb800),
                                                                fontSize: 10,
                                                                fontFamily:
                                                                    'SFUIText',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  vertical: 8),
                                                          child: InkWell(
                                                            onTap: () {
                                                              setState(() {
                                                                ac = 1;
                                                                veg = 0;
                                                                type = 0;
                                                                filter = "ac";
                                                              });
                                                            },
                                                            child: Text(
                                                              'AC/Non-AC',
                                                              style: TextStyle(
                                                                color: ac == 0
                                                                    ? const Color(
                                                                        0x7f000000)
                                                                    : const Color(
                                                                        0xffffb800),
                                                                fontSize: 10,
                                                                fontFamily:
                                                                    'SFUIText',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  vertical: 8),
                                                          child: InkWell(
                                                            onTap: () {
                                                              setState(() {
                                                                ac = 0;
                                                                veg = 0;
                                                                type = 1;
                                                                filter = "type";
                                                              });
                                                            },
                                                            child: Text(
                                                              'Type',
                                                              style: TextStyle(
                                                                color: type == 0
                                                                    ? const Color(
                                                                        0x7f000000)
                                                                    : const Color(
                                                                        0xffffb800),
                                                                fontSize: 10,
                                                                fontFamily:
                                                                    'SFUIText',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    const Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 18),
                                                      child: VerticalDivider(
                                                        color:
                                                            Color(0x1e000000),
                                                        thickness: 2,
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 12),
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            children: const [
                                                              Text(
                                                                'Filter by',
                                                                style:
                                                                    TextStyle(
                                                                  color: Color(
                                                                      0x7f000000),
                                                                  fontSize: 10,
                                                                  fontFamily:
                                                                      'SFUIText',
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          generateCheck(
                                                            context,
                                                            filter,
                                                            (bool? value) {
                                                              setState(() {
                                                                if (filter ==
                                                                    "veg") {
                                                                  vegcheck =
                                                                      value;
                                                                } else if (filter ==
                                                                    "ac") {
                                                                  accheck =
                                                                      value;
                                                                } else if (filter ==
                                                                    "type") {
                                                                  type1 = value;
                                                                }
                                                              });
                                                            },
                                                            (bool? value) {
                                                              setState(() {
                                                                if (filter ==
                                                                    "veg") {
                                                                  noncheck =
                                                                      value;
                                                                } else if (filter ==
                                                                    "ac") {
                                                                  nonaccheck =
                                                                      value;
                                                                } else if (filter ==
                                                                    "type") {
                                                                  type2 = value;
                                                                }
                                                              });
                                                            },
                                                          ),
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Container(
                                              decoration: const BoxDecoration(
                                                color: Colors.white,
                                                boxShadow: [
                                                  BoxShadow(
                                                      color:
                                                          Color(0xff57000000),
                                                      blurRadius: 10,
                                                      offset: Offset(0, -5)),
                                                ],
                                              ),
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  .087,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    ClearFilterButton(
                                                      text: "Clear Filter",
                                                      onTap: () {
                                                        setState(() {
                                                          vegcheck = false;
                                                          noncheck = false;
                                                          accheck = false;
                                                          nonaccheck = false;
                                                          type1 = false;
                                                          type2 = false;
                                                        });
                                                      },
                                                    ),
                                                    Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              .38,
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              .039,
                                                      child: ProfileButton(
                                                          text: "Apply",
                                                          onTap: () {
                                                            Navigator.pop(
                                                                context);
                                                            //todo:Apply the filters
                                                          }),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  });
                                });
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 18, right: 18, bottom: 5),
                  child: Container(
                    height: 70,
                    //MediaQuery.of(context).size.height * 0.09,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: const <Widget>[
                        DashBoardTopItem(
                          text: "Icecream",
                          img: "images/icecream.jpg",
                        ),
                        DashBoardTopItem(
                          text: "Cakes",
                          img: "images/dashboard/i1.jpg",
                        ),
                        DashBoardTopItem(
                          text: "Mocktails",
                          img: "images/dashboard/i2.jpeg",
                        ),
                        DashBoardTopItem(
                          text: "Snacks",
                          img: "images/dashboard/i3.webp",
                        ),
                        DashBoardTopItem(
                          text: "Icecream",
                          img: "images/icecream.jpg",
                        ),
                        DashBoardTopItem(
                          text: "Cakes",
                          img: "images/dashboard/i1.jpg",
                        ),
                        DashBoardTopItem(
                          text: "Mocktails",
                          img: "images/dashboard/i2.jpeg",
                        ),
                        DashBoardTopItem(
                          text: "Snacks",
                          img: "images/dashboard/i3.webp",
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 18, left: 18, top: 12),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height -
                        312 -
                        MediaQuery.of(context).padding.top -
                        MediaQuery.of(context).padding.bottom,
                    child: showList == true
                        ? Container(
                            child: isEmpty == false
                                ? Container(
                                    child: d == 1
                                        ? ListView.builder(
                                            itemCount: dres.length,
                                            itemBuilder: (context, index) {
                                              return DashBoardCard(
                                                  text: dres[index]['name'],
                                                  rating: "4.58",
                                                  feeds: "500",
                                                  location: dres[index]
                                                      ['location'],
                                                  types: dres[index]['type'],
                                                  img: dres[index]['image'],
                                                  ontap: () {
                                                    _showDetailsCard(
                                                        dres[index]['id'],
                                                        dres[index]['name']);
                                                  });
                                            })
                                        : ListView.builder(
                                            itemCount: tres.length,
                                            itemBuilder: (context, index) {
                                              return DashBoardCard(
                                                  text: tres[index]['name'],
                                                  rating: "4.58",
                                                  feeds: "500",
                                                  location: tres[index]
                                                      ['location'],
                                                  types: tres[index]['type'],
                                                  img: tres[index]['image'],
                                                  ontap: () {
                                                    _showDetailsCard(
                                                        dres[index]['id'],
                                                        dres[index]['name']);
                                                  });
                                            }),
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  PreferredSize buildAppBar(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(74
          //MediaQuery.of(context).size.height * .09

          ),
      child: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          // height: MediaQuery.of(context).size.height * .09 ,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(18),
                bottomLeft: Radius.circular(18)),
            boxShadow: [
              BoxShadow(
                color: Color(0x30000000),
                offset: Offset(0, -2),
                blurRadius: 19,
                spreadRadius: -1,
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 2),
                  child: Image.asset("images/location.png",
                      height: 18, color: primaryclr),
                ),
                address.locality == null
                    ? const Text(
                        "Location",
                        style: TextStyle(
                          color: Color(0xff1d1d1d),
                          fontSize: 10,
                          fontFamily: 'SFUIText',
                        ),
                      )
                    : Text(
                        address.locality.toString(),
                        style: const TextStyle(
                          color: Color(0xff1d1d1d),
                          fontSize: 10,
                          fontFamily: 'SFUIText',
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Column generateCheck(BuildContext context, String type,
      void Function(bool?)? onChanged1, void Function(bool?)? onChanged2) {
    if (type == "veg") {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Checkbox(
                activeColor: Color(0xffffb800),
                value: vegcheck,
                onChanged: onChanged1,
              ),
              const Text(
                "Veg",
                style: TextStyle(
                  color: Color(0x59000000),
                  fontSize: 12,
                  fontFamily: 'SFUIText',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Checkbox(
                activeColor: Color(0xffffb800),
                value: noncheck,
                onChanged: onChanged2,
              ),
              const Text(
                "Non-Veg",
                style: TextStyle(
                  color: Color(0x59000000),
                  fontSize: 12,
                  fontFamily: 'SFUIText',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      );
    } else if (type == "ac") {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Checkbox(
                activeColor: Color(0xffffb800),
                value: accheck,
                onChanged: onChanged1,
              ),
              const Text(
                "AC",
                style: TextStyle(
                  color: Color(0x59000000),
                  fontSize: 12,
                  fontFamily: 'SFUIText',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Checkbox(
                activeColor: Color(0xffffb800),
                value: nonaccheck,
                onChanged: onChanged2,
              ),
              const Text(
                "Non-AC",
                style: TextStyle(
                  color: Color(0x59000000),
                  fontSize: 12,
                  fontFamily: 'SFUIText',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      );
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Checkbox(
                activeColor: Color(0xffffb800),
                value: type1,
                onChanged: onChanged1,
              ),
              const Text(
                "Type 1",
                style: TextStyle(
                  color: Color(0x59000000),
                  fontSize: 12,
                  fontFamily: 'SFUIText',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Checkbox(
                activeColor: Color(0xffffb800),
                value: type2,
                onChanged: onChanged2,
              ),
              const Text(
                "Type 2",
                style: TextStyle(
                  color: Color(0x59000000),
                  fontSize: 12,
                  fontFamily: 'SFUIText',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      );
    }
  }
}

//Padding(
//   padding: const EdgeInsets.only(right: 5),
//   child: Image.asset("images/location.png",
//       height: 18, color: primaryclr),
// ),
// DropdownButtonHideUnderline(
//   child: DropdownButton(
//       value: dropdownvalue,
//       style: const TextStyle(
//         color: Color(0xff1d1d1d),
//         fontSize: 14.133333206176758,
//         fontFamily: 'SFUIText',
//         fontWeight: FontWeight.w700,
//       ),
//       items: items.map((String items) {
//         return DropdownMenuItem(
//           value: items,
//           child: Text(items),
//         );
//       }).toList(),
//       onChanged: (String? value) {
//         setState(() {
//           dropdownvalue = value!;
//         });
//       }),
// ),
