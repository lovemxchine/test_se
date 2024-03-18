import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  final Widget? child;
  const SplashScreen({super.key, this.child});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    _route();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "Welcome To Flutter Firebase",
          style: TextStyle(
            color: Colors.blue,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Future<void> _route() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userRole = prefs.getString('userRole');

    switch (userRole) {
      case "manager":
        Navigator.pushReplacementNamed(context, "/manager");
        break;
      case "customer":
        Navigator.pushReplacementNamed(context, "/customer");
        break;
      case "employee":
        Navigator.pushReplacementNamed(context, "/employee");
        break;
      case "chef":
        Navigator.pushReplacementNamed(context, "/chef");
        break;
      default:
        Navigator.pushReplacementNamed(context, "/login");
    }
  }
}
