import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:test_se/components/my_button.dart';
import 'package:test_se/model/product.dart';
import 'package:test_se/provider/provider.dart';

import '../widgets/drawer_list.dart';

class OrderList extends StatefulWidget {
  const OrderList({super.key});

  @override
  State<OrderList> createState() => _OrderListState();
}

// ignore: non_constant_identifier_names
ConfirmOrder() {
  // ignore: avoid_print
  print('Confirm');
}

// ignore: non_constant_identifier_names
ClearOrder() {
  // ignore: avoid_print
  print('Delete');
}

class _OrderListState extends State<OrderList> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
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
                                      fontWeight: FontWeight.w400))),
                        ),
                        Spacer(),
                        Container(
                            width: MediaQuery.of(context).size.width * 0.3,
                            child: Row(
                              children: [
                                IconButton(
                                    onPressed: () {
                                      cartProvider.removeFromCart(product);
                                    },
                                    icon: const Icon(Icons.remove)),
                                Text('${product.quantity}',
                                    style: GoogleFonts.mitr(
                                        textStyle: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400))),
                                IconButton(
                                    onPressed: () {
                                      Provider.of<CartProvider>(context,
                                              listen: false)
                                          .addToCart(product);
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
                      onPressed: () {
                        Provider.of<ConfirmCart>(context, listen: false)
                            .confirmOrder(context);
                        cartProvider.clearCart();
                      },
                      child: const Text('คอร์นเฟิร์ม')),
                  const Spacer(),
                  ElevatedButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return Dialog(
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.8,
                                height:
                                    MediaQuery.of(context).size.height * 0.6,
                                child: Column(
                                  children: [
                                    Expanded(
                                      child: Consumer<ConfirmCart>(
                                        builder: (context, cartProvider, _) {
                                          List<Product> cartItems =
                                              cartProvider.items;

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
                                                      0.3,
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
                                                            0.3,
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
                                                            0.3,
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
                                                      Text(
                                                        'จำนวณ: ${product.quantity}',
                                                        style: GoogleFonts.mitr(
                                                          textStyle:
                                                              const TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize: 10,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400),
                                                        ),
                                                      ),
                                                      // Container(
                                                      //   child: Text(
                                                      //     '${product.name} / ราคา: ${product.price} บาท /  จำนวณ: ${product.quantity}',
                                                      //     style:
                                                      //         GoogleFonts.mitr(
                                                      //       textStyle:
                                                      //           const TextStyle(
                                                      //               color: Colors
                                                      //                   .black,
                                                      //               fontSize:
                                                      //                   10,
                                                      //               fontWeight:
                                                      //                   FontWeight
                                                      //                       .w400),
                                                      //     ),
                                                      //   ),
                                                      // ),
                                                    ],
                                                  ),
                                                );
                                              },
                                            );
                                          }
                                        },
                                      ),
                                    ),
                                    Spacer(),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Consumer<ConfirmCart>(
                                          builder: (context, cartProvider, _) {
                                            final formatCurrency =
                                                NumberFormat.currency(
                                                    locale: 'en_US',
                                                    symbol: '');
                                            int totalPrice =
                                                cartProvider.getTotalPrice();
                                            return Text(
                                                "ราคาทั้งหมด: ${formatCurrency.format(totalPrice)} บาท");
                                          },
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                      child: Text('เช็คบิล')),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
