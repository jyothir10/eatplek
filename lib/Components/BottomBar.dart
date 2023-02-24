import 'package:eatplek/Screens/CartScreen.dart';
import 'package:eatplek/Screens/DashBoardScreen.dart';
import 'package:eatplek/Screens/OrderHistoryScreen.dart';
import 'package:eatplek/Screens/ProfileScreen.dart';
import 'package:flutter/material.dart';

class BottomBar extends StatefulWidget {
  final int index;
  const BottomBar({Key? key, required this.index}) : super(key: key);

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _selectedIndex = 0;
  final pages = [
    DashBoardScreen.id,
    CartScreen.id,
    OrderHistoryScreen.id,
    ProfileScreen.id
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      Navigator.pushReplacementNamed(context, pages[index]);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 90,
      child: BottomNavigationBar(
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        currentIndex: widget.index,
        selectedLabelStyle: const TextStyle(
          color: Color(0x33042e60),
          fontSize: 9.45121955871582,
          fontFamily: 'SFUIText',
        ),
        unselectedLabelStyle: const TextStyle(
          color: Color(0xff042e60),
          fontSize: 9.45121955871582,
          fontFamily: 'SFUIText',
        ),
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Image.asset(
                'images/bottomnavigationbar/home.png',
                height: 23,
              ),
              label: ' Home',
              activeIcon: Image.asset(
                'images/bottomnavigationbar/home1.png',
                height: 23,
              )),
          BottomNavigationBarItem(
            icon: Image.asset(
              'images/bottomnavigationbar/cart.png',
              height: 23,
            ),
            label: ' Cart',
            activeIcon: Image.asset(
              'images/bottomnavigationbar/cart1.png',
              height: 23,
            ),
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'images/bottomnavigationbar/history.png',
              height: 23,
            ),
            label: ' History',
            activeIcon: Image.asset(
              'images/bottomnavigationbar/history1.png',
              height: 23,
            ),
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'images/bottomnavigationbar/profile.png',
              height: 23,
            ),
            label: 'Profile',
            activeIcon: Image.asset(
              'images/bottomnavigationbar/profile1.png',
              height: 23,
            ),
          ),
        ],
        elevation: 30,
        showSelectedLabels: true,
        showUnselectedLabels: true,
      ),
    );
  }
}
