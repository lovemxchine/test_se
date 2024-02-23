import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test_se/components/my_button.dart';

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
          onPressed: () {},
          icon: IconButton(
            icon: const Icon(
              Icons.menu,
              size: 30,
              color: Colors.white,
            ),
            onPressed: () {},
          ),
        ),
        backgroundColor: const Color(0xff3C696F),
        title: const Text(
          "Order",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: const Padding(
        padding:  EdgeInsets.fromLTRB(10,10,10,10),
        child:  Row(
            children:[
              MyButton(
                onTap: ClearOrder, hinText: 'Clear'
              ),
              
              SizedBox(
                width: 15,
              ),

              MyButton(
                onTap: ConfirmOrder, hinText: 'Confirm'
              ),    
            ]    
          ),
        ),
      );
  }
}
