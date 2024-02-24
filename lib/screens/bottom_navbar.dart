import 'package:flutter/material.dart';
import 'package:test_se/constant/constant.dart';
import 'package:test_se/screens/menu_screen.dart';
import 'package:test_se/screens/order_list_screen.dart';

import 'promotion_screen.dart';

class BottomNavBarScreen extends StatefulWidget {
  const BottomNavBarScreen({super.key});

  @override
  State<BottomNavBarScreen> createState() => _BottomNavBarScreenState();
}

class _BottomNavBarScreenState extends State<BottomNavBarScreen> {
  int _currentIndex = 0;

  List<Widget> body = [
    const Menu(),
    const OrderList(),
    const Promotion(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: body[_currentIndex]),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color.fromARGB(255, 173, 188, 190),
        fixedColor: textColorPrimary,
        currentIndex: _currentIndex,
        onTap: (int newIndex) {
          setState(() {
            _currentIndex = newIndex;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.fastfood), label: 'Menu'),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_basket), label: 'Order'),
          BottomNavigationBarItem(
              icon: Icon(Icons.celebration), label: 'Promotion'),
        ],
      ),
    );
  }
}
