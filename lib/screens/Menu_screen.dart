import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Menu extends StatefulWidget {
  const Menu({super.key});

  @override
  State<Menu> createState() => _MenuState();
}

List<String> items = [
  "หมู",
  "เนื้อ",
  "ทะเล",
  "ผัก",
  "เส้น",
  "ไอศรีม",
  "ลูกชิ้น",
  "อื่นๆ",
];
int current = 0;

class _MenuState extends State<Menu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 217, 216, 216),
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
          "K plus",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.all(4),
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: [
            SizedBox(
              height: 70,
              width: double.infinity,
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: items.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            current = index;
                          });
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          margin: const EdgeInsets.all(4),
                          width: 80,
                          height: 45,
                          decoration: BoxDecoration(
                              color: current == index
                                  ? Color.fromARGB(255, 236, 246, 241)
                                  : Colors.white,
                              borderRadius: current == index
                                  ? BorderRadius.circular(15)
                                  : BorderRadius.circular(15),
                              border: current == index
                                  ? Border.all(
                                      color: Color.fromARGB(255, 106, 164, 141),
                                      width: 2)
                                  : null),
                          child: Center(
                            child: Text(
                              items[index],
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18,
                                  color: current == index
                                      ? Color.fromARGB(255, 45, 116, 83)
                                      : Colors.grey),
                            ),
                          ),
                        ),
                      ),
                      Visibility(
                        visible: current==index,
                          child: Container(
                        width: 5,
                        height: 5,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color.fromARGB(255, 106, 164, 141)),
                      ))
                    ],
                    //เดี๋ยวเขียนใส่ข้อมูลในlistviewเพิ่ม
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
