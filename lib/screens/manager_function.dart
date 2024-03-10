import 'package:flutter/material.dart';
import 'package:test_se/screens/manage_menu.dart';

import '../widgets/drawer_list.dart';

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
                leading: const Icon(
                  Icons.add,
                  size: 25,
                ),
                title: const Text(
                  'Edit Menu',
                  style: TextStyle(fontSize: 25, color: Colors.black),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ManageMenu()),
                  );
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.add,
                  size: 25,
                ),
                title: const Text(
                  'Add Promotion',
                  style: TextStyle(fontSize: 25, color: Colors.black),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ManageMenu()),
                  );
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.add,
                  size: 25,
                ),
                title: const Text(
                  'Add Stock',
                  style: TextStyle(fontSize: 25, color: Colors.black),
                ),
                onTap: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => const ManageMenu()),
                  // );
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.add,
                  size: 25,
                ),
                title: const Text(
                  'Add Role',
                  style: TextStyle(fontSize: 25, color: Colors.black),
                ),
                onTap: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => const ManageMenu()),
                  // );
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.menu,
                  size: 25,
                ),
                title: const Text(
                  'Summary of income',
                  style: TextStyle(fontSize: 25, color: Colors.black),
                ),
                onTap: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => const ManageMenu()),
                  // );
                },
              ),
            ],
          )),
    );
  }
}
