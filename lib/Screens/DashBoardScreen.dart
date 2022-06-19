import 'package:eatplek/Components/BottomBar.dart';
import 'package:flutter/material.dart';

class DashBoardScreen extends StatefulWidget {
  static const String id = '/dashboard';
  const DashBoardScreen({Key? key}) : super(key: key);

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  @override
  Widget build(BuildContext context) {
    var items = ['Home', 'Office'];
    String dropdownvalue = 'Home';
    String address = 'Mc Hostel, Aramana Road, Chengannur, Keral...';
    return Scaffold(
      bottomNavigationBar: const BottomBar(
        index: 0,
      ),
      appBar: PreferredSize(
        preferredSize:
            Size.fromHeight(MediaQuery.of(context).size.height * .08),
        child: SafeArea(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * .08,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
              boxShadow: const [
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
      ),
    );
  }
}
