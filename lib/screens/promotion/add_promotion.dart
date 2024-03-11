import 'package:flutter/material.dart';
import 'package:test_se/components/text_field.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:file_picker/file_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';

class AddPromotion extends StatefulWidget {
  const AddPromotion({super.key});

  @override
  State<AddPromotion> createState() => _AddPromotionState();
}

class _AddPromotionState extends State<AddPromotion> {
  final nameProController = TextEditingController();
  final priceProController = TextEditingController();
  final descriptionController = TextEditingController();
  PlatformFile? pickedFile;
  bool _isProcessing = false;

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

    setState(() {
      _isProcessing = true;
    });
    FirebaseStorage firebaseStorage = FirebaseStorage.instance;
    String promotion_id = DateTime.now().toString();
    final file = File(pickedFile!.path!);
    final ref = FirebaseStorage.instance.ref().child('promotion/$promotion_id');

    await ref.putFile(file);

    String url = await ref.getDownloadURL();
    print(url);

    addPromotionCollection(
      nameProController.text,
      descriptionController.text,
      int.parse(priceProController.text),
      url,
    ).then((value) => Navigator.pop(context));
  }

  Future<void> addPromotionCollection(
    String name,
    String detail,
    int price,
    String url,
  ) async {
    await FirebaseFirestore.instance.collection('promotion').add({
      'name': name,
      'price': price,
      'detail': detail,
      'url': url,
      'quantity': 0,
    }).then((DocumentReference docRef) {
      String docId = docRef.id;
      print('เอกสารถูกสร้างเรียบร้อยแล้ว: $docId');

      FirebaseFirestore.instance.collection('promotion').doc(docId).set({
        'name': name,
        'price': price,
        'detail': detail,
        'url': url,
        'quantity': 0,
        'docId': docId,
      });
      ;
    }).catchError((error) {
      print('$error');
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
          "Add Promotion",
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
                      width: 200,
                      height: 200,
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
                  child: Text('รูปโปรโมชั่น'),
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
                    hintText: "ชื่อโปรโมชั่น",
                    controller: nameProController,
                    obscureText: false,
                    labelText: "",
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.025,
                  ),
                  MyTextField(
                    hintText: "รายละเอียดโปรโมชั่น",
                    controller: descriptionController,
                    obscureText: false,
                    labelText: "",
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.025,
                  ),
                  MyTextField(
                    hintText: "ราคาโปรโมชั่น",
                    controller: priceProController,
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
                    onPressed: _isProcessing ? null : _accept,
                    child: _isProcessing
                        ? const CircularProgressIndicator()
                        : const Text('ยืนยันเพิ่มเมนู'))
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
