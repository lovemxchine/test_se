import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_se/screens/menu_screen.dart';
import 'package:test_se/screens/order_list_screen.dart';
import '../promotion/promotion_screen.dart';
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
  void _checkUserRole() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userRole = prefs.getString('userRole');
    if (userRole != 'customer') {
      FirebaseAuth.instance.signOut();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.remove('userRole');
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  @override
  void initState() {
    super.initState();
    _checkUserRole();
  }

  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (FirebaseAuth.instance.currentUser != null) {
          // ถ้าผู้ใช้ล็อกอินอยู่ กำหนดให้ไม่สามารถย้อนกลับได้
          return false;
        } else {
          // ถ้าไม่ได้ล็อกอิน อนุญาตให้ย้อนกลับได้
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
              Icons.shopping_basket,
              color: Colors.black,
            ),
            Icon(
              Icons.new_releases,
              color: Colors.black,
            ),
          ],
        ),
      ),
    );
  }
}
