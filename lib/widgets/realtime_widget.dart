import 'dart:async';

import 'package:flutter/material.dart';

class Realtime extends StatefulWidget {
  Realtime({super.key});

  @override
  State<Realtime> createState() => _RealtimeState();
}

class _RealtimeState extends State<Realtime> {
  String _currentDateTime = '';

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        _currentDateTime,
        style: TextStyle(color: Colors.black, fontSize: 20),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    // Set up a timer to update the current date and time frequently
    Timer.periodic(Duration(milliseconds: 100), (timer) {
      setState(() {
        DateTime now = DateTime.now();
        _currentDateTime =
            '${_getMonth(now.month)} ${now.year}, ${_formatNumber(now.day)} '
            '${_formatNumber(now.hour)}:${_formatNumber(now.minute)}:${_formatNumber(now.second)}';
      });
    });
  }

  String _getMonth(int month) {
    switch (month) {
      case 1:
        return 'January';
      case 2:
        return 'February';
      case 3:
        return 'March';
      case 4:
        return 'April';
      case 5:
        return 'May';
      case 6:
        return 'June';
      case 7:
        return 'July';
      case 8:
        return 'August';
      case 9:
        return 'September';
      case 10:
        return 'October';
      case 11:
        return 'November';
      case 12:
        return 'December';
      default:
        return '';
    }
  }

  String _formatNumber(int number) {
    return number.toString().padLeft(2, '0');
  }
}
