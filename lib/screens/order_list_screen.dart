import 'package:flutter/material.dart';
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
                  return ListTile(
                    title: Text(product.name),
                    subtitle: Text('Price: ${product.price}'),
                    trailing: Text('Quantity: ${product.quantity}'),
                    onTap: () {
                      cartProvider.removeFromCart(product);
                    },
                  );
                },
              );
            }
          },
        ),
      ),
      bottomNavigationBar: Consumer<CartProvider>(
        builder: (context, cartProvider, _) {
          // แสดงราคารวมของสินค้าในตะกร้า
          double totalPrice = cartProvider.getTotalPrice();
          return BottomAppBar(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Total Price: $totalPrice',
                style: TextStyle(fontSize: 20.0),
              ),
            ),
          );
        },
      ),
    );
  }
}
