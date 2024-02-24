import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  const Logo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Image.asset(
          'assets/images/ETA-Logo.png',
          height: 30,
          fit: BoxFit.fitHeight,
          filterQuality: FilterQuality.high,
        ),
      ),
    );
  }
}
