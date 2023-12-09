import 'package:flutter/material.dart';

import './/core/core.dart';

import './components.dart';

class SettingsHeaderColor extends StatelessWidget {
  const SettingsHeaderColor({super.key, required this.controller});

  final ThemeController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SettingsChangeColorListTile(
          saveColor: controller.changeHeaderColor,
          title: 'Selecionar cor dos cabeçalho',
          color: controller.headerColor,
        ),
        const Divider(),
      ],
    );
  }
}
