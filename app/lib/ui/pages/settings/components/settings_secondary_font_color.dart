import 'package:flutter/material.dart';

import './/core/core.dart';

import './components.dart';

class SettingsSecondaryFontColor extends StatelessWidget {
  const SettingsSecondaryFontColor({super.key, required this.controller});

  final ThemeController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SettingsChangeColorListTile(
          saveColor: controller.changeSecondaryFontColor,
          title: 'Selecionar cor secundaria para fonte',
          color: controller.secondaryFontColor,
        ),
        const Divider(),
      ],
    );
  }
}
