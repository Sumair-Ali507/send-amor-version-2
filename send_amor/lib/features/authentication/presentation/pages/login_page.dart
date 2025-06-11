import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:money_transfer_app/common/widgets/ITextField.dart';
import 'package:money_transfer_app/core/utils/Utils.dart';
import 'package:money_transfer_app/features/profile/domain/profile_repository.dart';
import 'package:money_transfer_app/features/profile/presentation/bloc/bloc/profile_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../common/mixins/ts.dart';
import '../../../../common/widgets/AppLogo.dart';
import '../../../../common/widgets/IAppButton.dart';
import '../../../../common/widgets/IRichText.dart';
import '../../../../common/widgets/IText.dart';
import '../../../../common/widgets/IVerticalSpace.dart';
import '../../../../core/config/SizeConfig.dart';
import '../../../../core/constants/app_texts.dart';
import '../../../../core/theme/app_color.dart';
import '../../../dashboard/presentation/pages/dashboard_page.dart';
import '../../data/app_user.dart';
import '../../domain/authentication_repository.dart';
import '../bloc/authentication_bloc/authentication_bloc.dart';
import 'register_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isLoading = false;
  bool showPassword = false;

  AuthenticationRepository authenticationRepository =
      AuthenticationRepository();

  @override
  void initState() {
    super.initState();
    _checkLoginState(); // Check login state on app start
  }

  Future<void> _checkLoginState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool(AppTexts.isLoggedIn) ?? false;

    if (isLoggedIn) {
      _navigateToDashboard();
    }
  }

  void _navigateToDashboard() async {
    if (emailController.text == '') {
      Fluttertoast.showToast(msg: 'Enter email address');
    } else if (passwordController.text == '') {
      Fluttertoast.showToast(msg: 'Enter password');
    } else {
      setState(() {
        isLoading = true;
      });
      AppUser? appUser = await authenticationRepository.loginWithEmail(
          context: context,
          email: emailController.text,
          password: passwordController.text);

      setState(() {
        isLoading = false;
      });

      print('Check -- ${appUser?.success}');

      if (appUser?.success == true) {
        Utility.saveAppUser(appUser!);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => BlocProvider(
                    create: (context) =>
                        ProfileBloc(profileRepository: ProfileRepository()),
                    child: const DashboardPage(),
                  )),
        );
      } else {
        Fluttertoast.showToast(msg: 'Check your login details');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: BlocListener<AuthenticationBloc, AuthenticationState>(
        listener: (context, state) async {
          if (state is GoogleAuthenticateInProgress) {
            setState(() {
              isLoading = true;
            });
          } else if (state is GoogleAuthenticateFailure) {
            setState(() {
              isLoading = false;
            });
          } else if (state is GoogleAuthenticateSuccess) {
            setState(() {
              isLoading = false;
            });
            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.setBool(AppTexts.isLoggedIn, true);
            // _navigateToDashboard();
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(child: AppLogo()),
              IVerticalSpace(),
              IText(
                content: AppTexts.appName,
                textStyle: Ts.mediumStyle(context: context, size: 18.0),
              ),
              IVerticalSpace(
                height: 3,
              ),
              ITextField(
                  controller: emailController,
                  hintText: AppTexts.email,
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: const BorderSide(width: 0.9)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: const BorderSide(
                          width: 1.5, color: Color(AppColor.primaryColor))),
                  keyboardType: TextInputType.emailAddress),
              IVerticalSpace(
                height: 3,
              ),
              ITextField(
                  controller: passwordController,
                  hintText: AppTexts.password,
                  obscureText: !showPassword,
                  suffixIcon: IconButton(
                    icon: showPassword
                        ? const Icon(Icons.visibility_outlined)
                        : const Icon(Icons.visibility_off_sharp),
                    onPressed: () {
                      setState(() {
                        showPassword = !showPassword;
                      });
                    },
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: const BorderSide(width: 0.9)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: const BorderSide(
                          width: 1.5, color: Color(AppColor.primaryColor))),
                  keyboardType: TextInputType.emailAddress),
              IVerticalSpace(
                height: 3,
              ),
              isLoading
                  ? const CircularProgressIndicator(
                      color: Color(AppColor.primaryColor),
                    )
                  : IAppButton(
                      text: AppTexts.login,
                      onTap: () {
                        _navigateToDashboard();
                      },
                      backgroundColor: const Color(AppColor.primaryColor),
                      textStyle: Ts.mediumStyle(
                          context: context,
                          textColor: const Color(AppColor.white)),
                    ),
              IVerticalSpace(
                height: 3,
              ),
              IRichText(
                title: AppTexts.doNotHaveAccount,
                titleTextStyle: Ts.boldStyle(
                    context: context, textColor: const Color(AppColor.black)),
                subTitle: AppTexts.register,
                subTitleTextStyle: Ts.boldStyle(
                    context: context,
                    textColor: const Color(AppColor.darkBlue)),
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
