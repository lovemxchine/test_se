import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test_se/components/my_button.dart';

import 'testAll_screen.dart';

class OrderList extends StatefulWidget {
  const OrderList({super.key});

  @override
  State<OrderList> createState() => _OrderListState();
}

List<String> items = [
  "เนื้อสัตว์1",
  "ผัก1",
  "อื่นๆ1",
];
int current = 0;

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        toolbarHeight: 90,
        leading: IconButton(
          padding: EdgeInsets.only(left: 10),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => TestPage()),
            );
          },
          icon: const Icon(
            Icons.menu,
            size: 30,
            color: Colors.white,
          ),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xff396870),
                Color(0xff17333C)
              ], // Adjust colors as needed
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
      body: const Padding(
        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
        child: Column(
          children: [
            Row(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MyButton(onTap: ClearOrder, hinText: 'Clear'),
                SizedBox(
                  width: 0,
                ),
                MyButton(onTap: ConfirmOrder, hinText: 'Confirm'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
