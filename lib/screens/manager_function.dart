import 'package:flutter/material.dart';
import 'package:test_se/screens/admin_register_screen.dart';
import 'package:test_se/screens/check_in_work_time.dart';
import 'package:test_se/screens/manage_menu.dart';
import 'package:test_se/screens/stock/manage_stock.dart';
import '../widgets/drawer_list.dart';
import 'promotion/manage_promotion.dart';

class ManagerFunc extends StatefulWidget {
  const ManagerFunc({super.key});

  @override
  State<ManagerFunc> createState() => _ManagerFuncState();
}

class _ManagerFuncState extends State<ManagerFunc> {
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
          "Setting",
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
                  'Manage Menu',
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
                        builder: (context) => const ManagePromotion()),
                  );
                },
                child: const Text(
                  'Manage Promotion',
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
                        builder: (context) => const ManageStock()),
                  );
                },
                child: const Text(
                  'Manage Stock',
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
                    MaterialPageRoute(builder: (context) => AdminRegister()),
                  );
                },
                child: const Text(
                  'Manage Employee',
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
                    MaterialPageRoute(builder: (context) => const ManageMenu()),
                  );
                },
                child: const Text(
                  'Summary of Income',
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
                        builder: (context) => const CheckInWorkTime()),
                  );
                },
                child: const Text(
                  'Time to work',
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
