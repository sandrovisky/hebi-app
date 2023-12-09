import 'package:flutter/material.dart';

import './/core/core.dart';

import './components.dart';

class SettingsButtonColor extends StatelessWidget {
  const SettingsButtonColor({
    super.key,
    required this.controller,
  });

  final ThemeController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SettingsChangeColorListTile(
          saveColor: controller.changeButtonColor,
          title: 'Selecionar cor dos botões',
          color: controller.buttonColor,
        ),
        const Divider(),
      ],
    );
  }
}
