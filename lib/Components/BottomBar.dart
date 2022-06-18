import 'package:flutter/material.dart';

class BottomBar extends StatefulWidget {
  final int index;
  const BottomBar({Key? key, required this.index}) : super(key: key);

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  final pages = [];
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: (value) {
        print(value);
      },
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
            icon: Image.asset('images/bottomnavigationbar/home.png'),
            label: 'Home',
            activeIcon: Image.asset('images/bottomnavigationbar/home1.png')),
        BottomNavigationBarItem(
          icon: Image.asset('images/bottomnavigationbar/cart.png'),
          label: 'Cart',
          activeIcon: Image.asset('images/bottomnavigationbar/cart1.png'),
        ),
        BottomNavigationBarItem(
          icon: Image.asset('images/bottomnavigationbar/history.png'),
          label: 'History',
          activeIcon: Image.asset('images/bottomnavigationbar/history1.png'),
        ),
        BottomNavigationBarItem(
          icon: Image.asset('images/bottomnavigationbar/profile.png'),
          label: 'Profile',
          activeIcon: Image.asset('images/bottomnavigationbar/profile1.png'),
        ),
      ],
      elevation: 30,
      showSelectedLabels: true,
      showUnselectedLabels: true,
    );
  }
}
