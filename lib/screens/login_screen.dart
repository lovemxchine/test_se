import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../components/button_field.dart';
import '../components/text_field.dart';

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
          Positioned(
            top: -50,
            left: -5,
            right: -5,
            // alignment: const AlignmentDirectional(0, -1.34),
            child: Container(
              width: 415,
              height: 393,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xff396870),
                    Color(0xff17333C),
                  ],
                  stops: [0, 1],
                  begin: AlignmentDirectional(0, -0.8),
                  end: AlignmentDirectional(0, 1.5),
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(48),
                  bottomRight: Radius.circular(48),
                  // topLeft: Radius.circular(0),
                  // topRight: Radius.circular(0),
                ),
              ),
            ),
          ),
          // รูป logo
          Positioned(
            top: 80,
            left: 0,
            right: 0,
            child: Align(
              child: Container(
                width: 110,
                height: 110,
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                      blurRadius: 10,
                      color: Color(0x33000000),
                      offset: Offset(0, 2),
                    )
                  ],
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Align(
                  alignment: const AlignmentDirectional(0, 0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      'assets/images/logo.png',
                      width: 300,
                      height: 200,
                      fit: BoxFit.cover,
                      alignment: const Alignment(0, 0),
                    ),
                  ),
                ),
              ),
            ),
          ),
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
                                    text: "LOGIN",
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
          //text สมัครรหัส
          Positioned(
            top: 540,
            left: 0,
            right: 0,
            child: Container(
              alignment: Alignment.center,
              child: GestureDetector(
                onTap: () {
                  // Navigator.pop(context);
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
