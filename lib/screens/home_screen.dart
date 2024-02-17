import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("Register/Login"),
      // ),
      body: Stack(
        children: [
          Align(
            alignment: AlignmentDirectional(0, -1.34),
            child: Container(
              width: 415,
              height: 393,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xff396870),
                    Color(0xff17333C),
                  ],
                  stops: [0, 1],
                  begin: AlignmentDirectional(0, -1),
                  end: AlignmentDirectional(0, 1),
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(56),
                  bottomRight: Radius.circular(56),
                  topLeft: Radius.circular(0),
                  topRight: Radius.circular(0),
                ),
              ),
            ),
          ),
          Align(
            alignment: AlignmentDirectional(0, -0.8),
            child: Container(
              width: 110,
              height: 110,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 10,
                    color: Color(0x33000000),
                    offset: Offset(0, 2),
                  )
                ],
                borderRadius: BorderRadius.circular(24),
              ),
              child: Align(
                alignment: AlignmentDirectional(0, 0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    'assets/images/logo.png',
                    width: 300,
                    height: 200,
                    fit: BoxFit.cover,
                    alignment: Alignment(0, 0),
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: AlignmentDirectional(0, -0.10),
            child: Container(
              width: 300,
              height: 272,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 10,
                    color: Color(0xA2000000),
                    offset: Offset(2, 2),
                  )
                ],
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(24),
                  bottomRight: Radius.circular(24),
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
              ),
              alignment: AlignmentDirectional(0, 0),
              child: Align(
                alignment: AlignmentDirectional(0, 0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Align(
                      alignment: AlignmentDirectional(0, 0),
                      child: Padding(
                        padding: EdgeInsets.all(20),
                        child: Row(
                          children: [
                            Text(
                              'LOGIN',
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                fontFamily: 'Mitr',
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              'เข้าสู่ระบบ',
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                fontFamily: 'Mitr',
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )

          // Align(
          //   alignment: AlignmentDirectional(0, -0.09),
          //   child: Container(
          //     width: 300,
          //     height: 272,
          //     decoration: BoxDecoration(
          //       color: Colors.white,
          //       boxShadow: [
          //         BoxShadow(
          //           blurRadius: 10,
          //           color: Color(0xA2000000),
          //           offset: Offset(2, 2),
          //         )
          //       ],
          //       borderRadius: BorderRadius.circular(16),
          //     ),
          //     alignment: AlignmentDirectional(0, 0),
          //     child: Align(
          //       alignment: AlignmentDirectional(0, 0),
          //       child: Column(
          //         mainAxisSize: MainAxisSize.max,
          //         crossAxisAlignment: CrossAxisAlignment.stretch,
          //         children: [
          //           Align(
          //             alignment: AlignmentDirectional(0, 0),
          //             child: Padding(
          //               padding: EdgeInsets.all(20),
          //               child: Text('LOGIN เข้าสู่ระบบ',
          //                   textAlign: TextAlign.end, style: TextStyle()),
          //             ),
          //           ),
          //         ],
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
      // Padding(
      //   padding: const EdgeInsets.fromLTRB(10, 50, 10, 20),
      //   child: SingleChildScrollView(
      //     child:
      //     Stack(children: [
      //   Align(
      //     alignment: AlignmentDirectional(0, -0.9),
      //     child: Container(
      //       width: 311,
      //       height: 266,
      //       decoration: BoxDecoration(
      //         gradient: LinearGradient(
      //           colors: [
      //             Color(0xff396870),
      //             Color(0xff17333C),
      //           ],
      //           stops: [0, 1],
      //           begin: AlignmentDirectional(0, -1),
      //           end: AlignmentDirectional(0, 1),
      //         ),
      //       ),
      //     ),
      //   ),
      //   Align(
      //     alignment: AlignmentDirectional(0, 0),
      //     child: Container(
      //       child: Column(
      //         // mainAxisSize: MainAxisSize.max,
      //         crossAxisAlignment: CrossAxisAlignment.stretch,
      //         children: [
      //           SizedBox(
      //             height: 60,
      //             width: 200,
      //             child: ElevatedButton.icon(
      //               onPressed: () {},
      //               icon: Icon(Icons.home),
      //               label: Text(
      //                 'test',
      //                 style: TextStyle(fontSize: 20),
      //               ),
      //             ),
      //           ),
      //           Align(
      //             alignment: AlignmentDirectional(0, 0),
      //             child: Padding(
      //               padding: EdgeInsets.all(20),
      //               child: Text(
      //                 'LOGIN เข้าสู่ระบบ',
      //                 textAlign: TextAlign.end,
      //                 // style: TextStyle()
      //               ),
      //             ),
      //           ),
      //         ],
      //       ),
      //     ),
      //   ),
      //   // Align(
      //   //   alignment: AlignmentDirectional(0, 0),
      //   //   child: Row(
      //   //     mainAxisAlignment: MainAxisAlignment.center,
      //   //     children: [
      //   //       Container(
      //   //         child: Column(
      //   //           children: [
      //   //             SizedBox(
      //   //               height: 60,
      //   //               width: 200,
      //   //               child: ElevatedButton.icon(
      //   //                 onPressed: () {},
      //   //                 icon: Icon(Icons.home),
      //   //                 label: Text(
      //   //                   'test',
      //   //                   style: TextStyle(fontSize: 20),
      //   //                 ),
      //   //               ),
      //   //             ),
      //   //             SizedBox(
      //   //               height: 20,
      //   //             ),
      //   //             SizedBox(
      //   //               height: 60,
      //   //               width: 200,
      //   //               child: ElevatedButton.icon(
      //   //                 onPressed: () {},
      //   //                 icon: Icon(Icons.home),
      //   //                 label: Text(
      //   //                   'test',
      //   //                   style: TextStyle(fontSize: 20),
      //   //                 ),
      //   //               ),
      //   //             ),
      //   //           ],
      //   //         ),
      //   //       ),
      //   //     ],
      //   //   ),
      //   // ),
      // ]),
    );
    // ),
    // );
  }
}
