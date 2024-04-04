import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_se/screens/main_screen/checkbill_screen.dart';
// import 'package:test_se/screens/checkbill_screen.dart';
import '../promotion/promotion_screen.dart';
import '../main_screen/status_order.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class EmployeeScreen extends StatefulWidget {
  const EmployeeScreen({super.key});

  @override
  State<EmployeeScreen> createState() => _EmployeeScreenState();
}

class _EmployeeScreenState extends State<EmployeeScreen> {
  int _currentIndex = 0;

  List<Widget> body = [
    CheckBill(),
    const Promotion(),
    // const Status(),
    // const TimeCheckIn_Out(),
  ];
  @override
  void initState() {
    super.initState();
    _checkUserRole();
  }

  void _checkUserRole() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userRole = prefs.getString('userRole');
    if (userRole != 'employee') {
      FirebaseAuth.instance.signOut();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.remove('userRole');
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: StreamBuilder<DocumentSnapshot>(
        stream: _getUserStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            bool status = snapshot.data!.get('isReady');
            String employee_name = snapshot.data!.get('employee_name');

            String table = snapshot.data!.get('call_number');
            if (status) {
              WidgetsBinding.instance!.addPostFrameCallback((_) {
                showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Center(
                          child: table != ''
                              ? Text(
                                  'ลูกค้า ${table} ',
                                  style: TextStyle(
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.045),
                                )
                              : Text(
                                  'มารับอาหารที่ครัว\nไปส่งที่ลูกค้า ${employee_name} ',
                                  style: TextStyle(
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.045),
                                )),
                      actions: [
                        Center(
                          child: TextButton(
                            onPressed: employee_name != '' || table != ''
                                ? () {
                                    FirebaseFirestore.instance
                                        .collection('user')
                                        .doc(FirebaseAuth
                                            .instance.currentUser!.uid)
                                        .update({
                                      'isReady': false,
                                      'call_number': '',
                                      'employee_name': ''
                                    });
                                    Navigator.of(context).pop();
                                  }
                                : () {
                                    FirebaseFirestore.instance
                                        .collection('user')
                                        .doc(FirebaseAuth
                                            .instance.currentUser!.uid)
                                        .update({
                                      'isReady': false,
                                      'employee_name': ''
                                    });
                                    Navigator.of(context).pop();
                                  },
                            child: Text(
                              'รับทราบ',
                              style: TextStyle(
                                  fontSize: MediaQuery.of(context).size.width *
                                      0.035),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                );
              });
            }
            return Center(
              child: body[_currentIndex],
            );
          } else {
            return Center(child: Text('No data'));
          }
        },
      ),
      bottomNavigationBar: CurvedNavigationBar(
        height: 60,
        buttonBackgroundColor: Color.fromARGB(255, 240, 210, 120),
        backgroundColor: Colors.white,
        color: const Color.fromARGB(255, 201, 225, 221),
        animationCurve: Curves.easeInOut,
        animationDuration: const Duration(milliseconds: 300),
        onTap: (int newIndex) {
          setState(() {
            _currentIndex = newIndex;
          });
        },
        items: const [
          Icon(
            Icons.price_check,
            color: Colors.black,
          ),
          Icon(
            Icons.celebration,
            color: Colors.black,
          ),
          // Icon(
          //   Icons.checklist,
          //   color: Colors.black,
          // ),
        ],
      ),
    );
  }

  Stream<DocumentSnapshot> _getUserStream() {
    String userId = FirebaseAuth.instance.currentUser!.uid;
    return FirebaseFirestore.instance
        .collection('user')
        .doc(userId)
        .snapshots();
  }
}
