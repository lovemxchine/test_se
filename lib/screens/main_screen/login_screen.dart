import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_se/auth/firebase_auth_service.dart';
import '../../components/text_field.dart';
import '../../widgets/logo_image.dart';
import '../../widgets/logo_zone.dart';

class Login extends StatefulWidget {
  Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final FirebaseAuthService _auth = FirebaseAuthService();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool _isPressed = false;
  bool _isLoading = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async {
        return FirebaseAuth.instance.currentUser == null;
      },
      child: Scaffold(
        body: Stack(
          children: [
            const LogoZone(),
            const LogoImage(),
            Positioned(
              top: 250,
              left: 50,
              right: 50,
              child: Container(
                width: 300,
                height: 282,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 10,
                      color: Color(0xA2000000),
                      offset: Offset(2, 2),
                    )
                  ],
                  borderRadius: BorderRadius.all(Radius.circular(24)),
                ),
                alignment: const AlignmentDirectional(0, 0),
                child: Align(
                  alignment: const AlignmentDirectional(0, 0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Align(
                        alignment: const AlignmentDirectional(0, 0),
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: "LogIn",
                                      style: GoogleFonts.mitr(
                                        textStyle: const TextStyle(
                                            color: Color(0xff3C696F),
                                            fontSize: 20,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                    const TextSpan(text: "  "),
                                    TextSpan(
                                      text: "เข้าสู่ระบบ",
                                      style: GoogleFonts.mitr(
                                        textStyle: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Form(
                        child: Column(
                          children: [
                            MyTextField(
                              hintText: "Enter your Email",
                              controller: emailController,
                              obscureText: false,
                              labelText: "Email",
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            MyTextField(
                              hintText: "Enter your Password",
                              controller: passwordController,
                              obscureText: true,
                              labelText: "Password",
                            ),
                            const SizedBox(
                              height: 24,
                            ),
                            GestureDetector(
                              onTapUp: (details) {
                                setState(() {
                                  _isPressed = false;
                                });
                              },
                              onTapDown: (details) {
                                setState(() {
                                  _isPressed = true;
                                });
                              },
                              onTap: _signIn,
                              child: Container(
                                padding: const EdgeInsets.all(10.0),
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 30.0,
                                ),
                                decoration: BoxDecoration(
                                  color: _isPressed
                                      ? Color.fromARGB(255, 63, 97, 102)
                                      : Color(0xff396870),
                                  borderRadius: BorderRadius.circular(20.0),
                                  boxShadow: const [
                                    BoxShadow(
                                      blurRadius: 10,
                                      color: Color.fromARGB(152, 0, 0, 0),
                                      offset: Offset(1, 2),
                                    )
                                  ],
                                ),
                                child: Center(
                                  child: Text(
                                    'เข้าสู่ระบบ',
                                    style: GoogleFonts.poppins(
                                      textStyle: Theme.of(context)
                                          .textTheme
                                          .titleLarge,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            if (_isLoading)
              Container(
                color: Colors.black.withOpacity(0.5),
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
          ],
        ),
      ),
    );
  }

  void _signIn() async {
    String email = emailController.text;
    String password = passwordController.text;

    setState(() {
      _isLoading = true;
    });

    User? user = await _auth.signInWithEmailAndPassword(
        email, password); //สร้างข้อมูล user โดยใช้ class ที่สร้างไว้อีกไฟล์

    setState(() {
      _isLoading = false;
    });
    // ตรวจว่า User ไม่ได้มีข้อมูลที่ login เข้ามาอยู่แล้ว
    if (user != null) {
      SharedPreferences prefs = await SharedPreferences
          .getInstance(); //สร้างตัวแปรสำหรับ sharedpreference
      print("Login is successfully signed");

      final snapshot = await FirebaseFirestore.instance
          .collection('user')
          .where('uid', isEqualTo: user.uid)
          .get();
      final userData = snapshot.docs[0].data();
      if (userData.containsKey('role')) {
        // เช็คว่าข้อมูลใน db มี field ที่เป็น role ไหม
        String role =
            userData['role']; //เก็บ field role ในตัวแปร role ที่สร้างมา

        saveUserRole(
            role); //ใช้ function saveUserRole เพื่อเก็บ role ในตัวแปรของ sharedpreference

        if (role == 'employee' || role == 'chef') {
          CollectionReference userCollection =
              FirebaseFirestore.instance.collection('user');
          DocumentReference userDocRef = userCollection.doc(user.uid);

          userDocRef.collection('check_in').add(
            {
              'uid': user.uid,
              'time': Timestamp.now(),
            },
          );
        }

        route(role);
      } else {
        print('Error: User document does not contain "role" field');
      }
    } else {
      _showErrorDialog();
    }
  }

  void saveUserRole(String role) async {
    SharedPreferences.getInstance().then(
      (prefs) {
        prefs.setString('userRole', role);
      },
    );
  }

  void route(String role) {
    switch (role) {
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
        Navigator.pushReplacementNamed(context, "/");
    }
  }

  void _showErrorDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Error"),
          content: Text("Some error occurred while signing in."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }
}
