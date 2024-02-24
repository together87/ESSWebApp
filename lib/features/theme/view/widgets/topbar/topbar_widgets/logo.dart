import 'package:flutter/material.dart';

import '../../../../../../constants/style.dart';

class Logo extends StatelessWidget {
  const Logo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, top: 8.0, bottom: 8.0,right: 70),
      child: Row(
        children: [
          Image.asset(
            'assets/images/logo.png',
            width: 200,
            fit: BoxFit.contain ,
          ),
       /*   spacerx12,
          const Text(
            'Invoicing Audit',
            style: TextStyle(
              fontSize: 24,
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),*/
        ],
      ),
    );
  }
}
