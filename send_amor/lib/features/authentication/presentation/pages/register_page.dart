import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:money_transfer_app/features/authentication/data/app_user.dart';
import 'package:money_transfer_app/features/authentication/data/payload/register_user_payload.dart';
import 'package:money_transfer_app/features/authentication/domain/authentication_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:country_code_picker/country_code_picker.dart';

import '../../../../common/mixins/ts.dart';
import '../../../../common/widgets/AppLogo.dart';
import '../../../../common/widgets/IAppButton.dart';
import '../../../../common/widgets/IRichText.dart';
import '../../../../common/widgets/IText.dart';
import '../../../../common/widgets/ITextField.dart';
import '../../../../common/widgets/IVerticalSpace.dart';
import '../../../../core/constants/app_texts.dart';
import '../../../../core/theme/app_color.dart';
import '../../../dashboard/presentation/pages/dashboard_page.dart';
import '../bloc/authentication_bloc/authentication_bloc.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController uniqueNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController dateOfBirthController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  AuthenticationRepository authenticationRepository = AuthenticationRepository();

  String selectedCountry = 'United States';
  String selectedCountryCode = '+1';
  bool isLoading = false;
  bool showPassword = false;

  @override
  void initState() {
    super.initState();
    _checkLoginState();
  }

  Future<void> _checkLoginState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool(AppTexts.isLoggedIn) ?? false;

    if (isLoggedIn) {
      _navigateToDashboard();
    }
  }

  void _navigateToDashboard() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const DashboardPage()),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        dateOfBirthController.text =
        "${picked.day.toString().padLeft(2, '0')}-${picked.month.toString().padLeft(2, '0')}-${picked.year}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(360, 690));
    return Padding(
      padding: const EdgeInsets.only(bottom: 25.0),
      child: Scaffold(
        appBar: AppBar(),
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
              _navigateToDashboard();
            }
          },
          child: SingleChildScrollView(
            padding: EdgeInsets.all(16.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(child: AppLogo()),
                IVerticalSpace(height: 2.h),
                IText(
                  content: AppTexts.appName,
                  textStyle: Ts.mediumStyle(context: context, size: 18.sp),
                ),
                IVerticalSpace(height: 2.h),
                ITextField(
                  controller: fullNameController,
                  hintText: AppTexts.fullName,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: BorderSide(width: 0.9.w),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: BorderSide(
                      width: 1.5.w,
                      color: Color(AppColor.primaryColor),
                    ),
                  ),
                  keyboardType: TextInputType.name,
                ),
                IVerticalSpace(height: 2.h),
                ITextField(
                  controller: uniqueNameController,
                  hintText: 'Unique Name',
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: BorderSide(width: 0.9.w),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: BorderSide(
                      width: 1.5.w,
                      color: Color(AppColor.primaryColor),
                    ),
                  ),
                  keyboardType: TextInputType.text,
                ),
                IVerticalSpace(height: 2.h),
                ITextField(
                  controller: emailController,
                  hintText: AppTexts.email,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: BorderSide(width: 0.9.w),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: BorderSide(
                      width: 1.5.w,
                      color: Color(AppColor.primaryColor),
                    ),
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),

                IVerticalSpace(height: 2.h),
                Row(
                  children: [
                    CountryCodePicker(
                      onChanged: (code) {
                        setState(() {
                          selectedCountryCode = code.dialCode ?? '+1';
                          selectedCountry = code.name ?? 'United States';
                        });
                      },
                      initialSelection: 'US',
                      favorite: ['+1', 'US'],
                      showCountryOnly: false,
                      showOnlyCountryWhenClosed: false,
                      alignLeft: false,
                      boxDecoration: BoxDecoration(
                        border: Border.all(
                          color: Color(AppColor.primaryColor),
                          width: 0.9.w,
                        ),
                      )
                    ),
                    Expanded(
                      child: ITextField(
                        controller: phoneController,
                        hintText: 'Phone Number',
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.r),
                          borderSide: BorderSide(width: 0.9.w),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.r),
                          borderSide: BorderSide(
                            width: 1.5.w,
                            color: Color(AppColor.primaryColor),
                          ),
                        ),
                        keyboardType: TextInputType.phone,
                      ),
                    ),
                  ],
                ),
                IVerticalSpace(height: 2.h),
                ITextField(
                  controller: dateOfBirthController,
                  hintText: 'Date of Birth (DD-MM-YYYY)',
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: BorderSide(width: 0.9.w),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: BorderSide(
                      width: 1.5.w,
                      color: Color(AppColor.primaryColor),
                    ),
                  ),
                  keyboardType: TextInputType.datetime,
                  onTap: () => _selectDate(context),
                ),
                IVerticalSpace(height: 2.h),
                ITextField(
                  controller: addressController,
                  hintText: 'Address',
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: BorderSide(width: 0.9.w),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: BorderSide(
                      width: 1.5.w,
                      color: Color(AppColor.primaryColor),
                    ),
                  ),
                  keyboardType: TextInputType.streetAddress,
                  maxLines: 3,
                ),
                IVerticalSpace(height: 2.h),

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
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: BorderSide(width: 0.9.w),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: BorderSide(
                      width: 1.5.w,
                      color: Color(AppColor.primaryColor),
                    ),
                  ),
                  keyboardType: TextInputType.visiblePassword,
                ),
                IVerticalSpace(height: 2.h),
                ITextField(
                  controller: confirmPasswordController,
                  hintText: AppTexts.confirmPassword,
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
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: BorderSide(width: 0.9.w),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: BorderSide(
                      width: 1.5.w,
                      color: Color(AppColor.primaryColor),
                    ),
                  ),
                  keyboardType: TextInputType.visiblePassword,
                ),
                IVerticalSpace(height: 2.h),


                isLoading
                    ? CircularProgressIndicator(
                  color: Color(AppColor.primaryColor),
                )
                    : IAppButton(
                  text: AppTexts.register,
                  onTap: () async {
                    if (fullNameController.text.isEmpty) {
                      Fluttertoast.showToast(msg: 'Enter full name');
                    } else if (uniqueNameController.text.isEmpty) {
                      Fluttertoast.showToast(msg: 'Enter unique name');
                    } else if (emailController.text.isEmpty) {
                      Fluttertoast.showToast(msg: 'Enter email address');
                    } else if (passwordController.text.isEmpty) {
                      Fluttertoast.showToast(msg: 'Enter password');
                    } else if (confirmPasswordController.text.isEmpty) {
                      Fluttertoast.showToast(msg: 'Enter confirm password');
                    } else if (phoneController.text.isEmpty) {
                      Fluttertoast.showToast(msg: 'Enter phone number');
                    } else if (dateOfBirthController.text.isEmpty) {
                      Fluttertoast.showToast(msg: 'Enter date of birth');
                    } else if (addressController.text.isEmpty) {
                      Fluttertoast.showToast(msg: 'Enter address');
                    } else if (passwordController.text !=
                        confirmPasswordController.text) {
                      Fluttertoast.showToast(msg: 'Passwords do not match');
                    } else {
                      setState(() {
                        isLoading = true;
                      });

                      RegisterUserPayload registerUserPayload =
                      RegisterUserPayload(
                        name: fullNameController.text,
                        uniqueName: uniqueNameController.text,
                        email: emailController.text,
                        password: passwordController.text,
                        role: 'ROLE_USER',
                        country: selectedCountry,
                        countryCode: selectedCountryCode,
                        phone: phoneController.text,
                        dateOfBirth: dateOfBirthController.text,
                        address: addressController.text,
                      );

                      AppUser? appUser =
                      await authenticationRepository.registerWithEmail(
                        context: context,
                        registerUserPayload: registerUserPayload,
                      );

                      setState(() {
                        isLoading = false;
                      });

                      if (appUser != null) {
                        Navigator.of(context).pop();
                        Fluttertoast.showToast(
                          msg: AppTexts.successfulRegister,
                          timeInSecForIosWeb: 3,
                        );
                      } else {
                        Fluttertoast.showToast(
                          msg: AppTexts.failureRegister,
                        );
                      }
                    }
                  },
                  backgroundColor: const Color(AppColor.primaryColor),
                  textStyle: Ts.mediumStyle(
                    context: context,
                    textColor: const Color(AppColor.white),
                  ),
                ),
                IVerticalSpace(height: 2.h),
                IRichText(
                  title: AppTexts.alreadyHaveAccount,
                  titleTextStyle: Ts.boldStyle(
                    context: context,
                    textColor: const Color(AppColor.black),
                  ),
                  subTitle: AppTexts.login,
                  subTitleTextStyle: Ts.boldStyle(
                    context: context,
                    textColor: const Color(AppColor.darkBlue),
                  ),
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}