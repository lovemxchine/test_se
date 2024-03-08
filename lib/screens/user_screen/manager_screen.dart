import 'package:flutter/material.dart';
import 'package:test_se/screens/edit_menu.dart';
import 'package:test_se/screens/menu_screen.dart';
import 'package:test_se/screens/order_list_screen.dart';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:test_se/screens/promotion_screen.dart';
import 'package:test_se/screens/status_order.dart';
import 'package:test_se/screens/stock_screen.dart';

class ManagerScreen extends StatefulWidget {
  const ManagerScreen({super.key});

  @override
  State<ManagerScreen> createState() => _ManagerScreenState();
}

class _ManagerScreenState extends State<ManagerScreen> {
  int _currentIndex = 0;

  List<Widget> body = [
    const Menu(),
    const OrderList(),
    const Promotion(),
    const Status(),
    EditMenu(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(child: body[_currentIndex]),
      bottomNavigationBar: CurvedNavigationBar(
        height: 60,
        buttonBackgroundColor: Colors.amber,
        backgroundColor: Colors.white,
        color: const Color.fromARGB(255, 201, 225, 221),
        animationCurve: Curves.easeInOut,
        animationDuration: const Duration(milliseconds: 300),
        onTap: (int newIndex) {
          setState(() {
            _currentIndex = newIndex;
          });
        },
        items: const [
          Icon(
            Icons.fastfood,
            color: Colors.black,
          ),
          Icon(
            Icons.shopping_basket,
            color: Colors.black,
          ),
          Icon(
            Icons.celebration,
            color: Colors.black,
          ),
          Icon(
            Icons.access_time_filled,
            color: Colors.black,
          ),
          Icon(
            Icons.settings,
            color: Colors.black,
          ),
        ],
      ),
    );
  }
}
