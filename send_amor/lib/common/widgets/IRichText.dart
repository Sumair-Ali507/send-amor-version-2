import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';


class IRichText extends StatelessWidget {
  final String title;
  final String subTitle;
  final Color titleColor;
  final Color subTitleColor;
  final VoidCallback? onTap;
  final double spaceBetween;
  final TextStyle? titleTextStyle;
  final TextStyle? subTitleTextStyle;

  const IRichText({
    super.key,
    required this.title,
    required this.subTitle,
    this.titleColor = Colors.black,
    this.subTitleColor = Colors.blue,
    this.onTap,
    this.spaceBetween = 2.0,
    this.titleTextStyle,
    this.subTitleTextStyle,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context); // Access the current theme
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: title,
            style: titleTextStyle ?? theme.textTheme.titleSmall, // Works fine
          ),
          TextSpan(
            text: ' ' * spaceBetween.toInt(), // Add space for separation
          ),
          TextSpan(
            text: subTitle,
            style: subTitleTextStyle ??
                theme.textTheme.titleLarge
                    ?.copyWith(color: theme.colorScheme.primary),
            recognizer: TapGestureRecognizer()..onTap = onTap,
          ),
        ],
      ),
    );
  }
}
