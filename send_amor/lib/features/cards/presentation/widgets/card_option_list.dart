import 'package:flutter/material.dart';
import 'package:money_transfer_app/common/mixins/ts.dart';
import 'package:money_transfer_app/common/widgets/IHorizontalSpace.dart';
import 'package:money_transfer_app/common/widgets/IText.dart';

class CardOptionList extends StatelessWidget {
  final Icon icon;
  final String title;
  final VoidCallback onPressed;

  const CardOptionList(
      {super.key,
      required this.icon,
      required this.title,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: onPressed,
      child: Center(
        child: SizedBox(
          width: 300,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              icon,
              IHorizontalSpace(width: 4),
              Expanded(
                child: IText(
                  content: title,
                  textAlign: TextAlign.left,
                  textStyle: Ts.mediumStyle(
                      context: context, textColor: theme.colorScheme.primary),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
