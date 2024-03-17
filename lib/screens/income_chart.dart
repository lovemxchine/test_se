import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:d_chart/bar_custom/view.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../widgets/drawer_list.dart';

class IncomeChart extends StatefulWidget {
  const IncomeChart({Key? key}) : super(key: key);

  @override
  State<IncomeChart> createState() => _IncomeChartState();
}

class _IncomeChartState extends State<IncomeChart> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    String _year = getOnlyYear(Timestamp.now());
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
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Text(
              'ตารางรายได้ปีนี้ : ปี ${_year}',
              style: GoogleFonts.poppins(
                textStyle: Theme.of(context).textTheme.titleLarge,
                fontSize: 20,
                fontWeight: FontWeight.w400,
                color: Colors.black,
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 1,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.all(Radius.circular(10)),
              ),
            ),
            const SizedBox(height: 20),
            _buildChartForMonths(1, 6),
            const SizedBox(height: 20),
            _buildChartForMonths(7, 12),
          ],
        ),
      ),
    );
  }

  Widget _buildChartForMonths(int startMonth, int endMonth) {
    return Expanded(
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('income')
            .where('time',
                isGreaterThanOrEqualTo:
                    DateTime(DateTime.now().year, startMonth))
            .where('time',
                isLessThan: DateTime(DateTime.now().year, endMonth + 1))
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          Map<String, double> chartData = {};

          for (int i = startMonth; i <= endMonth; i++) {
            final monthYearKey =
                '${i.toString().padLeft(2, '0')}-${DateTime.now().year}';
            chartData[monthYearKey] = 0;
          }

          snapshot.data!.docs.forEach((doc) {
            final Timestamp time = doc['time'] as Timestamp;
            final monthYearKey =
                '${time.toDate().month.toString().padLeft(2, '0')}-'
                '${time.toDate().year}';
            final value = doc['receipt'].toDouble();
            chartData.update(
              monthYearKey,
              (existingValue) => existingValue + value,
              ifAbsent: () => value,
            );
          });
          List<String> monthAbbreviations = [
            'Jan',
            'Feb',
            'Mar',
            'Apr',
            'May',
            'Jun',
            'Jul',
            'Aug',
            'Sep',
            'Oct',
            'Nov',
            'Dec'
          ];
          List<DChartBarDataCustom> chartBars = chartData.entries.map((entry) {
            final month = int.parse(entry.key.substring(0, 2));
            final monthAbbreviation = monthAbbreviations[month - 1];
            return DChartBarDataCustom(
              value: entry.value,
              valueStyle: GoogleFonts.poppins(
                textStyle: Theme.of(context).textTheme.titleLarge,
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
              label: monthAbbreviation,
              color: Colors.blue,
              showValue: true,
            );
          }).toList();

          return Container(
            padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.025),
            child: Stack(
              children: [
                AspectRatio(
                  aspectRatio: 16 / 9,
                  child: DChartBarCustom(
                    showDomainLabel: true,
                    showMeasureLine: true,
                    showDomainLine: true,
                    spaceBetweenItem: 10,
                    spaceDomainLinetoChart: 10,
                    spaceMeasureLinetoChart: 10,
                    max: chartData.values.reduce(
                        (value, element) => value > element ? value : element),
                    radiusBar: const BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8),
                    ),
                    valueAlign: Alignment.topCenter,
                    listData: chartBars,
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  getOnlyYear(Timestamp getTime) {
    DateTime dateTime = getTime.toDate();

    String formattedDateTime = DateFormat('yyyy').format(dateTime);
    return formattedDateTime;
  }
}
