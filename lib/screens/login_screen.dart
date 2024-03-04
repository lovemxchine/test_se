import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test_se/auth/firebase_auth_service.dart';

import '../components/button_field.dart';
import '../components/text_field.dart';
import '../widgets/logo_image.dart';
import '../widgets/logo_zone.dart';
import 'bottom_navbar.dart';
import 'register_screen.dart';

class Login extends StatefulWidget {
  Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final FirebaseAuthService _auth = FirebaseAuthService();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  // void loginWithPassword(BuildContext context) {
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(builder: (context) => const BottomNavBarScreen()),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("Register/Login"),
      // ),
      body: Stack(
        children: [
          //โซน logo , logo zone
          const LogoZone(),
          // รูป logo
          const LogoImage(),
          //โซน login
          Positioned(
            top: 250,
            left: 50,
            right: 50,
            // alignment: AlignmentDirectional(0, -0.10),
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
                          MyButton(onTap: _signIn, hinText: 'LogIn'),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          //text สมัครรหัส
          Positioned(
            top: 540,
            left: 0,
            right: 0,
            child: Container(
              alignment: Alignment.center,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Register()),
                  );
                },
                child: Text(
                  'สมัครรหัสสมาชิก',
                  style: GoogleFonts.mitr(
                    textStyle: const TextStyle(
                      color: Color.fromARGB(255, 49, 93, 101),
                      decoration: TextDecoration.underline,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
    // ),
    // );
  }

  void _signIn() async {
    String email = emailController.text;
    String password = passwordController.text;

    User? user = await _auth.signInWithEmailAndPassword(email, password);

    if (user != null) {
      print("Login is successfully signed");
      Navigator.pushNamed(context, "/home");
    } else {
      print('Some error happen');
    }
  }
}
