import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Menu extends StatelessWidget {
  const Menu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff3C696F),
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
          "My user",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Center(
        child: Stack(
          children: [
            Positioned(
              top: 5,
              right: 0,
              left: 0,
              bottom: 0,
              child: Container(
                width: 412,
                height: 1000,
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 231, 227, 227),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [Container(
                  )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
