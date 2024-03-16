import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:test_se/widgets/drawer_list.dart';

class CheckBill extends StatefulWidget {
  CheckBill({super.key});

  @override
  State<CheckBill> createState() => _CheckBillState();
}

final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

class _CheckBillState extends State<CheckBill> {
  final formatCurrency = NumberFormat.currency(locale: 'en_US', symbol: '');

  @override
  Widget build(BuildContext context) {
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
          "Menu",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('income').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<DocumentSnapshot> documents = snapshot.data!.docs;

            return Container(
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                  color: Color.fromARGB(255, 240, 240, 240)),
              child: ListView(children: [
                Column(
                  children: [
                    GridView.count(
                      childAspectRatio: 2.0,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 1,
                      shrinkWrap: true,
                      children: [
                        for (var doc in documents)
                          if (!doc['status'])
                            Container(
                              padding: const EdgeInsets.all(10),
                              margin: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                    width: 1, color: Colors.grey.shade500),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Spacer(),
                                  Text(doc['uid'],
                                      style: GoogleFonts.poppins(
                                        textStyle: Theme.of(context)
                                            .textTheme
                                            .titleLarge,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black,
                                      )),
                                  SizedBox(
                                      height:
                                          MediaQuery.of(context).size.width *
                                              0.025),
                                  Text(
                                    timeStampFormat(doc['time']),
                                    style: GoogleFonts.poppins(
                                      textStyle: Theme.of(context)
                                          .textTheme
                                          .titleLarge,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black,
                                    ),
                                  ),
                                  SizedBox(
                                      height:
                                          MediaQuery.of(context).size.width *
                                              0.025),
                                  Text(
                                    '${formatCurrency.format(doc['receipt'])} บาท',
                                    style: GoogleFonts.poppins(
                                      textStyle: Theme.of(context)
                                          .textTheme
                                          .titleLarge,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black,
                                    ),
                                  ),
                                  SizedBox(
                                      height:
                                          MediaQuery.of(context).size.width *
                                              0.025),
                                  ElevatedButton(
                                    onPressed: () async {
                                      // completePaid(doc['id']);
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return Dialog(
                                            child: SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  1.2,
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.2,
                                              child: Center(
                                                child: Column(
                                                  children: [
                                                    Spacer(),
                                                    Text(
                                                      'ต้องการยืนยัน ใช่ หรือ ไม่',
                                                      style:
                                                          GoogleFonts.poppins(
                                                        textStyle:
                                                            Theme.of(context)
                                                                .textTheme
                                                                .titleLarge,
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                    Spacer(),
                                                    Row(
                                                      children: [
                                                        Spacer(),
                                                        ElevatedButton(
                                                          onPressed: () async {
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          style: ButtonStyle(
                                                            padding:
                                                                MaterialStateProperty
                                                                    .all<
                                                                        EdgeInsetsGeometry>(
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  vertical: 5,
                                                                  horizontal:
                                                                      10),
                                                            ),
                                                            foregroundColor:
                                                                MaterialStateProperty.all<
                                                                        Color>(
                                                                    Color.fromARGB(
                                                                        255,
                                                                        253,
                                                                        74,
                                                                        74)),
                                                            shape: MaterialStateProperty
                                                                .all<
                                                                    RoundedRectangleBorder>(
                                                              RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            18.0),
                                                              ),
                                                            ),
                                                          ),
                                                          child: const Text(
                                                              'ยกเลิก'),
                                                        ),
                                                        Spacer(),
                                                        ElevatedButton(
                                                          onPressed: () async {
                                                            completePaid(
                                                                doc['id']);
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          style: ButtonStyle(
                                                            padding:
                                                                MaterialStateProperty
                                                                    .all<
                                                                        EdgeInsetsGeometry>(
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  vertical: 5,
                                                                  horizontal:
                                                                      10),
                                                            ),
                                                            foregroundColor:
                                                                MaterialStateProperty.all<
                                                                        Color>(
                                                                    Color.fromARGB(
                                                                        255,
                                                                        74,
                                                                        172,
                                                                        253)),
                                                            shape: MaterialStateProperty
                                                                .all<
                                                                    RoundedRectangleBorder>(
                                                              RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            18.0),
                                                              ),
                                                            ),
                                                          ),
                                                          child: const Text(
                                                              'ยืนยัน'),
                                                        ),
                                                        Spacer()
                                                      ],
                                                    ),
                                                    Spacer(),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(25),
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 20),
                                      primary:
                                          Color.fromARGB(255, 74, 172, 253),
                                    ),
                                    child: const Text(
                                      'ยืนยันว่าจ่ายตังเรียนร้อย',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                  Spacer(),
                                ],
                              ),
                            )
                      ],
                    ),
                  ],
                ),
              ]),
            );
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }

  Future<bool> isQuantityAvailableInDB(String productId, int quantity) async {
    DocumentSnapshot productSnapshot = await FirebaseFirestore.instance
        .collection('stock')
        .doc(productId)
        .get();

    int dbQuantity = productSnapshot['quantity'];

    return quantity <= dbQuantity;
  }

  timeStampFormat(Timestamp getTime) {
    DateTime dateTime = getTime.toDate();

    String formattedDateTime =
        DateFormat('yyyy-MM-dd HH:mm:ss').format(dateTime);
    return formattedDateTime;
  }

  completePaid(String docId) async {
    await FirebaseFirestore.instance
        .collection('income')
        .doc(docId)
        .update({'status': true});
  }
}
