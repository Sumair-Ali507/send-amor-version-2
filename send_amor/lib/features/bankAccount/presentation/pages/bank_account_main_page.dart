import 'package:flutter/material.dart';
import 'package:money_transfer_app/common/widgets/AppLogo.dart';
import 'package:money_transfer_app/common/widgets/IAppButton.dart';
import 'package:money_transfer_app/common/widgets/IVerticalSpace.dart';
import 'package:money_transfer_app/core/constants/app_texts.dart';
import 'package:money_transfer_app/core/theme/app_color.dart';

import '../widgets/option_list_tile.dart';

class BankAccountMainPage extends StatefulWidget {
  const BankAccountMainPage({super.key});

  @override
  State<BankAccountMainPage> createState() => _BankAccountMainPageState();
}

class _BankAccountMainPageState extends State<BankAccountMainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: AppLogo()),
          OptionListTile(
            title: AppTexts.linkBankAccount,
            subTitle: AppTexts.bankAccount,
            icon: const Icon(Icons.link_outlined),
            onPressed: () {},
          ),
          OptionListTile(
            title: AppTexts.cashDeposit,
            subTitle: AppTexts.makeDeposit,
            icon: const Icon(Icons.attach_money_outlined),
            onPressed: () {},
          ),
          OptionListTile(
            title: AppTexts.wireTransfer,
            subTitle: AppTexts.makeWireTransfer,
            icon: const Icon(Icons.money_sharp),
            onPressed: () {},
          ),
          OptionListTile(
            title: AppTexts.bankDebitCard,
            subTitle: AppTexts.useBankDebitCard,
            icon: const Icon(Icons.credit_card_outlined),
            onPressed: () {},
          ),
          IVerticalSpace(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: IAppButton(
                text: AppTexts.cashOutToBank,
                backgroundColor: const Color(AppColor.primaryColor),
                textColor: const Color(AppColor.white),
                onTap: () {}),
          )
        ],
      ),
    );
  }
}
