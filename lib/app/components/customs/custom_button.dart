import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String label;
  final TextStyle? labelStyle;
  final VoidCallback onPressed;
  final double? width;
  final double? height;
  final Color? color;
  final bool? isDisabled;
  const CustomButton({
    super.key,
    required this.label,
    this.labelStyle,
    required this.onPressed,
    this.width,
    this.height,
    this.color,
    this.isDisabled = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onHover: (value) {},
      onTap: !isDisabled! ? onPressed : null,
      child: Container(
        width: width ?? 300,
        height: height ?? 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          boxShadow: const [
            BoxShadow(
              color: Colors.white54,
              offset: Offset(0, 5),
              blurStyle: BlurStyle.inner,
              blurRadius: 25,
            ),
          ],
          color: isDisabled!
              ? Colors.grey
              : color ?? Theme.of(context).colorScheme.tertiary,
        ),
        child: Center(
          child: Text(
            label,
            style: labelStyle ??
                const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 23,
                ),
          ),
        ),
      ),
    );
  }
}
