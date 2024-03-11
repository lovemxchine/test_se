import 'package:flutter/material.dart';
import 'button_promotion.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';

class PromotionCard extends StatefulWidget {
  const PromotionCard({super.key, required this.availablePromotion});
  final List<DocumentSnapshot> availablePromotion;
  @override
  State<PromotionCard> createState() => _PromotionCardState();
}

class _PromotionCardState extends State<PromotionCard> {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      childAspectRatio: 0.68,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      shrinkWrap: true,
      children: [
        for (var doc in widget.availablePromotion)
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
                    height: MediaQuery.of(context).size.width * 0.35,
                    width: MediaQuery.of(context).size.width * 0.4,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(doc['urlp']),
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
                    doc['namep'],
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.black,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
                 Container(
                  alignment: Alignment.center,
                  child: Text(
                    'รายละเอียด : ${doc['detail']}',
                    style: GoogleFonts.mitr(
                        textStyle: const TextStyle(
                            fontSize: 12, color: Color.fromARGB(255, 0, 0, 0))),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    'ราคา : ${doc['pricep']}',
                    style: GoogleFonts.mitr(
                        textStyle: const TextStyle(
                            fontSize: 12, color: Color.fromARGB(255, 0, 0, 0))),
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          )
      ],
    );
  }
}
