import 'package:flutter/material.dart';
import 'package:test_se/screens/menu_screen.dart';
import 'package:test_se/screens/order_list_screen.dart';
import '../promotion_screen.dart';
import '../status_order.dart';
import '../stock_screen.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class CustomerScreen extends StatefulWidget {
  const CustomerScreen({super.key});

  @override
  State<CustomerScreen> createState() => _CustomerScreenState();
}

class _CustomerScreenState extends State<CustomerScreen> {
  int _currentIndex = 0;

  List<Widget> body = [
    const Menu(),
    const OrderList(),
    const Promotion(),
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
        ],
      ),
    );
  }
}
