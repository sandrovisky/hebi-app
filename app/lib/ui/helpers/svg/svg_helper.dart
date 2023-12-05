import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SvgService {
  static Widget fromAsset(String name, BuildContext context,
      {double height = 40, double width = 40}) {
    return SvgPicture.asset(
      'assets/vectors/$name.svg',
      height: height,
      width: width,
      colorFilter: ColorFilter.mode(
        Theme.of(context).brightness == Brightness.dark
            ? Colors.white
            : Theme.of(context).textTheme.bodyLarge!.color!,
        BlendMode.srcIn,
      ),
      fit: BoxFit.fitHeight,
    );
  }
}
