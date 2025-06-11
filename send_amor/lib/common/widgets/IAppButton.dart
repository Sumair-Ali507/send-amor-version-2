import 'package:flutter/material.dart';
import '../../core/theme/app_color.dart';
import '../mixins/ts.dart';


class IAppButton extends StatelessWidget {
  final String text;
  final double? width; // Optional width
  final double? height; // Optional height
  final Color backgroundColor;
  final Color textColor;
  final double borderRadius;
  final TextStyle? textStyle;
  final VoidCallback onTap;

  const IAppButton({
    super.key,
    required this.text,
    this.width, // Optional
    this.height, // Optional
    this.backgroundColor = const Color(AppColor.white),
    this.textColor = const Color(AppColor.black),
    this.borderRadius = 8.0,
    this.textStyle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height ?? 50.0,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        alignment: Alignment.center,
        child: Text(
          text,
          style: textStyle ??
              Ts.normalStyle(context: context, textColor: textColor),
        ),
      ),
    );
  }
}
