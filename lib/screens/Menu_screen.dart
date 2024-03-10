import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/drawer_list.dart';
import '../widgets/menu_card.dart';

class Menu extends StatefulWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xff17333C),
      key: scaffoldKey,
      drawer: const DrawerList(),
      appBar: AppBar(
        toolbarHeight: 90,
        leading: IconButton(
          padding: const EdgeInsets.only(left: 10),
          onPressed: () {
            scaffoldKey.currentState?.openDrawer();
          },
          icon: const Icon(
            Icons.notifications_active,
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
          "Menu",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('stock').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<DocumentSnapshot> documents = snapshot.data!.docs;
            return Container(
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                  color: Color.fromARGB(255, 240, 240, 240)),
              child: ListView(children: [
                Column(
                  children: [
                    GridView.count(
                      childAspectRatio: 0.68,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 2,
                      shrinkWrap: true,
                      children: [
                        for (var doc in documents)
                          Container(
                            padding: const EdgeInsets.only(
                                left: 15, right: 15, top: 10),
                            margin: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                  width: 1, color: Colors.grey.shade500),
                            ),
                            child: Column(
                              children: [
                                InkWell(
                                  child: Container(
                                    height: MediaQuery.of(context).size.width *
                                        0.35,
                                    width:
                                        MediaQuery.of(context).size.width * 0.4,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: NetworkImage(doc['url']),
                                        fit: BoxFit.cover,
                                      ),
                                      border: Border.all(
                                          width: 1,
                                          color: Colors.grey.shade200),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Container(
                                  padding: const EdgeInsets.only(bottom: 8),
                                  alignment: Alignment.center,
                                  child: Text(
                                    // Get the name from Firestore
                                    doc['name'],
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  child: Text(
                                    'ราคา : ${doc['price']}',
                                    style: GoogleFonts.mitr(
                                        textStyle: const TextStyle(
                                            fontSize: 12,
                                            color:
                                                Color.fromARGB(255, 0, 0, 0))),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              doc['quantity'] > 0
                                                  ? Colors.green
                                                  : Colors.grey),
                                    ),
                                    onPressed: doc['quantity'] > 0
                                        ? () {
                                            print('enough quantity');
                                          }
                                        : () {
                                            print('not enough quantity');
                                          },
                                    child: doc['quantity'] > 0
                                        ? Text(
                                            'เพิ่มลงตะกร้า',
                                            style: GoogleFonts.mitr(
                                              textStyle: const TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 0, 0, 0),
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                          )
                                        : Text(
                                            'สินค้าไม่พร้อม',
                                            style: GoogleFonts.mitr(
                                              textStyle: const TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 0, 0, 0),
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                          )),
                              ],
                            ),
                          )
                      ],
                    ),
                  ],
                ),
              ]),
            );
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
