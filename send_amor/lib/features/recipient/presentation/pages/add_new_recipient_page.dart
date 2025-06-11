import 'package:flutter/material.dart';
import 'package:money_transfer_app/common/mixins/ts.dart';
import 'package:money_transfer_app/common/widgets/AppLogo.dart';
import 'package:money_transfer_app/common/widgets/IAppButton.dart';
import 'package:money_transfer_app/common/widgets/IText.dart';
import 'package:money_transfer_app/common/widgets/IVerticalSpace.dart';
import 'package:money_transfer_app/core/constants/app_texts.dart';

import '../../../../common/widgets/ITextField.dart';
import '../../../../core/theme/app_color.dart';

import 'package:country_picker/country_picker.dart'; // Import country_picker package

class AddNewRecipientPage extends StatefulWidget {
  const AddNewRecipientPage({super.key});

  @override
  State<AddNewRecipientPage> createState() => _AddNewRecipientPageState();
}

class _AddNewRecipientPageState extends State<AddNewRecipientPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController bankNameController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  Country? _selectedCountry;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const IText(
          content: AppTexts.addRecipient,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Spacer(),
            AppLogo(),
            IVerticalSpace(
              height: 4,
            ),
            ITextField(
                controller: nameController,
                hintText: AppTexts.fullName,
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: const BorderSide(width: 0.9)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: const BorderSide(
                        width: 1.5, color: Color(AppColor.primaryColor))),
                keyboardType: TextInputType.emailAddress),
            IVerticalSpace(),
            ITextField(
                controller: bankNameController,
                hintText: AppTexts.bankName,
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: const BorderSide(width: 0.9)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: const BorderSide(
                        width: 1.5, color: Color(AppColor.primaryColor))),
                keyboardType: TextInputType.emailAddress),
            IVerticalSpace(),
            // Country picker TextField
            GestureDetector(
              onTap: () {
                showCountryPicker(
                  context: context,
                  favorite: ['US'],
                  showPhoneCode: false, // Optional: Show country phone code
                  onSelect: (Country country) {
                    setState(() {
                      _selectedCountry = country;
                      countryController.text =
                          country.name; // Set country name in the TextField
                    });
                  },
                );
              },
              child: AbsorbPointer(
                child: TextField(
                  controller: countryController,
                  decoration: InputDecoration(
                    hintText: 'Select Country',
                    hintStyle: const TextStyle(
                        color: Colors.grey), 
                    suffixIcon: _selectedCountry != null
                        ? Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                        

                              IText(
                                content: _selectedCountry?.flagEmoji ?? '',
                                textStyle:
                                    Ts.boldStyle(context: context, size: 24.0),
                              ),
                              const SizedBox(
                                  width: 8),
                            ],
                          )
                        : const Icon(Icons.flag, color: Colors.grey),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: const BorderSide(width: 0.9),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: const BorderSide(
                          width: 1.5, color: Color(AppColor.primaryColor)),
                    ),
                  ),
                ),
              ),
            ),
            IVerticalSpace(),
            IAppButton(
              text: AppTexts.addRecipient,
              onTap: () {},
              backgroundColor: const Color(AppColor.primaryColor),
              textStyle: Ts.mediumStyle(
                  context: context, textColor: const Color(AppColor.white)),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
