import 'package:gearhaven/app/utils/colors.dart';
import 'package:flutter/material.dart';

class EditProfileForm extends StatefulWidget {
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
  final double? width;

  const EditProfileForm({
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
    this.width,
  });

  @override
  State<EditProfileForm> createState() => _EditProfileFormState();
}

class _EditProfileFormState extends State<EditProfileForm> {
  var isObscured = false;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width ?? 350,
      child: TextFormField(
        controller: widget.controller,
        textInputAction: widget.textInputAction,
        cursorColor: widget.cursorColor ?? CustomColors.primaryColor,
        cursorHeight: widget.cursorHeight ?? 24,
        cursorOpacityAnimates: true,
        obscureText: widget.isPassword! ? !isObscured : false,
        style: widget.textStyle ??
            const TextStyle(
              fontSize: 18,
              color: CustomColors.primaryColor,
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
                  color: CustomColors.primaryColor,
                  fontSize: 18,
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
                        color: CustomColors.primaryColor,
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
              color: CustomColors.primaryColor,
              width: 2,
              style: BorderStyle.solid,
            ),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: CustomColors.primaryColor,
              width: 2,
              style: BorderStyle.solid,
            ),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: CustomColors.primaryColor,
              width: 2,
              style: BorderStyle.solid,
            ),
          ),
          errorBorder: UnderlineInputBorder(
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
