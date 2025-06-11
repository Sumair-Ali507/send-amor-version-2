import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Ts {
  static TextStyle customTextStyle(
      {double size = 14,
      double height = 1.0,
      double letterSpacing = 1.0,
      required BuildContext context,
      required FontWeight fontWeight,
      Color? textColor = Colors.black}) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return GoogleFonts.poppins(
      fontSize: size,
      letterSpacing: letterSpacing,
      fontWeight: fontWeight,
      color: textColor, //isDarkMode ? Colors.white : Colors.black,
      decoration: TextDecoration.none,
      height: height,
    );
  }

  static TextStyle normalStyle(
      {double size = 14,
      double height = 1.0,
      double letterSpacing = 1.0,
      required BuildContext context,
      Color? textColor = Colors.black}) {
    return customTextStyle(
        size: size,
        context: context,
        fontWeight: FontWeight.w400,
        letterSpacing: letterSpacing,
        height: height,
        textColor: textColor);
  }

  static TextStyle mediumStyle(
      {double size = 14,
      double height = 1.0,
      double letterSpacing = 1.0,
      required BuildContext context,
      Color? textColor = Colors.black}) {
    return customTextStyle(
        size: size,
        context: context,
        fontWeight: FontWeight.w500,
        letterSpacing: letterSpacing,
        height: height,
        textColor: textColor);
  }

  static TextStyle lightStyle(
      {double size = 14,
      required BuildContext context,
      double height = 1.0,
      double letterSpacing = 1.0,
      Color? textColor = Colors.black}) {
    return customTextStyle(
        size: size,
        context: context,
        fontWeight: FontWeight.w300,
        letterSpacing: letterSpacing,
        height: height,
        textColor: textColor);
  }

  static TextStyle boldStyle(
      {double size = 14,
      double height = 1.0,
      double letterSpacing = 1.0,
      required BuildContext context,
      Color? textColor = Colors.black}) {
    return customTextStyle(
        size: size,
        fontWeight: FontWeight.w700,
        letterSpacing: letterSpacing,
        context: context,
        height: height,
        textColor: textColor);
  }

  static TextStyle semiBoldStyle(
      {double size = 14,
      double height = 1.0,
      double letterSpacing = 1.0,
      required BuildContext context,
      Color? textColor = Colors.black}) {
    return customTextStyle(
        size: size,
        fontWeight: FontWeight.w600,
        letterSpacing: letterSpacing,
        context: context,
        height: height,
        textColor: textColor);
  }

  static TextStyle extraBoldStyle(
      {double size = 14,
      double height = 1.0,
      double letterSpacing = 1.0,
      required BuildContext context,
      Color? textColor = Colors.black}) {
    return customTextStyle(
      size: size,
      fontWeight: FontWeight.w900,
      letterSpacing: letterSpacing,
      context: context,
      height: height,
    );
  }
}
