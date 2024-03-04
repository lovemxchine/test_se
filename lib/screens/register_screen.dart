import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test_se/auth/firebase_auth_service.dart';
import 'package:test_se/screens/login_screen.dart';

import '../components/button_field.dart';
import '../components/text_field.dart';
import '../widgets/logo_image.dart';
import '../widgets/logo_zone.dart';

class Register extends StatefulWidget {
  Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final FirebaseAuthService _auth = FirebaseAuthService();
  final userController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  // void dispose() {
  //   userController.dispose();
  //   emailController.dispose();
  //   passwordController.dispose();
  //   confirmPasswordController.dispose();
  //   super.dispose();
  // }

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
              height: 400,
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
                                    text: "Register",
                                    style: GoogleFonts.mitr(
                                      textStyle: const TextStyle(
                                          color: Color(0xff3C696F),
                                          fontSize: 20,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                  const TextSpan(text: "  "),
                                  TextSpan(
                                    text: "สมัครใช้งาน",
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
                            hintText: "Enter your Username",
                            controller: userController,
                            obscureText: false,
                            labelText: "Username",
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
                            height: 20,
                          ),
                          MyTextField(
                            hintText: "Confirm your Password",
                            controller: confirmPasswordController,
                            obscureText: true,
                            labelText: "Confirm Password",
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          MyButton(
                            onTap: _signUp,
                            hinText: 'Register',
                          )
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
            top: 660,
            left: 0,
            right: 0,
            child: Container(
              alignment: Alignment.center,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Login()),
                  );
                },
                child: Text(
                  'Register',
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

  void _signUp() async {
    String username = userController.text;
    String email = emailController.text;
    String password = passwordController.text;

    User? user = await _auth.signUpWithEmailAndPassword(email, password);

    if (user != null) {
      print("User is successfully created");
      Navigator.pushNamed(context, "/home");
    } else {
      print('Some error happen');
    }
  }
}
