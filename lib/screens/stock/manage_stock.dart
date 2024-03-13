import 'package:flutter/material.dart';
import 'package:test_se/screens/stock/stock_promotion.dart';
import '../manage_menu.dart';

class ManageStock extends StatefulWidget {
  const ManageStock({super.key});

  @override
  State<ManageStock> createState() => _ManageStockState();
}

class _ManageStockState extends State<ManageStock> {
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
          "Stock",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            color: Color.fromARGB(255, 240, 240, 240),
          ),
          child: ListView(
            children: [
              ListTile(
                  title: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ManageMenu()),
                  );
                },
                child: const Text(
                  'Stock Menu',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 25,
                      fontWeight: FontWeight.w400),
                ),
              )),
              ListTile(
                  title: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const StockPromotion()),
                  );
                },
                child: const Text(
                  'Stock Promotion',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 25,
                      fontWeight: FontWeight.w400),
                ),
              )),
            ],
          )),
    );
  }
}
