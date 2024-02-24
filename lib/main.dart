import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test_se/screens/bottom_navbar.dart';
import 'package:test_se/screens/menu_screen.dart';
import 'package:test_se/screens/stock_screen.dart';
import 'package:test_se/screens/testAll_screen.dart';
// import 'screens/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: GoogleFonts.mitr().fontFamily,
        brightness: Brightness.light,
        primaryColor: Colors.blue,
      ),
      home: const BottomNavBarScreen(),
    );
  }
}
