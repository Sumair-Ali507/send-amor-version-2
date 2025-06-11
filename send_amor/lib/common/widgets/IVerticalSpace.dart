import 'package:flutter/material.dart';
import '../../core/config/SizeConfig.dart';

class IVerticalSpace extends StatelessWidget {
  double? height;
  IVerticalSpace({super.key, this.height = 1});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SizedBox(height: SizeConfig.safeBlockVertical * height!);
  }
}
