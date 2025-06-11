import 'package:flutter/material.dart';
import '../mixins/ts.dart';

class ITextButton extends StatelessWidget {
  final String text;
  final Color? color;
  final VoidCallback onPressed;
  final TextStyle? textStyle;

  const ITextButton(
      {super.key,
      required this.text,
      this.color = Colors.transparent,
      required this.onPressed,
      this.textStyle});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        foregroundColor: color,
      ),
      child: Text(
        text,
        style: textStyle ?? Ts.normalStyle(context: context, size: 18),
      ),
    );
  }
}
