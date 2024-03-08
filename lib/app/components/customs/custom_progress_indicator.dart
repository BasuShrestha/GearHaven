import 'package:gearhaven/app/utils/colors.dart';
import 'package:flutter/material.dart';

class CustomProgressIndicator extends StatelessWidget {
  final Color? color;
  final Color? backgroundColor;
  final double? strokeWidth;
  final double? value; // Null for indeterminate progress
  final Animation<Color>? valueColor;
  final double? size;

  const CustomProgressIndicator({
    super.key,
    this.color,
    this.backgroundColor,
    this.strokeWidth,
    this.value,
    this.valueColor,
    this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: size,
        height: size,
        child: CircularProgressIndicator(
          value: value,
          strokeWidth: strokeWidth ?? 4.0, // Default stroke width
          backgroundColor: backgroundColor ?? Colors.transparent,
          color: color ?? CustomColors.accentColor,
          valueColor: valueColor,
        ),
      ),
    );
  }
}
