import 'package:flutter/material.dart';
import 'package:flutter_bloc_example/core/extentions/margin_extention.dart';
import 'package:flutter_bloc_example/core/extentions/padding_extention.dart';

class CustomEditField extends StatelessWidget {
  final bool obscureText;
  final String hintText;
  final String? initialValue;
  final Function(String)? onChanged;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;

  const CustomEditField(
      {super.key,
      this.initialValue,
      this.onChanged,
      this.validator,
      this.obscureText = false,
      required this.hintText,
      this.suffixIcon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: context.horizontalPadding(0.04),
      margin: context.verticalMargin(0.015),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: Offset(2, 4))
          ]),
      child: TextFormField(
        initialValue: initialValue,
        decoration: InputDecoration(
            suffixIcon: suffixIcon,
            hintText: hintText,
            hintStyle: TextStyle(
                fontSize: 14,
                color: Colors.black54,
                fontWeight: FontWeight.w500),
            border: InputBorder.none),
        onChanged: onChanged,
        validator: validator,
      ),
    );
  }
}
