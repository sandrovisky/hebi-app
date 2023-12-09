import 'package:flutter/material.dart';

import './/core/core.dart';

class SettingsDarkTheme extends StatelessWidget {
  const SettingsDarkTheme({super.key, required this.controller});

  final ThemeController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 5),
        const Divider(),
        SwitchListTile(
          title: const Text('Dark Mode'),
          value: controller.isDarkTheme,
          onChanged: controller.changeDarkTheme,
        ),
      ],
    );
  }
}
