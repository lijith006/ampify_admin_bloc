import 'package:flutter/material.dart';

class CircleIconWidget extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Color circleColor;
  final double size;
  final double outlineWidth;
  const CircleIconWidget({
    super.key,
    required this.icon,
    this.iconColor = Colors.white,
    this.circleColor = Colors.black54,
    this.size = 70,
    this.outlineWidth = 2,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: circleColor,
        shape: BoxShape.circle,
      ),

      // border: Border.all(color: outlineColor, width: outlineWidth)),
      child: Center(
        child: Icon(
          icon,
          color: iconColor,
          size: size / 2,
        ),
      ),
    );
  }
}
