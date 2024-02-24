import 'package:flutter/material.dart';

import 'button_view.dart';

class MenuCard extends StatelessWidget {
  const MenuCard({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      childAspectRatio: 0.68,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      shrinkWrap: true,
      children: [
        for (int i = 1; i <= 8; i++)
          Container(
            padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(width: 1, color: Colors.grey.shade500)),
            child: Column(
              children: [
                InkWell(
                  child: Container(
                    height: 150,
                    width: 150,
                    decoration: BoxDecoration(
                      image: DecorationImage(image: AssetImage("assets/images/$i.png"),
                      fit: BoxFit.cover
                      ),
                      border: Border.all(width: 1,color: Colors.grey.shade200),
                      borderRadius: BorderRadius.circular(12)
                    ),
                  ),
                ),
                const SizedBox(height: 10,),
                Container(
                  padding: const EdgeInsets.only(bottom: 8),
                  alignment: Alignment.center,
                  child: const Text(
                    "รายการอาหาร",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  child: const Text(
                    "500฿",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 7,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MyBut(onTap: () {}, hinText: "เพิ่มรายการ",),
                  ],
                )
              ],
            ),
          )
      ],
    );
  }
}
