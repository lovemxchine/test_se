import 'package:flutter/material.dart';
import 'package:item_count_number_button/item_count_number_button.dart';

import 'testAll_screen.dart';

class StockScreen extends StatefulWidget {
  const StockScreen({super.key});

  @override
  State<StockScreen> createState() => _StockScreenState();
}

class _StockScreenState extends State<StockScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color.fromARGB(255, 255, 255, 255),
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
            // color: Colors.white,
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
      body: ItemCount(
        initialValue: 0,
        minValue: 0,
        maxValue: 10,
        decimalPlaces: 0,
        onChanged: (value) {
          // Handle counter value changes
          print('Selected value: $value');
        },
      ),
    );
  }
}
