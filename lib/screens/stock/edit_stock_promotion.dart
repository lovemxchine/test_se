import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class EditStockPromotion extends StatefulWidget {
  final DocumentReference docRef;

  FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  EditStockPromotion({super.key, required this.docRef});

  @override
  State<EditStockPromotion> createState() => _EditStockPromotionState();
}

class _EditStockPromotionState extends State<EditStockPromotion> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Quantity Promotion'),
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
            return const Center(
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
          final quantityController =
              TextEditingController();
          final a = data['quantity'].toString();
          int b = 0;
          void addquantity(){
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
                          onPressed: () async {addquantity();
                            await setMenuCollection(
                                    b,
                                    data['docId'])
                                ?.then((value) => Navigator.pop(context));
                          },
                          child: const Text('ยืนยันแก้ไขเมนู'))
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
        .collection('promotion')
        .doc('$data')
        .update({'quantity': quantity});
  }
}
