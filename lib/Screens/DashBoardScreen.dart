import 'package:eatplek/Components/BottomBar.dart';
import 'package:eatplek/Components/ClearFilterButton.dart';
import 'package:eatplek/Components/DashBoardCard.dart';
import 'package:eatplek/Components/DashBoardTopItem.dart';
import 'package:eatplek/Components/ProfileButton.dart';
import 'package:flutter/material.dart';

class DashBoardScreen extends StatefulWidget {
  static const String id = '/dashboard';
  const DashBoardScreen({Key? key}) : super(key: key);

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  int d = 1, t = 0, veg = 1, ac = 0, type = 0;
  bool? vegcheck = false, noncheck = false, accheck = false, nonaccheck = false;
  var items = ['Home', 'Office'];
  String dropdownvalue = 'Home';
  @override
  Widget build(BuildContext context) {
    String address = 'Mc Hostel, Aramana Road, Chengannur, Keral...';
    return Scaffold(
      bottomNavigationBar: const BottomBar(
        index: 0,
      ),
      appBar: buildAppBar(context, address), //look at bottom for code
      body: Container(
        color: Colors.white,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
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
                                d == 1
                                    ? const Color(0xff042e60)
                                    : const Color(0xfff0ecec)),
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
                      width: MediaQuery.of(context).size.width * .26,
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
                              t == 1
                                  ? const Color(0xff042e60)
                                  : const Color(0xfff0ecec)),
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
                      const EdgeInsets.symmetric(horizontal: 21, vertical: 18),
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
                        child: Image.asset("images/filter.png"),
                        onTap: () {
                          showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return StatefulBuilder(builder:
                                    (BuildContext context,
                                        StateSetter setState) {
                                  return SizedBox(
                                    height: MediaQuery.of(context).size.height *
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
                                                padding: const EdgeInsets.only(
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
                                                        fontFamily: 'SFUIText',
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                    InkWell(
                                                      onTap: () {
                                                        Navigator.pop(context);
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
                                                      color: Color(0x1e000000),
                                                      thickness: 2,
                                                    ),
                                                  ),
                                                  Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: const [
                                                          Text(
                                                            'Filter by',
                                                            style: TextStyle(
                                                              color: Color(
                                                                  0x7f000000),
                                                              fontSize: 10,
                                                              fontFamily:
                                                                  'SFUIText',
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        children: [
                                                          Checkbox(
                                                            activeColor: Color(
                                                                0xffffb800),
                                                            value: vegcheck,
                                                            onChanged:
                                                                (bool? value) {
                                                              setState(() {
                                                                vegcheck =
                                                                    value;
                                                              });
                                                            },
                                                          ),
                                                          const Text(
                                                            'Veg',
                                                            style: TextStyle(
                                                              color: Color(
                                                                  0x59000000),
                                                              fontSize: 12,
                                                              fontFamily:
                                                                  'SFUIText',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                            ),
                                                          ),
                                                        ],
                                                      )
                                                    ],
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
                                                    color: Color(0xff57000000),
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
                                                    onTap: () {},
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
                                                        onTap: () {}),
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
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.09,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: <Widget>[
                        DashBoardTopItem(
                          text: "icecream",
                          img: "images/icecream.jpg",
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 18, left: 18, top: 12),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * .57,
                    child: ListView(
                      scrollDirection: Axis.vertical,
                      physics: const AlwaysScrollableScrollPhysics(),
                      children: const [
                        DashBoardCard(
                          img: "images/fd.png",
                          text: "The Smoky Shack",
                          rating: "4.85",
                          feeds: "555",
                          location: 'Arabian, Bevrages, Juice\nChengannur',
                        ),
                      ],
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

  PreferredSize buildAppBar(BuildContext context, String address) {
    return PreferredSize(
      preferredSize: Size.fromHeight(MediaQuery.of(context).size.height * .09),
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 5),
                        child: Image.asset(
                          "images/location.png",
                          height: 20,
                        ),
                      ),
                      DropdownButtonHideUnderline(
                        child: DropdownButton(
                            value: dropdownvalue,
                            style: const TextStyle(
                              color: Color(0xff1d1d1d),
                              fontSize: 14.133333206176758,
                              fontFamily: 'SFUIText',
                              fontWeight: FontWeight.w700,
                            ),
                            items: items.map((String items) {
                              return DropdownMenuItem(
                                value: items,
                                child: Text(items),
                              );
                            }).toList(),
                            onChanged: (String? value) {
                              setState(() {
                                dropdownvalue = value!;
                              });
                            }),
                      )
                    ],
                  ),
                  Text(
                    address,
                    style: const TextStyle(
                      color: Color(0xff1d1d1d),
                      fontSize: 10,
                      fontFamily: 'SFUIText',
                    ),
                  ),
                ],
              ),
              Image.asset("images/search.png"),
            ],
          ),
        ),
      ),
    );
  }
}
