import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:test_se/screens/stock/edit_stock_menu.dart';

class StockMenuDetail extends StatefulWidget {
  final List<DocumentSnapshot> availableMenu;
  const StockMenuDetail({super.key, required this.availableMenu});

  @override
  State<StockMenuDetail> createState() => _StockMenuDetailState();
}

class _StockMenuDetailState extends State<StockMenuDetail> {
  void _navigateToDetailPage(DocumentReference docRef) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditStockMenu(docRef: docRef),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.width * 0.03,
        ),
        for (var doc in widget.availableMenu)
          Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.width * 0.25,
                width: MediaQuery.of(context).size.width * 0.95,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3),
                      // changes position of shadow
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.width * 0.4,
                        width: MediaQuery.of(context).size.width * 0.3,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(doc['url']),
                            fit: BoxFit.cover,
                          ),
                          border:
                              Border.all(width: 1, color: Colors.grey.shade200),
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.3,
                        child: Column(
                          children: [
                            Spacer(),
                            Container(
                              child: Text(
                                // Get the name from Firestore
                                doc['name'],
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                            ),
                            Spacer(),
                            Container(
                              child: Text(
                                // Get the name from Firestore
                                'จำนวน : ${doc['quantity']}',
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                            ),
                            Spacer(),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          DocumentReference docRef = FirebaseFirestore.instance
                              .collection('stock')
                              .doc(doc['docId']);
                          _navigateToDetailPage(docRef);
                        },
                        child: Container(
                          height: MediaQuery.of(context).size.width * 0.09,
                          width: MediaQuery.of(context).size.width * 0.16,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 33, 128, 223),
                            borderRadius: BorderRadius.circular(16.0),
                            boxShadow: const [
                              BoxShadow(
                                blurRadius: 10,
                                color: Color.fromARGB(152, 0, 0, 0),
                                offset: Offset(1, 2),
                              )
                            ],
                          ),
                          child: Center(
                            child: Text(
                              'แก้ไข',
                              style: GoogleFonts.poppins(
                                textStyle:
                                    Theme.of(context).textTheme.titleLarge,
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.03,
              )
            ],
          ),
      ],
    );
  }
}
