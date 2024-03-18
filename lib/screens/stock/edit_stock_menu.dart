import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class EditStockMenu extends StatefulWidget {
  final DocumentReference docRef;

  FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  EditStockMenu({super.key, required this.docRef});

  @override
  State<EditStockMenu> createState() => _EditStockMenuState();
}

class _EditStockMenuState extends State<EditStockMenu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
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
          'Quantity Menu',
          style: TextStyle(color: Colors.white),
        ),
        toolbarHeight: 80,
        leading: IconButton(
          padding: const EdgeInsets.only(left: 10),
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            size: 30,
            color: Colors.black,
          ),
        ),
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: widget.docRef.get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }
          if (!snapshot.hasData) {
            return const Center(
              child: Text('No Data'),
            );
          }

          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          final quantityController = TextEditingController();
          final a = data['quantity'].toString();
          int b = 0;
          void addquantity() {
            data['quantity'] += int.parse(quantityController.text);
            b = data['quantity'];
          }

          return Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.white,
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
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.025,
                        ),
                        Container(
                          child: Row(
                            children: [
                              Text(
                                'จำนวน ' + a,
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        TextFormField(
                          controller: quantityController,
                          decoration: const InputDecoration(
                            labelText: 'จำนวนที่ต้องการเพิ่ม',
                          ),
                          onChanged: (value) {},
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
                        onPressed: () async {
                          addquantity();
                          await setMenuCollection(b, data['docId'])
                              ?.then((value) => Navigator.pop(context));
                        },
                        style: ButtonStyle(
                          padding:
                              MaterialStateProperty.all<EdgeInsetsGeometry>(
                            EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                          ),
                          foregroundColor: MaterialStateProperty.all<Color>(
                              Color.fromARGB(255, 74, 172, 253)),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                            ),
                          ),
                        ),
                        child: const Text('ยืนยันเพิ่ม Stock'),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.025,
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Future _acceptEdit() async {}

  Future<dynamic>? setMenuCollection(
    int quantity,
    String data,
  ) async {
    await FirebaseFirestore.instance
        .collection('stock')
        .doc('$data')
        .update({'quantity': quantity});
  }
}
