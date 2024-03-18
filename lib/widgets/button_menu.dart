import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyButtonMenu extends StatelessWidget {
  const MyButtonMenu({
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
        padding: const EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
        margin: const EdgeInsets.symmetric(horizontal: 5.0),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 90, 140, 149),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Center(
          child: Text(
            hinText,
            style: GoogleFonts.poppins(
              textStyle: Theme.of(context).textTheme.titleMedium,
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
