import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyButton extends StatelessWidget {
  const MyButton({
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
          horizontal: 30.0,
        ),
        decoration: BoxDecoration(
          color: Color(0xff396870),
          borderRadius: BorderRadius.circular(20.0),
          boxShadow: const [
            BoxShadow(
              blurRadius: 10,
              color: Color.fromARGB(152, 0, 0, 0),
              offset: Offset(1, 2),
            )
          ],
        ),
        child: Center(
          child: Text(
            hinText,
            style: GoogleFonts.poppins(
              textStyle: Theme.of(context).textTheme.titleLarge,
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
