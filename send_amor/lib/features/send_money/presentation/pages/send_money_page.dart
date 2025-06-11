import 'package:flutter/material.dart';
import 'package:money_transfer_app/common/widgets/AppLogo.dart';
import 'package:money_transfer_app/common/widgets/IText.dart';
import 'package:money_transfer_app/common/widgets/IVerticalSpace.dart';
import 'package:money_transfer_app/core/constants/app_texts.dart';

import '../../../../common/mixins/ts.dart';
import '../../../../common/widgets/IAppButton.dart';
import '../../../../common/widgets/ITextField.dart';
import '../../../../core/theme/app_color.dart';

class SendMoneyPage extends StatefulWidget {
  const SendMoneyPage({super.key});

  @override
  State<SendMoneyPage> createState() => _SendMoneyPageState();
}

class _SendMoneyPageState extends State<SendMoneyPage> {
  final TextEditingController moneyController = TextEditingController();

  final List<String> names = [
    "John",
    "Emily",
    "Michael",
    "Sarah",
    "David",
    "Sophia"
  ];

  // Selected name from the dropdown
  String? selectedName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IVerticalSpace(
              height: 3,
            ),
            AppLogo(),
            IVerticalSpace(
              height: 3,
            ),
            const Align(
                alignment: Alignment.topLeft,
                child: IText(content: AppTexts.selectUserToSendMoney)),
            IVerticalSpace(),
            buildSelectUserName(),
            IVerticalSpace(
              height: 2,
            ),
            const Align(
                alignment: Alignment.topLeft,
                child: IText(content: AppTexts.enterAmountToSend)),
            IVerticalSpace(),
            buildSendMoneyView(),
            IVerticalSpace(
              height: 2,
            ),
            IAppButton(
              text: AppTexts.sendMoney,
              onTap: () {},
              backgroundColor: const Color(AppColor.primaryColor),
              textStyle: Ts.mediumStyle(
                  context: context, textColor: const Color(AppColor.white)),
            ),
          ],
        ),
      ),
    );
  }

  buildSelectUserName() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      decoration: BoxDecoration(
        color: Colors.grey[200], // Background color of the dropdown
        borderRadius: BorderRadius.circular(8.0), // Rounded corners
        border: Border.all(color: Colors.grey, width: 1), // Border styling
      ),
      child: DropdownButton<String>(
        value: selectedName,
        hint: const Text("Select a name"), // Default placeholder
        isExpanded: true, // Makes the dropdown expand to full width
        underline: const SizedBox(), // Removes the default underline
        icon: const Icon(Icons.arrow_drop_down), // Dropdown icon
        borderRadius: BorderRadius.circular(8.0), // Rounded dropdown menu
        items: names.map((String name) {
          return DropdownMenuItem<String>(
            value: name,
            child: Text(name),
          );
        }).toList(),
        onChanged: (String? newValue) {
          setState(() {
            selectedName = newValue; // Update the selected value
          });
        },
      ),
    );
  }

  buildSendMoneyView() {
    return ITextField(
        controller: moneyController,
        hintText: '0.00',
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: const BorderSide(width: 0.9)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: const BorderSide(
                width: 1.5, color: Color(AppColor.primaryColor))),
        keyboardType: TextInputType.emailAddress);
  }
}
