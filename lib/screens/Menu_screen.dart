import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test_se/widgets/appbar_menu.dart';
import 'package:test_se/widgets/bar_menu.dart';

class Menu extends StatefulWidget {
  const Menu({super.key});

  @override
  State<Menu> createState() => _MenuState();
}

List<String> meat = [
  "เนื้อสัตว์",
  "ทะเล",
  "ผัก",
  "ไอศรีม",
  "ลูกชิ้น",
  "อื่นๆ",
];


class _MenuState extends State<Menu> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color.fromARGB(255, 217, 216, 216),
      body:SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: [
            AppbarMenu(),
            BarMenu()
          ],
        ),
      ),
    );
  }
}
