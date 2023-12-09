import 'package:flutter/material.dart';

import './/core/core.dart';

import './components.dart';

class SettingsBackgroundColor extends StatelessWidget {
  const SettingsBackgroundColor({super.key, required this.controller});

  final ThemeController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SettingsChangeColorListTile(
          saveColor: controller.changeBackgroundColor,
          title: 'Selecionar cor de fundo',
          color: controller.backgroundColor,
        ),
        const Divider(),
      ],
    );
  }
}
