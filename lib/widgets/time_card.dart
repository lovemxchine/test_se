import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:test_se/screens/main_screen/edit_menu_screen.dart';

class TimeCard extends StatefulWidget {
  final List<DocumentSnapshot> availableStocks;

  const TimeCard({Key? key, required this.availableStocks}) : super(key: key);

  @override
  State<TimeCard> createState() => _TimeCardState();
}

class _TimeCardState extends State<TimeCard> {
  @override
  void initState() {
    super.initState();
    print(widget.availableStocks);
  }

  @override
  Widget build(BuildContext context) {
    String now = Timestamp.now().toString();
    String time_Now = DateTime.now().day.toString() +
        '-' +
        DateTime.now().month.toString().padLeft(2, '0') +
        '-' +
        DateTime.now().year.toString().padLeft(2, '0');
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.width * 0.03,
        ),
        //  Text(
        // 'เช็คเวลาเข้างานวันนี้\nเวลาเข้างาน = 10:00 น.',textAlign: TextAlign.center,)
        Text(
          'เวลาวันนี้: ' + time_Now + '\nเวลาเข้างาน = 10:00 น.',
          style: GoogleFonts.poppins(
            textStyle: Theme.of(context).textTheme.titleLarge,
            fontSize: 20,
            fontWeight: FontWeight.w400,
            color: const Color.fromARGB(255, 0, 0, 0),
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: MediaQuery.of(context).size.width * 0.015,
        ),
        ElevatedButton(
          onPressed: () async {
            List<Future<QuerySnapshot>> futures = [];
            for (var doc in widget.availableStocks) {
              futures.add(
                FirebaseFirestore.instance
                    .collection('user')
                    .doc(doc['uid'])
                    .collection('check_in')
                    .where('time',
                        isGreaterThan:
                            DateTime.now().subtract(Duration(days: 1)))
                    .where('time',
                        isLessThan: DateTime.now().add(Duration(days: 1)))
                    .orderBy('time', descending: true)
                    .get(),
              );
            }

            List<QuerySnapshot> snapshots = await Future.wait(futures);
            // ignore: use_build_context_synchronously
            showDialog(
              context: context,
              builder: (context) {
                return Dialog(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.7,
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.all(
                            MediaQuery.of(context).size.width * 0.03),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  icon: Icon(Icons.close),
                                ),
                              ],
                            ),
                            ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: snapshots.length,
                              itemBuilder: (context, i) {
                                var snapshot = snapshots[i];
                                return Column(
                                  children: [
                                    for (var checkInDoc in snapshot.docs)
                                      StreamBuilder(
                                        stream: FirebaseFirestore.instance
                                            .collection('user')
                                            .doc(checkInDoc['uid'])
                                            .snapshots(),
                                        builder: (context, userSnapshot) {
                                          if (!userSnapshot.hasData) {
                                            return CircularProgressIndicator();
                                          }

                                          var userData = userSnapshot.data!;
                                          return RichText(
                                            text: TextSpan(
                                              children: [
                                                TextSpan(
                                                  text:
                                                      "ชื่อ: ${userData['name']}",
                                                  style: GoogleFonts.mitr(
                                                    textStyle: const TextStyle(
                                                      color: Color(0xff3C696F),
                                                      fontSize: 17,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                ),
                                                TextSpan(
                                                  text: "\nเวลาเข้างาน: ",
                                                  style: GoogleFonts.mitr(
                                                    textStyle: const TextStyle(
                                                      color: Color.fromARGB(
                                                          255, 0, 0, 0),
                                                      fontSize: 17,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                ),
                                                TextSpan(
                                                  text: checkInDoc['time']
                                                              .toDate()
                                                              .hour >
                                                          10
                                                      ? 'เข้างานสาย'
                                                      : 'เข้างานตรงเวลา',
                                                  style: GoogleFonts.mitr(
                                                    textStyle: checkInDoc[
                                                                    'time']
                                                                .toDate()
                                                                .hour >
                                                            10
                                                        ? const TextStyle(
                                                            color: Colors.red,
                                                            fontSize: 17,
                                                            fontWeight:
                                                                FontWeight.w400)
                                                        : const TextStyle(
                                                            color: Colors.green,
                                                            fontSize: 17,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
                                                  ),
                                                ),
                                                TextSpan(
                                                  text:
                                                      "\n${timeStampFormat(checkInDoc['time'])}",
                                                  style: GoogleFonts.mitr(
                                                    textStyle: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 17,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      )
                                  ],
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          },
          style: ButtonStyle(
            elevation: MaterialStateProperty.all<double>(5),
            shadowColor: MaterialStateProperty.all<Color>(Colors.grey),
            padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
              const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            ),
            backgroundColor: MaterialStateProperty.all<Color>(
                Color.fromARGB(255, 122, 174, 163)),
            foregroundColor: MaterialStateProperty.all<Color>(
                Color.fromRGBO(255, 255, 255, 1)),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
            ),
          ),
          child: Text('เช็คเวลาคนเข้างานวันนี้'),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.width * 0.03,
        ),
        for (var doc in widget.availableStocks)
          FutureBuilder<QuerySnapshot>(
            future: FirebaseFirestore.instance
                .collection('user')
                .doc(doc['uid'])
                .collection('check_in')
                .orderBy('time', descending: true)
                .get(),
            builder: (context, snapshot) {
              if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
                List<DocumentSnapshot> checkInDocs = snapshot.data!.docs;
                List<DocumentSnapshot> todayCheckIns = checkInDocs
                    .where((checkIn) =>
                        isSameDay(checkIn['time'].toDate(), DateTime.now()))
                    .toList();
                return Column(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.width * 0.32,
                      width: MediaQuery.of(context).size.width * 0.95,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3),
                            // changes position of shadow
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(
                            MediaQuery.of(context).size.width * 0.04),
                        child: Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Spacer(),
                                Text(
                                  'ชื่อ : ${doc['name']}',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w300,
                                  ),
                                  textAlign: TextAlign.start,
                                ),
                                Text(
                                  'เบอร์ติดต่อ : ${formatPhoneNumber(doc['tel'])}',
                                  style: GoogleFonts.mitr(
                                    textStyle: const TextStyle(
                                        color: Color.fromARGB(255, 0, 0, 0),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                                Text(
                                  'email : ${doc['email']}',
                                  style: GoogleFonts.mitr(
                                    textStyle: const TextStyle(
                                        color: Color.fromARGB(255, 0, 0, 0),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                                Text(
                                  'ตำแหน่ง : ${doc['role']}',
                                  style: GoogleFonts.mitr(
                                    textStyle: const TextStyle(
                                        color: Color.fromARGB(255, 0, 0, 0),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                                Spacer(),
                              ],
                            ),
                            Spacer(),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                // Spacer(),
                                // ElevatedButton(
                                //   onPressed: () async {
                                //     showDialog(
                                //       context: context,
                                //       builder: (context) {
                                //         return Dialog(
                                //             child: SizedBox(
                                //           width:
                                //               MediaQuery.of(context).size.width,
                                //           height: MediaQuery.of(context)
                                //                   .size
                                //                   .height *
                                //               0.7,
                                //           child: SingleChildScrollView(
                                //             child: Padding(
                                //               padding: EdgeInsets.all(
                                //                   MediaQuery.of(context)
                                //                           .size
                                //                           .width *
                                //                       0.03),
                                //               child: Column(
                                //                 children: [
                                //                   Row(
                                //                     children: [
                                //                       IconButton(
                                //                           onPressed: () {
                                //                             Navigator.pop(
                                //                                 context);
                                //                           },
                                //                           icon:
                                //                               Icon(Icons.close))
                                //                     ],
                                //                   ),
                                //                   ListView.builder(
                                //                     physics:
                                //                         NeverScrollableScrollPhysics(),
                                //                     shrinkWrap: true,
                                //                     itemCount:
                                //                         todayCheckIns.length,
                                //                     itemBuilder:
                                //                         (context, index) {
                                //                       DocumentSnapshot
                                //                           checkInDoc =
                                //                           todayCheckIns[index];
                                //                       String formattedTime =
                                //                           getOnlyHrAndMin(
                                //                               checkInDoc[
                                //                                   'time']);
                                //                       bool checkTime =
                                //                           formattedTime
                                //                                   .compareTo(
                                //                                       '10:00') >
                                //                               0;
                                //                       String checkTimeStr =
                                //                           checkTime
                                //                               ? 'เข้างานสาย'
                                //                               : 'เข้างานตรงเวลา';
                                //                       return Column(
                                //                         crossAxisAlignment:
                                //                             CrossAxisAlignment
                                //                                 .start,
                                //                         children: [
                                //                           Center(
                                //                             child: RichText(
                                //                               text: TextSpan(
                                //                                 children: [
                                //                                   TextSpan(
                                //                                     text:
                                //                                         "เวลาเข้างาน: ",
                                //                                     style:
                                //                                         GoogleFonts
                                //                                             .mitr(
                                //                                       textStyle:
                                //                                           const TextStyle(
                                //                                         color: Color(
                                //                                             0xff3C696F),
                                //                                         fontSize:
                                //                                             17,
                                //                                         fontWeight:
                                //                                             FontWeight.w400,
                                //                                       ),
                                //                                     ),
                                //                                   ),
                                //                                   TextSpan(
                                //                                     text:
                                //                                         '${checkTimeStr}',
                                //                                     style:
                                //                                         GoogleFonts
                                //                                             .mitr(
                                //                                       textStyle: checkTime
                                //                                           ? const TextStyle(
                                //                                               color: Colors
                                //                                                   .red,
                                //                                               fontSize:
                                //                                                   17,
                                //                                               fontWeight: FontWeight
                                //                                                   .w400)
                                //                                           : const TextStyle(
                                //                                               color: Colors.green,
                                //                                               fontSize: 17,
                                //                                               fontWeight: FontWeight.w400),
                                //                                     ),
                                //                                   ),
                                //                                   TextSpan(
                                //                                     text:
                                //                                         "\n${timeStampFormat(checkInDoc['time'])}",
                                //                                     style:
                                //                                         GoogleFonts
                                //                                             .mitr(
                                //                                       textStyle: TextStyle(
                                //                                           color: Colors
                                //                                               .black,
                                //                                           fontSize:
                                //                                               17,
                                //                                           fontWeight:
                                //                                               FontWeight.w400),
                                //                                     ),
                                //                                   ),
                                //                                 ],
                                //                               ),
                                //                             ),
                                //                           ),
                                //                           SizedBox(
                                //                             height: MediaQuery.of(
                                //                                         context)
                                //                                     .size
                                //                                     .width *
                                //                                 0.03,
                                //                           ),
                                //                         ],
                                //                       );
                                //                     },
                                //                   ),
                                //                 ],
                                //               ),
                                //             ),
                                //           ),
                                //         ));
                                //       },
                                //     );
                                //   },
                                //   style: ButtonStyle(
                                //     elevation:
                                //         MaterialStateProperty.all<double>(3),
                                //     shadowColor:
                                //         MaterialStateProperty.all<Color>(
                                //             Colors.grey),
                                //     padding: MaterialStateProperty.all<
                                //         EdgeInsetsGeometry>(
                                //       EdgeInsets.symmetric(
                                //           vertical: 10, horizontal: 10),
                                //     ),
                                //     foregroundColor:
                                //         MaterialStateProperty.all<Color>(
                                //             Color.fromARGB(255, 74, 74, 74)),
                                //     shape: MaterialStateProperty.all<
                                //         RoundedRectangleBorder>(
                                //       RoundedRectangleBorder(
                                //         borderRadius:
                                //             BorderRadius.circular(5.0),
                                //       ),
                                //     ),
                                //   ),
                                //   child: const Text('เช็คเวลาเข้างานวันนี้'),
                                // ),
                                Spacer(),
                                ElevatedButton(
                                  onPressed: () async {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return Dialog(
                                          child: SizedBox(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.7,
                                            child: SingleChildScrollView(
                                              child: Padding(
                                                padding: EdgeInsets.all(
                                                    MediaQuery.of(context)
                                                            .size
                                                            .width *
                                                        0.03),
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      children: [
                                                        IconButton(
                                                            onPressed: () {
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            icon: Icon(
                                                                Icons.close))
                                                      ],
                                                    ),
                                                    ListView.builder(
                                                      physics:
                                                          NeverScrollableScrollPhysics(),
                                                      shrinkWrap: true,
                                                      itemCount:
                                                          checkInDocs.length,
                                                      itemBuilder:
                                                          (context, index) {
                                                        DocumentSnapshot
                                                            checkInDoc =
                                                            checkInDocs[index];
                                                        String formattedTime =
                                                            getOnlyHrAndMin(
                                                                checkInDoc[
                                                                    'time']);
                                                        bool checkTime =
                                                            formattedTime
                                                                    .compareTo(
                                                                        '10:00') >
                                                                0;
                                                        String checkTimeStr =
                                                            checkTime
                                                                ? 'เข้างานสาย'
                                                                : 'เข้างานตรงเวลา';
                                                        return Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Center(
                                                              child: RichText(
                                                                text: TextSpan(
                                                                  children: [
                                                                    TextSpan(
                                                                      text:
                                                                          "เวลาเข้างาน: ",
                                                                      style: GoogleFonts
                                                                          .mitr(
                                                                        textStyle:
                                                                            TextStyle(
                                                                          color:
                                                                              Color(0xff3C696F),
                                                                          fontSize:
                                                                              17,
                                                                          fontWeight:
                                                                              FontWeight.w400,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    TextSpan(
                                                                      text:
                                                                          '${checkTimeStr}',
                                                                      style: GoogleFonts
                                                                          .mitr(
                                                                        textStyle: checkTime
                                                                            ? TextStyle(
                                                                                color: Colors.red,
                                                                                fontSize: 17,
                                                                                fontWeight: FontWeight.w400)
                                                                            : TextStyle(color: Colors.green, fontSize: 17, fontWeight: FontWeight.w400),
                                                                      ),
                                                                    ),
                                                                    TextSpan(
                                                                      text:
                                                                          "\n${timeStampFormat(checkInDoc['time'])}",
                                                                      style: GoogleFonts
                                                                          .mitr(
                                                                        textStyle: TextStyle(
                                                                            color: Colors
                                                                                .black,
                                                                            fontSize:
                                                                                17,
                                                                            fontWeight:
                                                                                FontWeight.w400),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  0.03,
                                                            ),
                                                          ],
                                                        );
                                                      },
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  style: ButtonStyle(
                                    elevation:
                                        MaterialStateProperty.all<double>(3),
                                    shadowColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.grey),
                                    padding: MaterialStateProperty.all<
                                        EdgeInsetsGeometry>(
                                      EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 10),
                                    ),
                                    foregroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Color.fromARGB(255, 74, 74, 74)),
                                    shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                      ),
                                    ),
                                  ),
                                  child: const Text('เช็คประวัติ'),
                                ),
                                Spacer(),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.width * 0.03,
                    )
                  ],
                );
              } else {
                return SizedBox.shrink();
              }
            },
          ),
      ],
    );
  }

  String formatPhoneNumber(String phoneNumber) {
    final cleaned = phoneNumber.replaceAll(RegExp(r'[^\d]+'), '');
    if (cleaned.length >= 10) {
      return '${cleaned.substring(0, 3)}-${cleaned.substring(3, 6)}-${cleaned.substring(6)}';
    } else {
      return cleaned;
    }
  }

  timeStampFormat(Timestamp getTime) {
    DateTime dateTime = getTime.toDate();

    String formattedDateTime =
        DateFormat('วันที่: dd-MM-yyyy เวลา: HH:mm:ss ').format(dateTime);
    return formattedDateTime;
  }

  getOnlyHrAndMin(Timestamp getTime) {
    DateTime dateTime = getTime.toDate();

    String formattedDateTime = DateFormat('HH:mm:ss').format(dateTime);
    return formattedDateTime;
  }

  getOnlyDayMthYr(Timestamp getTime) {
    DateTime dateTime = getTime.toDate();

    String formattedDateTime = DateFormat('dd-MM-yyyy').format(dateTime);
    return formattedDateTime;
  }

  static bool isSameDay(DateTime? dateA, DateTime? dateB) {
    return dateA?.year == dateB?.year &&
        dateA?.month == dateB?.month &&
        dateA?.day == dateB?.day;
  }
}
