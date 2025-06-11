import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:money_transfer_app/common/widgets/AppLogo.dart';
import 'package:money_transfer_app/common/widgets/IVerticalSpace.dart';
import 'package:money_transfer_app/core/constants/app_images.dart';
import 'package:money_transfer_app/core/constants/app_texts.dart';
import 'package:money_transfer_app/core/theme/app_color.dart';
import 'package:money_transfer_app/features/cards/presentation/widgets/card_option_list.dart';

class CardPage extends StatefulWidget {
  const CardPage({super.key});

  @override
  State<CardPage> createState() => _CardPageState();
}

class _CardPageState extends State<CardPage> {
  @override                           
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IVerticalSpace(
            height: 8,
          ),
          Center(child: AppLogo()),
          IVerticalSpace(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: CardOptionList(
                onPressed: () {},
                icon: const Icon(Icons.credit_card_off_sharp),
                title: AppTexts.reportLostCard),
          ),
          IVerticalSpace(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: CardOptionList(
                onPressed: () {},
                icon: const Icon(Icons.credit_card_outlined),
                title: AppTexts.lockCard),
          ),
          IVerticalSpace(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: CardOptionList(
                onPressed: () {},
                icon: const Icon(
                  Icons.cancel_rounded,
                  color: Color(AppColor.red),
                ),
                title: AppTexts.cancelCard),
          ),
          IVerticalSpace(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: CardOptionList(
                onPressed: () {},
                icon: const Icon(Icons.call_rounded),
                title: AppTexts.customerService),
          ),
          IVerticalSpace(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: CardOptionList(
                onPressed: () {},
                icon: const Icon(Icons.message_rounded),
                title: AppTexts.chat),
          ),
          SizedBox(
              width: 300,
              height: 300,
              child: SvgPicture.asset(AppImages().dummyCardSvg)),
        ],
      ),
    );
  }
}
