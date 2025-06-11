import 'package:flutter/material.dart';
import '../../core/theme/app_color.dart';

class IHorizontalLine extends StatelessWidget {
  Color? lineColor;
  double? lineHeight;

  IHorizontalLine(
      {super.key,
      this.lineColor = const Color(AppColor.grey),
      this.lineHeight = 1.0});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: lineColor,
      height: lineHeight,
    );
  }
}
