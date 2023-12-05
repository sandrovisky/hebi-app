import 'package:flutter/material.dart';

import './/ui/helpers/svg/svg.dart';

class MenuItem extends StatelessWidget {
  const MenuItem({
    Key? key,
    required this.title,
    required this.svgName,
    this.height = 42,
    this.width = 42,
    this.navigateTo,
  }) : super(key: key);

  final String title;
  final String svgName;
  final double height;
  final double width;
  final void Function()? navigateTo;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: SizedBox(
        height: 75,
        child: Ink(
          child: Card(
            child: InkWell(
              borderRadius: BorderRadius.circular(8),
              onTap: navigateTo ?? () {},
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(title),
                    SvgService.fromAsset(
                      svgName,
                      context,
                      height: height,
                      width: width,
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
