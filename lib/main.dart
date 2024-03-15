import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_se/firebase_options.dart';
import 'package:test_se/provider/provider.dart';
import 'package:test_se/screens/admin_register_screen.dart';
import 'package:test_se/screens/login_screen.dart';
import 'package:test_se/screens/user_screen/chef_screen.dart';
import 'package:test_se/screens/user_screen/customer_screen.dart';
import 'package:test_se/screens/user_screen/employee_screen.dart';
import 'package:test_se/screens/user_screen/manager_screen.dart';
import 'package:test_se/splash/splash.dart';

bool show = false;


Future main() async {
  AwesomeNotifications().initialize(
    null,
    [
      NotificationChannel(
        channelKey: 'restaurant',
        channelName: 'restaurant_notification',
        channelDescription: 'notification for serve',
        defaultColor: Colors.redAccent,
        ledColor: Colors.white,
        importance: NotificationImportance.Max,
        channelShowBadge: true,
        locked: true,
      )
    ],
    debug: true,
  );
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SharedPreferences prefs = await SharedPreferences.getInstance();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });
    super.initState();
  }

  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => CartProvider()),
          ChangeNotifierProvider(create: (_) => ConfirmCart()), //
        ],
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              fontFamily: GoogleFonts.mitr().fontFamily,
              brightness: Brightness.light,
              primaryColor: Colors.blue,
            ),
            routes: {
              '/': (context) => Login(),
              '/login': (context) => Login(),
              '/admin_reg': (context) => AdminRegister(),
              '/customer': (context) => const CustomerScreen(),
              '/chef': (context) => const ChefScreen(),
              '/manager': (context) => const ManagerScreen(),
              '/employee': (context) => const EmployeeScreen(),
            }));
  }
}
