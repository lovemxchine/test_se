import 'package:flutter/material.dart';

import '../screens/testAll_screen.dart';

class DrawerList extends StatelessWidget {
  const DrawerList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            child: null,
            decoration: BoxDecoration(
              color: Color(0xff3C696F),
              gradient: LinearGradient(
                colors: [Color(0xff396870), Color(0xff17333C)],
                stops: [0, 1],
                begin: AlignmentDirectional(0, -0.8),
                end: AlignmentDirectional(0, 1.5),
                tileMode: TileMode.clamp,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.edit_document),
            title: Text('Edit Menu'),
            onTap: () => {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TestPage()),
              )
            },
          )
        ],
      ),
    );
  }
}
