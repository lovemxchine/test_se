import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:test_se/screens/main_screen/menu_screen.dart';
import 'package:test_se/screens/main_screen/order_list_screen.dart';
import 'package:test_se/screens/main_screen/order_waiting.dart';
import '../promotion/promotion_screen.dart';
import '../main_screen/status_order.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class ChefScreen extends StatefulWidget {
  const ChefScreen({super.key});

  @override
  State<ChefScreen> createState() => _ChefScreenState();
}

class _ChefScreenState extends State<ChefScreen> {
  int _currentIndex = 0;

  List<Widget> body = [
    const OrderWaiting(),
    const Status(),
  ];
  @override
  void initState() {
    super.initState();
    _checkUserRole();
  }

  void _checkUserRole() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userRole = prefs.getString('userRole');
    if (userRole != 'chef') {
      FirebaseAuth.instance.signOut();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.remove('userRole');
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (FirebaseAuth.instance.currentUser != null) {
          return false;
        } else {
          return true;
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(child: body[_currentIndex]),
        bottomNavigationBar: CurvedNavigationBar(
          height: 60,
          buttonBackgroundColor: Color.fromARGB(255, 240, 210, 120),
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
              Icons.food_bank,
              color: Colors.black,
            ),
          ],
        ),
      ),
    );
  }
}
