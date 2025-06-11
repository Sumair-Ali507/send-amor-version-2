import 'package:flutter/material.dart';
import '../../core/config/SizeConfig.dart';

class IHorizontalSpace extends StatelessWidget {
  double? width;
  IHorizontalSpace({super.key, this.width = 1});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SizedBox(width: SizeConfig.safeBlockVertical * width!);
  }
}
