import 'package:flutter/material.dart';

class LogoZone extends StatelessWidget {
  const LogoZone({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: -50,
      left: -5,
      right: -5,
      // alignment: const AlignmentDirectional(0, -1.34),
      child: Container(
        width: 415,
        height: 393,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xff396870),
              Color(0xff17333C),
            ],
            stops: [0, 1],
            begin: AlignmentDirectional(0, -0.8),
            end: AlignmentDirectional(0, 1.5),
          ),
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(48),
            bottomRight: Radius.circular(48),
            // topLeft: Radius.circular(0),
            // topRight: Radius.circular(0),
          ),
        ),
      ),
    );
  }
}
