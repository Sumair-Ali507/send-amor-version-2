import 'package:flutter/material.dart';
import '../../core/constants/app_images.dart';



class AppLogo extends StatelessWidget {
  double? width;
  double? height;
  AppLogo({super.key, this.height = 80, this.width = 80});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      AppImages().appLogoPng,
      width: width,
      height: height,
    );
  }
}
