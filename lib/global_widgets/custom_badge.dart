import 'package:flutter/material.dart';

class CustomBadge extends StatelessWidget {
  final String label;
  final Color color;
  final VoidCallback? onClick;
  final double radius;
  final EdgeInsets padding;
  final double? width;
  const CustomBadge({
    super.key,
    required this.label,
    required this.color,
    this.onClick,
    this.radius = 3,
    this.padding = const EdgeInsets.all(5),
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick,
      child: Container(
        width: width,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(radius),
        ),
        padding: padding,
        child: Text(
          label,
          style: const TextStyle(
            fontSize: 10,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
