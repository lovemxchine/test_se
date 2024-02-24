import 'package:flutter/material.dart';

import 'button_view.dart';

class ItemsCard extends StatelessWidget {
  const ItemsCard({super.key});

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
                    margin: const EdgeInsets.all(5),
                    child: Image.asset("assets/images/$i.png"),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(bottom: 8),
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    "โปรโมชั่นเมนูต่างๆ",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    "อธิบายรายละเอียดโปรโมชั่นเกี่ยวกับสินค้า",
                    style: TextStyle(
                      fontSize: 11,
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
                    MyBut(onTap: () {}, hinText: "ดูรายละเอียด"),
                  ],
                )
              ],
            ),
          )
      ],
    );
  }
}
