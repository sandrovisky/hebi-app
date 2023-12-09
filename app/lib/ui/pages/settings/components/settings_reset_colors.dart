import 'package:flutter/material.dart';

import './/core/core.dart';

class SettingsResetColors extends StatelessWidget {
  const SettingsResetColors({super.key, required this.controller});

  final ThemeController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          onTap: controller.resetTheme,
          title: const Text('Resetar cores'),
        ),
        const Divider(),
      ],
    );
  }
}
