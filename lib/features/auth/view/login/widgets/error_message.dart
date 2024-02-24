import 'package:flutter/material.dart';

class ErrorMessageView extends StatelessWidget {
  final String validationMessage;
  const ErrorMessageView({
    super.key,
    required this.validationMessage,
  });

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Text(
      validationMessage,
      style: const TextStyle(
        fontSize: 12,
        color: Colors.red,
      ),
    );
  }
}
