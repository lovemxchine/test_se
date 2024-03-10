import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';

class WaitCard extends StatefulWidget {
  final List<DocumentSnapshot> availableStocks;

  const WaitCard({Key? key, required this.availableStocks}) : super(key: key);

  @override
  State<WaitCard> createState() => _WaitCardState();
}

class _WaitCardState extends State<WaitCard> {
  @override

  Widget build(BuildContext context) {
    return GridView.count(
      childAspectRatio: 0.68,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      shrinkWrap: true,
      children: [
        for (var doc in widget.availableStocks)
          Container(
            padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(width: 1, color: Colors.grey.shade500),
            ),
            child: Column(
              children: [
                InkWell(
                  child: Container(
                    height: 150,
                    width: 150,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        // Get the image URL from Firestore
                        image: NetworkImage(doc['url']),
                        fit: BoxFit.cover,
                      ),
                      border: Border.all(width: 1, color: Colors.grey.shade200),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                Container(
                  padding: const EdgeInsets.only(bottom: 8),
                  alignment: Alignment.center,
                  child: Text(
                    // Get the name from Firestore
                    doc['name'],
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "สถานะ :",
                          style: GoogleFonts.mitr(
                            textStyle: const TextStyle(
                                color: Color(0xff3C696F),
                                fontSize: 14,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                        const TextSpan(text: "  "),
                        TextSpan(
                          // Check if quantity > 0
                          text: doc['quantity'] > 0 ? 'พร้อม' : 'ไม่พร้อม',
                          style: GoogleFonts.mitr(
                              textStyle: TextStyle(
                            fontSize: 14,
                            color:
                                doc['quantity'] > 0 ? Colors.green : Colors.red,
                            fontWeight: FontWeight.w400,
                          )),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  height: 30,
                  width: 120,
                  padding: const EdgeInsets.all(5.0),
                  margin: const EdgeInsets.symmetric(horizontal: 25.0),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 66, 104, 109),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Center(
                    child: Text(
                      'จำนวน : ${doc['quantity']}',
                      style: GoogleFonts.mitr(
                        textStyle: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
      ],
    );
  }
}
