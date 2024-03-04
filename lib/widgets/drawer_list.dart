import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

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
            leading: const Icon(Icons.edit_document),
            title: const Text('เรียกพนักงาน'),
            onTap: () => {
              AwesomeDialog(
                      context: context,
                      dialogType: DialogType.warning,
                      animType: AnimType.topSlide,
                      showCloseIcon: true,
                      title: "เรียกพนักงานเสร็จสิ้น",
                      desc: "พนักงานกำลังมาหาคุณกรุณารอสักครู่",
                      // btnCancelOnPress: (){},
                      btnOkOnPress: () {})
                  .show()
            },
          ),
          ListTile(
            leading: const Icon(Icons.check_box),
            title: const Text('เช็คบิล'),
            onTap: () => {
              AwesomeDialog(
                context: context,
                dialogType: DialogType.warning,
                animType: AnimType.topSlide,
                showCloseIcon: true,
                title: "ยืนยันการเช็คบิล",
                desc: "โปรดตรวจสอบรายการอาหารของคุณ",
                btnCancelOnPress: () {},
                btnOkOnPress: () {},
              ).show()
            },
          ),
          const Spacer(),
          ListTile(
            leading: const Icon(Icons.check_box),
            title: const Text('ออกจากระบบ'),
            onTap: () {
              FirebaseAuth.instance.signOut();
              Navigator.pushNamed(context, "/login");
            },
          )
        ],
      ),
    );
  }
}
