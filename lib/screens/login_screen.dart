import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../components/button_field.dart';
import '../components/text_field.dart';
import '../widgets/logo_image.dart';
import '../widgets/logo_zone.dart';
import 'register_screen.dart';

class Login extends StatelessWidget {
  Login({super.key});
  final userController = TextEditingController();
  final passwordController = TextEditingController();
  loginWithPassword() {}

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
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(24),
                  bottomRight: Radius.circular(24),
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
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
                            obscureText: false,
                            labelText: "Password",
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          MyButton(onTap: loginWithPassword, hinText: 'LogIn'),
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
}
