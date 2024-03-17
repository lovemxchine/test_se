import 'package:d_chart/bar_custom/view.dart';
import 'package:flutter/material.dart';
import 'package:test_se/screens/admin_register_screen.dart';
import 'package:test_se/screens/check_in_work_time.dart';
import 'package:test_se/screens/manage_menu.dart';
import 'package:test_se/screens/stock/manage_stock.dart';
import '../widgets/drawer_list.dart';
import 'promotion/manage_promotion.dart';

class IncomeChart extends StatefulWidget {
  const IncomeChart({super.key});

  @override
  State<IncomeChart> createState() => _IncomeChartState();
}

class _IncomeChartState extends State<IncomeChart> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    List list = [
      {'class': 'a', 'total': 16},
      {'class': 'b', 'total': 20},
      {'class': 'c', 'total': 22},
      {'class': 'd', 'total': 23},
      {'class': 'e', 'total': 34},
    ];
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xff17333C),
      key: scaffoldKey,
      drawer: const DrawerList(),
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
          "Income Chart",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            color: Color.fromARGB(255, 240, 240, 240),
          ),
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              AspectRatio(
                aspectRatio: 16 / 9,
                child: DChartBarCustom(
                  showMeasureLine: true,
                  showDomainLine: true,
                  spaceBetweenItem: 10,
                  spaceDomainLinetoChart: 10,
                  spaceMeasureLinetoChart: 10,
                  max: 50,
                  radiusBar: const BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8)),
                  valueAlign: Alignment.bottomCenter,
                  listData: List.generate(list.length, (index) {
                    Map item = list[index];
                    return DChartBarDataCustom(
                        value: item['total'].toDouble(), label: item['class']);
                  }),
                ),
              )
            ],
          )),
    );
  }
}
