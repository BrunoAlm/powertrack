import 'package:flutter/material.dart';

class CustomTextFormField extends StatefulWidget {
  const CustomTextFormField({
    Key? key,
    required this.maxWidth,
    this.maxHeight = 80,
    required this.hintText,
    required this.controller,
    this.prefixIcon,
  }) : super(key: key);
  final String hintText;
  final double maxWidth;
  final double maxHeight;
  final TextEditingController controller;
  final Widget? prefixIcon;
  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      cursorWidth: 5,
      decoration: InputDecoration(
        prefixIcon: widget.prefixIcon,
        constraints: BoxConstraints(
          maxWidth: widget.maxWidth,
          maxHeight: widget.maxHeight,
        ),
        hintText: widget.hintText,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}
