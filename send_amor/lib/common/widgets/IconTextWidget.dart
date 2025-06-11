import 'package:flutter/material.dart';
import 'package:money_transfer_app/common/mixins/ts.dart';
import 'package:money_transfer_app/common/widgets/IText.dart';

class IconTextWidget extends StatelessWidget {
  final Icon icon;
  final String title;
  final VoidCallback onPressed;
  const IconTextWidget(
      {super.key,
      required this.icon,
      required this.title,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: onPressed,
      child: Column(
        children: [
          icon,
          IText(
            content: title,
            textStyle: Ts.normalStyle(
                context: context,
                textColor: theme.colorScheme.primary,
                size: 14.0),
          )
        ],
      ),
    );
  }
}
