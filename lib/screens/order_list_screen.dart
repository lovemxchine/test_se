import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
            // ดึงรายการสินค้าในตะกร้า
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
                  // ListTile(
                  //   title: Text(product.name),
                  //   subtitle: Text('Price: ${product.price}'),
                  //   trailing: Text('Quantity: ${product.quantity}'),
                  //   onTap: () {
                  //     cartProvider.removeFromCart(product);
                  //   },
                  // );
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
                    style: TextStyle(fontSize: 20.0),
                  ),
                  Spacer(),
                  Container(
                    height: MediaQuery.of(context).size.width * 0.09,
                    width: MediaQuery.of(context).size.width * 0.25,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 33, 128, 223),
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
                        'คอร์นเฟิร์ม',
                        style: GoogleFonts.poppins(
                          textStyle: Theme.of(context).textTheme.titleLarge,
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Spacer(),
                  Row(
                    children: [
                      IconButton(
                        tooltip: 'ok',
                        color: Colors.green,
                        iconSize: 20,
                        onPressed: () {
                          cartProvider.clearCart();
                        },
                        icon: Icon(
                          IconData(0xe59c, fontFamily: 'MaterialIcons'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
