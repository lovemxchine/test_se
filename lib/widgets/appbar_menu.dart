import 'package:flutter/material.dart';

class AppbarMenu extends StatelessWidget {
  const AppbarMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
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
          "K plus",
          style: TextStyle(color: Colors.white),
        ),
      );
  }
}