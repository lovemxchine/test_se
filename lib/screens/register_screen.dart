import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test_se/auth/firebase_auth_service.dart';
import 'package:test_se/screens/login_screen.dart';
import 'package:test_se/widgets/realtime_widget.dart';

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
  final telController = TextEditingController();
  final ageController = TextEditingController();

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
          Positioned(
            top: 40,
            left: 10,
            right: 10,
            child: Realtime(),
          ),
          // รูป logo
          const LogoImage(),
          //โซน login
          Positioned(
            top: 200,
            left: 50,
            right: 50,
            // alignment: AlignmentDirectional(0, -0.10),
            child: Container(
              width: 300,
              height: 470,
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
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: "Sign_In",
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
                    Form(
                      child: Column(
                        children: [
                          MyTextField(
                            hintText: "กรอกอีเมล์",
                            controller: emailController,
                            obscureText: false,
                            labelText: "Email",
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          MyTextField(
                            hintText: "กรอกชื่อจริงนามสกุล",
                            controller: userController,
                            obscureText: false,
                            labelText: "Username",
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          MyTextField(
                            hintText: "กรอกอายุ",
                            controller: ageController,
                            obscureText: false,
                            labelText: "Age",
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          MyTextField(
                            hintText: "กรอกเบอร์โทรศัพท์",
                            controller: telController,
                            obscureText: false,
                            labelText: "Telephone Number",
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          MyTextField(
                            hintText: "กรอกรหัสผ่าน",
                            controller: passwordController,
                            obscureText: true,
                            labelText: "Password",
                          ),
                          const SizedBox(
                            height: 17,
                          ),
                          MyButton(
                            onTap: _signUp,
                            hinText: 'Register',
                          ),
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
            top: 675,
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
                  'Sign-In',
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
          // StreamBuilder(stream: _si, builder: builder)
        ],
      ),
    );
    // ),
    // );
  }

  void _signUp() async {
    User? user = await _auth.signUpWithEmailAndPassword(
        emailController.text, passwordController.text);

    if (user != null) {
      String uid = user.uid;
      await addUserCollection(
          userController.text.trim(),
          emailController.text.trim(),
          'customer',
          int.parse(ageController.text.trim()),
          Timestamp.now(),
          uid,
          telController.text.trim(),
          true
          )
          ;
      print("User is successfully created");
      Navigator.pushNamed(context, "/login");
    } else {
      print('Some error happen');
    }
  }

  Future addUserCollection(String name, String email, String role, int age,
      Timestamp init_time, String uid, String tel , bool notic// Add uid as an argument here
      ) async {
    await FirebaseFirestore.instance.collection('user').doc(uid).set({
      'name': name,
      'email': email,
      'role': role,
      'age': age,
      'init_time': init_time,
      'uid': uid, // Use uid here
      'tel': tel,
      'notic':notic,
    });
  }
}
