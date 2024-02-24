import 'package:flutter/material.dart';
import '../widgets/items_card.dart';
import 'testAll_screen.dart';

class Promotion extends StatefulWidget {
  const Promotion({super.key});

  @override
  State<Promotion> createState() => _PromotionState();
}

class _PromotionState extends State<Promotion> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff17333C),
      appBar: AppBar(
        toolbarHeight: 90,
        leading: IconButton(
          padding: const EdgeInsets.only(left: 10),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const TestPage()),
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
          "Promotion",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: ListView(children: [
        Container(
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              color: Color.fromARGB(255, 240, 240, 240)),
          child: const Column(
            children: [ItemsCard()],
          ),
        ),
      ]),
    );
  }
}
