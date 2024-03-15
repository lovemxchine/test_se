import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DrawerList extends StatefulWidget {
  const DrawerList({super.key});

  @override
  State<DrawerList> createState() => _DrawerListState();
}

void noti() {
  AwesomeNotifications().initialize(
    null,
    [
      NotificationChannel(
          channelKey: 'Hello',
          channelName: 'hello user',
          channelDescription: 'say hi')
    ],
    debug: true,
  );
}

class _DrawerListState extends State<DrawerList> {
  triggerNotification() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userRole = prefs.getString('userRole');
    if (userRole == 'employee') {
      AwesomeNotifications().createNotification(
          content: NotificationContent(
              id: 10, channelKey: 'Hello', title: 'พ่อมาา', body: 'แจ้งเตือน'));
    }
  }

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
                  btnOkOnPress: () {
                    triggerNotification();
                  }).show()
            },
          ),
          ListTile(
            leading: const Icon(Icons.check_box),
            title: const Text('ออกจากระบบ'),
            onTap: () {
              FirebaseAuth.instance.signOut();
              Navigator.pushNamed(context, "/login");
            },
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
