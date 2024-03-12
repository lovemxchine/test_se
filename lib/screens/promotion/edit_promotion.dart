import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:test_se/screens/promotion/add_promotion.dart';

class EditPromotion extends StatefulWidget {
  final DocumentReference docRef;

  FirebaseStorage firebaseStorage = FirebaseStorage.instance;

  EditPromotion({Key? key, required this.docRef}) : super(key: key);

  @override
  State<EditPromotion> createState() => _EditListPromotionState();
}

class _EditListPromotionState extends State<EditPromotion> {
  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Promotion Detail'),
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
          final nameProController = TextEditingController(text: data['name']);
          final descriptionController =
              TextEditingController(text: data['detail']);
          final quantityProController =
              TextEditingController(text: data['quantity'].toString());
          final priceProController =
              TextEditingController(text: data['price'].toString());
          

          String addquantity() {
            int input = int.tryParse(quantityProController.text)?? 0;
            int existingValue = data['quantity'];
            int totalValue = input + existingValue;
            return totalValue.toString();
          }

          return Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.white,
            key: scaffoldKey,
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
                        TextFormField(
                          controller: nameProController,
                          // initialValue: menuController.text,
                          decoration: const InputDecoration(
                            labelText: 'ชื่อโปรโมชั่น',
                          ),
                          onChanged: (value) {},
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.025,
                        ),
                        TextFormField(
                          controller: descriptionController,
                          decoration: const InputDecoration(
                            labelText: 'รายละเอียด',
                          ),
                          onChanged: (value) {},
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.025,
                        ),
                        TextFormField(
                          controller: quantityProController,
                          decoration: const InputDecoration(
                            labelText: 'จำนวน',
                          ),
                          onChanged: (value) {},
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.025,
                        ),
                        TextFormField(
                          controller: priceProController,
                          decoration: const InputDecoration(
                            labelText: 'ราคา',
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
                            await setMenuCollection(
                                    nameProController.text,
                                    descriptionController.text,
                                    int.parse(quantityProController.text),
                                    int.parse(priceProController.text),
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
    String name,
    String detail,
    int quantity,
    int price,
    String data,
  ) async {
    await FirebaseFirestore.instance
        .collection('promotion')
        .doc('$data')
        .update({
      'name': name,
      'detail': detail,
      'quantity': quantity,
      'price': price
    });
  }
}
