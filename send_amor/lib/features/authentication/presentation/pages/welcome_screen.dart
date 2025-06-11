import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:money_transfer_app/common/mixins/ts.dart';
import 'package:money_transfer_app/common/widgets/IAppButton.dart';
import 'package:money_transfer_app/common/widgets/IVerticalSpace.dart';
import 'package:money_transfer_app/core/config/SizeConfig.dart';
import 'package:money_transfer_app/core/constants/app_images.dart';
import 'package:money_transfer_app/core/constants/app_texts.dart';
import 'package:money_transfer_app/core/theme/app_color.dart';
import 'package:money_transfer_app/features/authentication/domain/authentication_repository.dart';
import 'package:money_transfer_app/features/authentication/presentation/bloc/authentication_bloc/authentication_bloc.dart';
import 'package:money_transfer_app/features/authentication/presentation/pages/login_page.dart';
import 'package:money_transfer_app/features/authentication/presentation/pages/register_page.dart';
import 'package:money_transfer_app/features/dashboard/presentation/pages/home_page.dart';
import 'package:money_transfer_app/features/dashboard/presentation/widgets/animated_text.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Center(child: AnimatedText(fullText: AppTexts.appName)),
            IVerticalSpace(
              height: SizeConfig.safeBlockVertical * 0.4,
            ),
            SvgPicture.asset(
              AppImages().earthSvg,
              width: 80,
              height: 80,
            ),
            IVerticalSpace(
              height: SizeConfig.safeBlockVertical * 1,
            ),
            IAppButton(
              text: AppTexts.login,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => BlocProvider(
                            create: (context) => AuthenticationBloc(
                                authenticationRepository:
                                    AuthenticationRepository()),
                            child: const LoginPage(),
                          )),
                );
              },
              backgroundColor: const Color(AppColor.primaryColor),
              textStyle: Ts.mediumStyle(
                  context: context, textColor: const Color(AppColor.white)),
            ),
            IVerticalSpace(
              height: SizeConfig.safeBlockVertical * 0.4,
            ),
            IAppButton(
              text: AppTexts.register,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => BlocProvider(
                            create: (context) => AuthenticationBloc(
                                authenticationRepository:
                                    AuthenticationRepository()),
                            child: const RegisterPage(),
                          )),
                );
              },
              backgroundColor: const Color(AppColor.primaryColor),
              textStyle: Ts.mediumStyle(
                  context: context, textColor: const Color(AppColor.white)),
            )
          ],
        ),
      ),
    );
  }
}
