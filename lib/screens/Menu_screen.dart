import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:test_se/model/product.dart';
import 'package:test_se/provider/provider.dart';
import '../widgets/drawer_list.dart';

class Menu extends StatefulWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  bool isSnackBarVisible = false;
  bool stockAlready = false;
  @override
  void initState() {
    super.initState();
    Provider.of<CartProvider>(context, listen: false).fetchCartFromSharedPref();
    Provider.of<ConfirmCart>(context, listen: false)
        .fetchConfirmCartFromSharedPref();
  }

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
        stream: FirebaseFirestore.instance.collection('stock').snapshots(),
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
                      childAspectRatio: 0.68,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 2,
                      shrinkWrap: true,
                      children: [
                        for (var doc in documents)
                          Container(
                            padding: const EdgeInsets.only(
                                left: 15, right: 15, top: 10),
                            margin: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                  width: 1, color: Colors.grey.shade500),
                            ),
                            child: Column(
                              children: [
                                InkWell(
                                  child: Container(
                                    height: MediaQuery.of(context).size.width *
                                        0.35,
                                    width:
                                        MediaQuery.of(context).size.width * 0.4,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: NetworkImage(doc['url']),
                                        fit: BoxFit.cover,
                                      ),
                                      border: Border.all(
                                          width: 1,
                                          color: Colors.grey.shade200),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Spacer(),
                                Container(
                                  padding: const EdgeInsets.only(bottom: 8),
                                  alignment: Alignment.center,
                                  child: Text(
                                    // Get the name from Firestore
                                    doc['name'],
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
                                    'ราคา : ${doc['price']}',
                                    style: GoogleFonts.mitr(
                                        textStyle: const TextStyle(
                                            fontSize: 12,
                                            color:
                                                Color.fromARGB(255, 0, 0, 0))),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Consumer<CartProvider>(
                                  builder: (context, cartProvider, _) {
                                    List<Product> cartItems =
                                        cartProvider.items;

                                    int totalQuantity = cartProvider.items
                                        .where(
                                            (item) => item.id == doc['docId'])
                                        .fold<int>(
                                            0,
                                            (previousValue, item) =>
                                                previousValue + item.quantity);

                                    bool isQuantityAvailable =
                                        totalQuantity < doc['quantity'];

                                    return ElevatedButton(
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                isQuantityAvailable
                                                    ? Color.fromARGB(
                                                        255, 90, 140, 149)
                                                    : Colors.grey),
                                      ),
                                      onPressed: () async {
                                        if (isQuantityAvailable) {
                                          Product product = Product(
                                            id: doc['docId'],
                                            name: doc['name'],
                                            price: doc['price'],
                                            quantity: 1,
                                          );

                                          Provider.of<CartProvider>(context,
                                                  listen: false)
                                              .addToCart(product);
                                        } else {
                                          if (!isSnackBarVisible) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                content: Text(
                                                    'จำนวนสินค้าที่มีในสต็อกไม่เพียงพอ'),
                                                duration: Duration(seconds: 2),
                                              ),
                                            );
                                            isSnackBarVisible = true;

                                            Timer(Duration(seconds: 2), () {
                                              isSnackBarVisible = false;
                                            });
                                          }
                                        }
                                      },
                                      // : () {
                                      //     print('not enough quantity');
                                      //   },
                                      child: isQuantityAvailable
                                          ? Text(
                                              'เพิ่มลงตะกร้า',
                                              style: GoogleFonts.mitr(
                                                textStyle: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.w400),
                                              ),
                                            )
                                          : Text(
                                              'สินค้าหมด',
                                              style: GoogleFonts.mitr(
                                                textStyle: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.w400),
                                              ),
                                            ),
                                    );
                                  },
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
}
