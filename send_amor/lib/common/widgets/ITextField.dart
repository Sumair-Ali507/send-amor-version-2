import 'package:flutter/material.dart';

import '../mixins/ts.dart';

class ITextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool? obscureText;
  final TextInputType keyboardType;
  final Widget? suffixIcon;
  final VoidCallback? onTap;
  final Widget? prefixIcon;
  final String? Function(String?)? validator;
  final FocusNode? focusNode;
  final String? errorMsg;
  final bool isFocused;
  final void Function(String)? onChanged;
  final InputBorder? enabledBorder;
  final InputBorder? focusedBorder;
  final TextStyle? hintStyle;
  final int? maxLines; // Maximum number of lines for the text field
  final int? minLines; // Minimum number of lines for the text field

  const ITextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.obscureText = false,
    required this.keyboardType,
    this.suffixIcon,
    this.onTap,
    this.prefixIcon,
    this.validator,
    this.focusNode,
    this.errorMsg,
    this.onChanged,
    this.isFocused = false,
    this.hintStyle,
    this.enabledBorder = InputBorder.none, // Default to no border
    this.focusedBorder = InputBorder.none, // Default to no border
    this.maxLines = 1, // Default to single-line text field
    this.minLines, // Optional, defaults to null
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      controller: controller,
      obscureText: obscureText ?? false,
      keyboardType: keyboardType,
      focusNode: focusNode,
      onTap: onTap,
      textInputAction:
          maxLines == 1 ? TextInputAction.next : TextInputAction.newline,
      onChanged: onChanged,
      maxLines: (obscureText ?? false) ? 1 : maxLines,
      minLines: minLines,
      decoration: InputDecoration(
        labelText: isFocused ? hintText : null,
        labelStyle: const TextStyle(color: Colors.black),
        hintText: hintText,
        hintStyle: hintStyle ?? Ts.normalStyle(context: context),
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        enabledBorder: enabledBorder,
        focusedBorder: focusedBorder,
        errorText: errorMsg, // Display the error message, if any
      ),
    );
  }
}
