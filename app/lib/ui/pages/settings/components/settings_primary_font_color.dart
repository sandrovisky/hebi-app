import 'package:flutter/material.dart';

import './/core/core.dart';

import './components.dart';

class SettingsPrimaryFontColor extends StatelessWidget {
  const SettingsPrimaryFontColor({super.key, required this.controller});

  final ThemeController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Divider(),
        SettingsChangeColorListTile(
          saveColor: controller.changePrimaryFontColor,
          title: 'Selecionar cor primaria para fonte',
          color: controller.primaryFontColor,
        ),
        const Divider(),
      ],
    );
  }
}
