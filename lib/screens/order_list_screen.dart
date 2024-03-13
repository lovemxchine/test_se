import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:test_se/model/product.dart';
import 'package:test_se/provider/provider.dart';

import '../widgets/drawer_list.dart';

class OrderList extends StatefulWidget {
  const OrderList({super.key});

  @override
  State<OrderList> createState() => _OrderListState();
}

class _OrderListState extends State<OrderList> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    bool isPressed = false;
    bool isSnackBarVisible = false;
    String uid = getCurrentUID();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xff17333C),
      key: scaffoldKey,
      drawer: DrawerList(),
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
          "Order",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            color: Color.fromARGB(255, 240, 240, 240)),
        child: Consumer<CartProvider>(
          builder: (context, cartProvider, _) {
            List<Product> cartItems = cartProvider.items;

            if (cartItems.isEmpty) {
              return Center(
                child: Text('No items in the cart.'),
              );
            } else {
              return ListView.builder(
                itemCount: cartItems.length,
                itemBuilder: (context, index) {
                  Product product = cartItems[index];

                  return Container(
                    margin: EdgeInsets.all(
                        MediaQuery.of(context).size.width * 0.025),
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(0)),
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(
                              MediaQuery.of(context).size.width * 0.04),
                          child: Text(
                            '${product.name} ราคา: ${product.price} บาท',
                            style: GoogleFonts.mitr(
                              textStyle: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                        ),
                        Container(
                            width: MediaQuery.of(context).size.width * 0.3,
                            child: Row(
                              children: [
                                IconButton(
                                    onPressed: () {
                                      cartProvider.removeFromCart(product);
                                    },
                                    icon: const Icon(Icons.remove)),
                                Text(
                                  '${product.quantity}',
                                  style: GoogleFonts.mitr(
                                    textStyle: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                                IconButton(
                                    onPressed: () async {
                                      DocumentSnapshot snapshot =
                                          await FirebaseFirestore.instance
                                              .collection('stock')
                                              .doc(product.id)
                                              .get();
                                      int currentQuantity =
                                          snapshot['quantity'];
                                      if (product.quantity < currentQuantity) {
                                        // ignore: use_build_context_synchronously
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
                                    icon: const Icon(Icons.add)),
                              ],
                            )),
                      ],
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
      bottomNavigationBar: Consumer<CartProvider>(
        builder: (context, cartProvider, _) {
          int totalPrice = cartProvider.getTotalPrice();

          return BottomAppBar(
            height: 80,
            child: Container(
              padding: EdgeInsets.all(12.0),
              child: Row(
                children: [
                  Text(
                    'ราคารวม: $totalPrice บาท',
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.035),
                  ),
                  Spacer(),
                  ElevatedButton(
                    onPressed: () async {
                      Provider.of<ConfirmCart>(context, listen: false)
                          .confirmOrder(context);
                      for (var item
                          in Provider.of<CartProvider>(context, listen: false)
                              .items) {
                        DocumentSnapshot snapshot = await FirebaseFirestore
                            .instance
                            .collection('stock')
                            .doc(item.id)
                            .get();
                        int currentQuantity = snapshot['quantity'];
                        if (currentQuantity >= item.quantity) {
                          FirebaseFirestore.instance
                              .collection('stock')
                              .doc(item.id)
                              .update({
                            'quantity': FieldValue.increment(-item.quantity),
                          });
                        }
                      }

                      Provider.of<CartProvider>(context, listen: false)
                          .clearCart();
                    },
                    child: const Text('คอร์นเฟิร์ม'),
                  ),
                  const Spacer(),
                  ElevatedButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return Dialog(
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width * 1.5,
                                height:
                                    MediaQuery.of(context).size.height * 0.6,
                                child: Column(
                                  children: [
                                    Expanded(
                                      child: Consumer<ConfirmCart>(
                                        builder: (context, cartConfirm, _) {
                                          List<Product> cartItems =
                                              cartConfirm.items;

                                          if (cartItems.isEmpty) {
                                            return const Center(
                                              child:
                                                  Text('No items in the cart.'),
                                            );
                                          } else {
                                            return ListView.builder(
                                              itemCount: cartItems.length,
                                              itemBuilder: (context, index) {
                                                Product product =
                                                    cartItems[index];

                                                return Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      1,
                                                  margin: EdgeInsets.all(
                                                      MediaQuery.of(context)
                                                              .size
                                                              .width *
                                                          0.04),
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              0)),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    children: [
                                                      Container(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.18,
                                                        child: Text(
                                                          '${product.name}',
                                                          style:
                                                              GoogleFonts.mitr(
                                                            textStyle:
                                                                const TextStyle(
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize:
                                                                        10,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400),
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.18,
                                                        child: Text(
                                                          'ราคา: ${product.price} บาท',
                                                          style:
                                                              GoogleFonts.mitr(
                                                            textStyle:
                                                                const TextStyle(
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize:
                                                                        10,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400),
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.18,
                                                        child: Text(
                                                          'จำนวณ: ${product.quantity}',
                                                          style:
                                                              GoogleFonts.mitr(
                                                            textStyle:
                                                                const TextStyle(
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize:
                                                                        10,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              },
                                            );
                                          }
                                        },
                                      ),
                                    ),
                                    Center(
                                      child: Column(
                                        children: [
                                          Consumer<ConfirmCart>(
                                            builder:
                                                (context, cartProvider, _) {
                                              final formatCurrency =
                                                  NumberFormat.currency(
                                                      locale: 'en_US',
                                                      symbol: '');
                                              int totalPrice =
                                                  cartProvider.getTotalPrice();
                                              return Text(
                                                  "ราคาทั้งหมด: ${formatCurrency.format(totalPrice)} บาท");
                                            },
                                          ),
                                          SizedBox(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.025),
                                          ElevatedButton(
                                            onPressed: () async {
                                              addMenuCollection(
                                                  uid, totalPrice);
                                            },
                                            style: ElevatedButton.styleFrom(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(25),
                                              ),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 10,
                                                      horizontal: 20),
                                              primary: Color.fromARGB(
                                                  255, 83, 178, 255),
                                            ),
                                            child: const Text(
                                              'เช็คบิล',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.025),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                      child: Text('สรุปรายการ')),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Future<void> addMenuCollection(
    String uid,
    int price,
  ) async {
    await FirebaseFirestore.instance.collection('income').add({
      'receipt': price,
      'time': DateTime.now(),
      'uid': getCurrentUID,
    }).then((DocumentReference docRef) {
      String docId = docRef.id;
      print('เพิ่มรายรับไปแล้ว: $docId');

      FirebaseFirestore.instance.collection('income').doc(docId).set({
        'receipt': price,
        'time': DateTime.now(),
        'uid': getCurrentUID,
        'id': docId,
      });
      ;
    }).catchError((error) {
      print('$error');
    });
  }

  String getCurrentUID() {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return user.uid;
    } else {
      return '';
    }
  }
}
