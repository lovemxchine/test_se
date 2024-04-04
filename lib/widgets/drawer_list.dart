import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DrawerList extends StatefulWidget {
  const DrawerList({super.key});
  @override
  State<DrawerList> createState() => _DrawerListState();
}

class _DrawerListState extends State<DrawerList> {
  late SharedPreferences _prefs;
  late String userRole;

  @override
  void initState() {
    super.initState();

    _initPrefs();
  }

  _initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      userRole = _prefs.getString('userRole') ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    // String? userRole = _prefs.getString('userRole');

    User? user = FirebaseAuth.instance.currentUser;
    String user_id = user!.uid;
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            child: null,
            decoration: BoxDecoration(
              color: Color(0xff3C696F),
              gradient: LinearGradient(
                colors: [Color(0xff396870), Color(0xff17333C)],
                stops: [0, 1],
                begin: AlignmentDirectional(0, -0.8),
                end: AlignmentDirectional(0, 1.5),
                tileMode: TileMode.clamp,
              ),
            ),
          ),
          if (userRole == 'customer')
            ListTile(
              leading: const Icon(Icons.edit_document),
              title: const Text('เรียกพนักงาน'),
              onTap: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                String? userRole = prefs.getString('userRole');
                if (userRole == 'customer') {
                  CollectionReference userCollection =
                      FirebaseFirestore.instance.collection('user');
                  QuerySnapshot querySnapshot = await userCollection
                      .where('role', isNotEqualTo: 'customer')
                      .where('role', isEqualTo: 'employee')
                      .where('isReady', isEqualTo: false)
                      .get(); //เอาข้อมูล user ที่ role เป็น employee ทั้งหมด
                  DocumentReference nameSnapshot = FirebaseFirestore.instance
                      .collection('user')
                      .doc(
                          user_id); //เอาข้อมูลfield:name ของ user ที่ login อยู่
                  String? name = await nameSnapshot
                      .get()
                      .then((snapshot) => snapshot['name']);

                  querySnapshot.docs
                      .forEach((DocumentSnapshot documentSnapshot) {
                    userCollection.doc(documentSnapshot.id).update(
                      {
                        'isReady': true,
                        'call_number': name,
                      },
                    );
                  });
                }
              },
            ),
          ListTile(
            leading: const Icon(Icons.check_box),
            title: const Text('ออกจากระบบ'),
            onTap: () async {
              FirebaseAuth.instance.signOut();
              await _prefs.remove('userRole');
              Navigator.pushNamed(context, "/login");
            },
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
