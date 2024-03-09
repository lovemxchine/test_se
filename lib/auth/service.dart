// import 'package:flutter/services.dart';
// import 'package:flutter/material.dart';

// @override
// Widget build(BuildContext context) {
//   // ignore: deprecated_member_use
//   return WillPopScope(
//     onWillPop: () async {
//       if (FirebaseAuth.instance.currentUser != null) {
//         // ถ้าผู้ใช้ล็อกอินอยู่ กำหนดให้ไม่สามารถย้อนกลับได้
//         return false;
//       } else {
//         // ถ้าไม่ได้ล็อกอิน อนุญาตให้ย้อนกลับได้
//         return true;
//       }
//     },
//     child: Scaffold(
//         // ส่วนอื่น ๆ ของหน้าหลัก
//         ),
//   );
// }

// @override
// void initState() {
//   super.initState();
//   // ตั้งค่าการเปิดใช้งานการจัดการการกดปุ่มย้อนกลับ
//   SystemChannels.platform.invokeMethod('SystemNavigator.pop', true);
// }
