import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyButtonWait extends StatelessWidget {
  const MyButtonWait({
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
          color: Colors.grey.shade500,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Center(
          child: Text(
            hinText,
            style: GoogleFonts.poppins(
              textStyle: Theme.of(context).textTheme.titleLarge,
              fontSize: 18,
              fontWeight: FontWeight.w300,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
