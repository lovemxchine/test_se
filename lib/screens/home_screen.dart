import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../components/text_field.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

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
              height: 272,
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
                              text: const TextSpan(
                                children: [
                                  TextSpan(
                                    text: "LOGIN",
                                    style: TextStyle(
                                      color: Color(0xff3C696F),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      fontFamily: 'Mitr',
                                    ),
                                  ),
                                  TextSpan(text: " "),
                                  TextSpan(
                                    text: "เข้าสู่ระบบ",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      fontFamily: 'Mitr',
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
                      child: MyTextField(
                        hintText: "Enter your Username",
                        controller: emailController,
                        obscureText: false,
                        labelText: "Username",
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
    // ),
    // );
  }
}
