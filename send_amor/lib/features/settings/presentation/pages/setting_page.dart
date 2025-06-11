import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_transfer_app/common/widgets/AppLogo.dart';
import 'package:money_transfer_app/common/widgets/IVerticalSpace.dart';
import 'package:money_transfer_app/core/constants/app_texts.dart';
import 'package:money_transfer_app/core/theme/app_color.dart';
import 'package:money_transfer_app/features/chat/screens/chat_screen.dart';
import '../../../../common/mixins/ts.dart';
import '../../../../common/widgets/IText.dart';
import '../../../../core/theme/theme_bloc/theme_bloc.dart';
import '../../../../core/theme/theme_bloc/theme_event.dart';
import '../../../bankAccount/presentation/widgets/option_list_tile.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  bool _biometricEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            IVerticalSpace(),
            AppLogo(),
            IVerticalSpace(),
            OptionListTile(
              title: AppTexts.theme,
              subTitle: AppTexts.switchTheme,
              icon: const Icon(
                Icons.dark_mode,
                color: Color(AppColor.primaryColor),
              ),
              onPressed: () {
                context.read<ThemeBloc>().add(ToggleThemeEvent());
              },
            ),
            IVerticalSpace(),
            OptionListTile(
              title: AppTexts.help,
              subTitle: AppTexts.privacyFeesLanguage,
              icon: const Icon(
                Icons.help,
                color: Color(AppColor.primaryColor),
              ),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=> const ChatScreen()));
              },
            ),
            IVerticalSpace(),
            OptionListTile(
              title: AppTexts.enableFaceId,
              subTitle: AppTexts.useFacialRecognition,
              icon: const Icon(
                Icons.face_unlock_outlined,
                color: Color(AppColor.primaryColor),
              ),
              onPressed: () {},
            ),
            IVerticalSpace(),
            OptionListTile(
              title: AppTexts.passcodeSettings,
              subTitle: AppTexts.twoFactorAuthentication,
              icon: const Icon(
                Icons.biotech,
                color: Color(AppColor.primaryColor),
              ),
              onPressed: () {},
            ),
            IVerticalSpace(),
            OptionListTile(
              title: AppTexts.notifications,
              subTitle: AppTexts.seeNotifications,
              icon: const Icon(
                Icons.notifications,
                color: Color(AppColor.primaryColor),
              ),
              onPressed: () {},
            ),
            IVerticalSpace(),
            OptionListTile(
              title: AppTexts.screenLock,
              subTitle: AppTexts.biometric,
              trailing: Switch(
                value: _biometricEnabled,
                onChanged: (bool value) {
                  setState(() {
                    _biometricEnabled = value;
                  });
                },
                activeColor: const Color(AppColor.primaryColor),
              ),
              onPressed: () {},

            ),
            IVerticalSpace(),

            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     IText(
            //       content: AppTexts.light,
            //       textStyle: Ts.mediumStyle(context: context, size: 17.0),
            //     ),
            //     IconButton(
            //       onPressed: () {
            //         context.read<ThemeBloc>().add(ToggleThemeEvent());
            //       },
            //       icon: const Icon(Icons.toggle_on),
            //     ),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}
