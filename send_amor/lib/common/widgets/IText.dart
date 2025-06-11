import 'package:flutter/material.dart';

import '../mixins/ts.dart';

class IText extends StatelessWidget {
  final String content;
  final Color? color;
  final TextOverflow? overflow;
  final TextStyle? textStyle;
  final TextAlign? textAlign;
  final TextDecoration? decoration;
  final int? maxLines;
  final FontWeight? fontWeight;

  const IText(
      {super.key,
      required this.content,
      this.color,
      this.overflow,
      this.textAlign,
      this.decoration,
      this.maxLines,
      this.textStyle,
      this.fontWeight});

  @override
  Widget build(BuildContext context) {
    return Text(content,
        overflow: overflow ?? TextOverflow.ellipsis,
        textAlign: textAlign ?? TextAlign.start,
        maxLines: maxLines,
        style: textStyle ?? Ts.normalStyle(context: context));
  }
}
