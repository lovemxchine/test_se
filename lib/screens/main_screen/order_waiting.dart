import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:test_se/model/product.dart';
import 'package:test_se/provider/provider.dart';
import '../../widgets/drawer_list.dart';

class OrderWaiting extends StatefulWidget {
  const OrderWaiting({Key? key}) : super(key: key);

  @override
  State<OrderWaiting> createState() => _OrderWaitingState();
}

class _OrderWaitingState extends State<OrderWaiting> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  bool isSnackBarVisible = false;
  bool stockAlready = false;

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    String user_id = user!.uid;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xff17333C),
      key: scaffoldKey,
      drawer: const DrawerList(),
      appBar: AppBar(
        toolbarHeight: 90,
        leading: IconButton(
          padding: const EdgeInsets.only(left: 10),
          onPressed: () {
            scaffoldKey.currentState?.openDrawer();
          },
          icon: const Icon(
            Icons.notifications_active,
            size: 30,
            color: Colors.white,
          ),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xff396870), Color(0xff17333C)],
              stops: [0, 1],
              begin: AlignmentDirectional(0, -0.8),
              end: AlignmentDirectional(0, 1.5),
              tileMode: TileMode.clamp,
            ),
          ),
        ),
        title: const Text(
          "OrderList",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('waiting').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<DocumentSnapshot> documents = snapshot.data!.docs;
            return Container(
                decoration: const BoxDecoration(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(20)),
                    color: Color.fromARGB(255, 240, 240, 240)),
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('waiting')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<DocumentSnapshot> documents = snapshot.data!.docs;
                      return ListView.builder(
                        itemCount: documents.length,
                        itemBuilder: (context, index) {
                          var doc = documents[index];
                          var uid = doc.id;

                          return FutureBuilder<Map<String, dynamic>>(
                            future: dataWaiting(uid),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return CircularProgressIndicator();
                              } else if (snapshot.hasError) {
                                return Text('Error: ${snapshot.error}');
                              } else {
                                Map<String, dynamic>? data = snapshot.data;
                                if (data != null && doc['status'] == false) {
                                  var selectedData = {...data};
                                  return ListTile(
                                    title: Container(
                                      padding: const EdgeInsets.all(15),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all(
                                            width: 1,
                                            color: Colors.grey.shade500),
                                      ),
                                      child: Column(
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: selectedData.entries
                                                .map((entry) {
                                              return Padding(
                                                padding:
                                                    const EdgeInsets.all(6.0),
                                                child: Text(
                                                    '${entry.key}: ${entry.value}'),
                                              );
                                            }).toList(),
                                          ),
                                          SizedBox(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.025),
                                          Row(
                                            children: [
                                              Spacer(),
                                              ElevatedButton(
                                                onPressed: () async {
                                                  updateWaiting(uid, true);
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            25),
                                                  ),
                                                  backgroundColor:
                                                      Color.fromARGB(
                                                          255, 74, 172, 253),
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      vertical: 10,
                                                      horizontal: 20),
                                                ),
                                                child: const Text(
                                                  'Confirm',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 16,
                                                  ),
                                                ),
                                              ),
                                              Spacer(),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                } else {
                                  return SizedBox();
                                }
                              }
                            },
                          );
                        },
                      );
                    } else {
                      return CircularProgressIndicator();
                    }
                  },
                ));
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }

  Future updateWaiting(
    String uid,
    bool status,
  ) async {
    await FirebaseFirestore.instance.collection('waiting').doc(uid).delete();
    await FirebaseFirestore.instance
        .collection('waiting')
        .doc(uid)
        .set({'status': status, 'uid': uid});

    CollectionReference userCollection =
        FirebaseFirestore.instance.collection('user');
    QuerySnapshot querySnapshot = await userCollection
        .where('role', isEqualTo: 'employee')
        .where('isReady', isEqualTo: false)
        .where('call_number', isEqualTo: '')
        .get(); //เอาข้อมูล user ที่ role เป็น employee ทั้งหมด
    DocumentReference nameSnapshot = FirebaseFirestore.instance
        .collection('user')
        .doc(uid); //เอาข้อมูลfield:name ของ user ที่ login อยู่
    String? name =
        await nameSnapshot.get().then((snapshot) => snapshot['name']);

    querySnapshot.docs.forEach(
      (DocumentSnapshot documentSnapshot) {
        userCollection.doc(documentSnapshot.id).update(
          {
            'isReady': true,
            'employee_name': name,
          },
        );
      },
    );
  }

  Future<Map<String, dynamic>> dataWaiting(String uid) async {
    var doc =
        await FirebaseFirestore.instance.collection('waiting').doc(uid).get();
    Map<String, dynamic> data = (await doc.data())!;
    Map<String, dynamic> selectedData = {...data};

    selectedData.remove('init_time');
    selectedData.remove('status');

    return selectedData;
  }
}
