import 'package:flutter/material.dart';

class CustomTextfield extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final TextStyle? labelStyle;
  final TextStyle? textStyle;
  final Color? cursorColor;
  final double? cursorHeight;
  final EdgeInsetsGeometry? contentPadding;
  final bool? isPassword;
  final Icon? suffixIcon;
  final VoidCallback? onSuffixIconPress;
  final TextInputAction? textInputAction;
  final Color? borderColor;
  final Color? iconColor;
  final TextInputType? keyboardType;

  const CustomTextfield({
    super.key,
    required this.controller,
    required this.label,
    this.labelStyle,
    this.textStyle,
    this.cursorColor,
    this.cursorHeight,
    this.contentPadding,
    this.isPassword = false,
    this.suffixIcon,
    this.onSuffixIconPress,
    this.textInputAction,
    this.borderColor,
    this.iconColor,
    this.keyboardType,
  });

  @override
  State<CustomTextfield> createState() => _CustomTextfieldState();
}

class _CustomTextfieldState extends State<CustomTextfield> {
  var isObscured = false;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 350,
      child: TextFormField(
        keyboardType: widget.keyboardType,
        controller: widget.controller,
        textInputAction: widget.textInputAction,
        cursorColor: widget.cursorColor ?? Colors.white,
        cursorHeight: widget.cursorHeight ?? 24,
        cursorOpacityAnimates: true,
        obscureText: widget.isPassword! ? !isObscured : false,
        style: widget.textStyle ??
            const TextStyle(
              fontSize: 18,
              color: Colors.white,
            ),
        decoration: InputDecoration(
          contentPadding: widget.contentPadding ??
              const EdgeInsets.symmetric(
                vertical: 1,
              ),
          label: Text(
            widget.label,
            style: widget.labelStyle ??
                const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
          ),
          suffixIcon: widget.suffixIcon != null
              ? GestureDetector(
                  onTap: widget.onSuffixIconPress,
                  child: widget.suffixIcon,
                )
              : widget.isPassword!
                  ? GestureDetector(
                      child: Icon(
                        isObscured
                            ? Icons.visibility_off_rounded
                            : Icons.visibility_rounded,
                        color: widget.iconColor ?? Colors.white,
                      ),
                      onTap: () {
                        setState(() {
                          isObscured = !isObscured;
                        });
                      },
                    )
                  : null,
          border: UnderlineInputBorder(
            borderSide: BorderSide(
              color: widget.borderColor ?? Colors.white,
              width: 2,
              style: BorderStyle.solid,
            ),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: widget.borderColor ?? Colors.white,
              width: 2,
              style: BorderStyle.solid,
            ),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: widget.borderColor ?? Colors.white,
              width: 2,
              style: BorderStyle.solid,
            ),
          ),
          errorBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.red,
              width: 2,
              style: BorderStyle.solid,
            ),
          ),
        ),
      ),
    );
  }
}
