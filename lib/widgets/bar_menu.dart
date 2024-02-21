import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BarMenu extends StatefulWidget {
  const BarMenu({super.key});

  @override
  State<BarMenu> createState() => _BarMenuState();
}
List<String> items = [
  "เนื้อสัตว์",
  "ทะเล",
  "ผัก",
  "ไอศรีม",
  "ลูกชิ้น",
  "อื่นๆ",
];
int current = 0;

class _BarMenuState extends State<BarMenu> {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(4),
        width: 500,
        height: 500,
        child: Column(
          children: [
            SizedBox(
              height: 70,
              width: 500,
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
                        visible: current == index,
                        child: Container(
                          width: 5,
                          height: 5,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color.fromARGB(255, 106, 164, 141)),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      );
  }
}