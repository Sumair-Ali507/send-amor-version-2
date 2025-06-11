import 'package:flutter/material.dart';
import 'package:money_transfer_app/common/mixins/ts.dart';
import 'package:money_transfer_app/common/widgets/IText.dart';
import 'package:money_transfer_app/common/widgets/IVerticalSpace.dart';
import 'package:money_transfer_app/core/theme/app_color.dart';
import 'package:money_transfer_app/core/utils/Utils.dart';

class OptionListTile extends StatelessWidget {
  final String title;
  final String subTitle;
  final Widget? trailing;
  final Icon? icon;
  final VoidCallback onPressed;
  const OptionListTile(
      {super.key,
      required this.title,
      required this.subTitle,
      this.trailing,
      this.icon,
      required this.onPressed});

  @override

  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 4.0),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4.0),
            color: const Color(AppColor.white),
            boxShadow: [Utility.lightShadow()]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IText(
                  content: title,
                  textAlign: TextAlign.left,
                  textStyle: Ts.mediumStyle(
                      context: context,
                      size: 15.0,
                      textColor: const Color(AppColor.black)),
                ),
                IVerticalSpace(),
                IText(
                  content: subTitle,
                  textAlign: TextAlign.left,
                  textStyle: Ts.normalStyle(
                      context: context,
                      size: 14.0,
                      textColor: const Color(AppColor.lightBlack)),
                )
              ],
            ),
            icon ?? trailing ?? const SizedBox(),
          ],
        ),
      ),
    );
  }
}
