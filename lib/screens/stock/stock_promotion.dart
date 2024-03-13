import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:test_se/screens/stock/stock_promotion_detail.dart';

class StockPromotion extends StatefulWidget {
  const StockPromotion({super.key});

  @override
  State<StockPromotion> createState() => _StockPromotionState();
}

class _StockPromotionState extends State<StockPromotion> {
   final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xff17333C),
      key: scaffoldKey,
      appBar: AppBar(
        toolbarHeight: 90,
        leading: IconButton(
          padding: const EdgeInsets.only(left: 10),
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
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
          "Stock Promotion",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          color: Color.fromARGB(255, 240, 240, 240),
        ),
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 1,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('promotion')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<DocumentSnapshot> documents = snapshot.data!.docs;

                    return ListView(
                      children: [
                        Container(
                            child:
                                StockPromotionDetail(availablePromotion: documents)),
                      ],
                    );
                  } else {
                    return const CircularProgressIndicator();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}