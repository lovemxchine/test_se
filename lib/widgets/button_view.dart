import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyBut extends StatelessWidget {
  const MyBut({
    super.key,
    required this.onTap,
    required this.hinText,
  });

  final Function()? onTap;
  final String hinText;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10.0),
        margin: const EdgeInsets.symmetric(
          horizontal: 15.0,
        ),
        decoration: BoxDecoration(
          color: Color(0xff396870),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Center(
          child: Text(
            hinText,
            style: GoogleFonts.poppins(
              textStyle: Theme.of(context).textTheme.titleLarge,
              fontSize: 15,
              fontWeight: FontWeight.w300,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}