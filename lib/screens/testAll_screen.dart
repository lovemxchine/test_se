import 'package:flutter/material.dart';
import 'package:test_se/screens/login_screen.dart';
import 'package:test_se/screens/register_screen.dart';
import 'package:test_se/screens/stock_screen.dart';

import 'bottom_navbar.dart';

class TestPage extends StatelessWidget {
  const TestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey,
      child: Column(
        children: [
          const SizedBox(height: 20),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Login()),
              );
            },
            child: const Text(
              'Login',
              style: TextStyle(
                  fontSize: 20,
                  decoration: TextDecoration.none,
                  color: Colors.black),
            ),
          ),
          const SizedBox(height: 20),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Register()),
              );
            },
            child: const Text(
              'Register',
              style: TextStyle(
                  fontSize: 20,
                  decoration: TextDecoration.none,
                  color: Colors.black),
            ),
          ),
          const SizedBox(height: 20),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => BottomNavBarScreen()),
              );
            },
            child: const Text(
              'Menu',
              style: TextStyle(
                  fontSize: 20,
                  decoration: TextDecoration.none,
                  color: Colors.black),
            ),
          ),
          const SizedBox(height: 20),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => StockScreen()),
              );
            },
            child: const Text(
              'Stock',
              style: TextStyle(
                  fontSize: 20,
                  decoration: TextDecoration.none,
                  color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}
