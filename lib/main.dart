import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test_se/firebase_options.dart';
import 'package:test_se/screens/bottom_navbar.dart';
import 'package:test_se/screens/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_se/screens/register_screen.dart';
import 'package:test_se/splash/splash.dart';

// import 'screens/login_screen.dart';
bool show = false;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // final prefs = await SharedPreferences.getInstance();
  // show = prefs.getBool('ehh') ?? false;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: GoogleFonts.mitr().fontFamily,
        brightness: Brightness.light,
        primaryColor: Colors.blue,
      ),
      routes: {
        '/': (context) => SplashScreen(
              child: Login(),
            ),
        '/login': (context) => Login(),
        // '/admin': (context) => AdminScreen(),
        '/signUp': (context) => Register(),
        '/home': (context) => BottomNavBarScreen(),
      },
    );
  }
}
