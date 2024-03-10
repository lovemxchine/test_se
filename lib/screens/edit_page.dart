import 'dart:io';
// import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'package:test_se/components/text_field.dart';
import 'package:test_se/widgets/drawer_list.dart';
// import 'package:test_se/widgets/realtime_widget.dart';

class EditPage extends StatefulWidget {
  EditPage({super.key});

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  final menuController = TextEditingController();
  final priceController = TextEditingController();
  final descriptionController = TextEditingController();
  PlatformFile? pickedFile;

  Future _selectImage() async {
    final result = await FilePicker.platform.pickFiles();
    if (result == null) return;

    setState(() {
      pickedFile = result.files.first;
    });
  }

  Future<void> _accept() async {
    if (pickedFile == null) {
      return;
    }

    FirebaseStorage firebaseStorage = FirebaseStorage.instance;
    String menu_id = DateTime.now().toString();
    final file = File(pickedFile!.path!);
    final ref = FirebaseStorage.instance.ref().child('Menu/$menu_id');

    await ref.putFile(file);

    String url = await ref.getDownloadURL();
    print(url);

    addMenuCollection(
      menuController.text,
      priceController.text,
      url,
    );
    Navigator.pop(context);
  }

  Future<void> addMenuCollection(
    String name,
    // String descript,
    String price,
    String url,
  ) async {
    await FirebaseFirestore.instance.collection('stock').add({
      'name': name,
      'price': price + ' บาท',
      'url': url,
      'quantity': 0,
    }).then((DocumentReference docRef) {
      // เมื่อเอกสารถูกสร้างเรียบร้อยแล้ว คุณสามารถเข้าถึง Document ID ที่ Firebase สร้างได้ที่นี่
      String docId = docRef.id;
      print('เอกสารถูกสร้างเรียบร้อยแล้ว: $docId');

      // สร้างเอกสารใหม่เพื่อเซ็ตฟิลด์ 'docId' ด้วย Document ID ที่ได้
      FirebaseFirestore.instance.collection('stock').doc(docId).set({
        'name': name,
        'price': price + ' บาท',
        'url': url,
        'quantity': 0,
        'docId':
            docId, // เพิ่มฟิลด์ 'docId' โดยให้ค่าเป็น Document ID ที่ Firebase สร้าง
      });
    }).catchError((error) {
      // แสดงข้อความเมื่อเกิดข้อผิดพลาดในการสร้างเอกสาร
      print('เกิดข้อผิดพลาดในการสร้างเอกสาร: $error');
    });
    ;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xff17333C),
      appBar: AppBar(
        toolbarHeight: 90,
        leading: IconButton(
          padding: const EdgeInsets.only(left: 10),
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
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
          "Add Menu",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          color: Color.fromARGB(255, 240, 240, 240),
        ),
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.025,
            ),
            if (pickedFile != null)
              Container(
                width: 200,
                height: 200,
                color: Colors.amber,
                child: Center(
                  child: ClipRect(
                    child: Image.file(
                      File(pickedFile!.path!),
                      width: 200, // กำหนดความกว้างของรูปภาพ
                      height: 200, // กำหนดความสูงของรูปภาพ
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              )
            else
              Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.blue[100],
                ),
                child: const Center(
                  child: Text('รูปเมนู'),
                ),
              ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.025,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.025,
            ),
            Container(
              width: 320,
              child: Column(
                children: [
                  MyTextField(
                    hintText: "ชื่อเมนู",
                    controller: menuController,
                    obscureText: false,
                    labelText: "",
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.025,
                  ),
                  MyTextField(
                    hintText: "ราคาอาหาร",
                    controller: priceController,
                    obscureText: false,
                    labelText: "",
                  ),
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.025,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: _selectImage, child: const Text('เลือกรูปเมนู')),
                const SizedBox(
                  width: 20,
                ),
                ElevatedButton(
                    onPressed: _accept, child: const Text('ยืนยันเพิ่มเมนู'))
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.025,
            )
          ],
        ),
      ),
    );
  }
}
