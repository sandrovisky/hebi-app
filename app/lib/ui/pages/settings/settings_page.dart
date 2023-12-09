import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import './/core/core.dart';
import './components/components.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<ThemeController>();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Configurações'),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
        children: <Widget>[
          SettingsDarkTheme(controller: controller),
          if (!controller.isDarkTheme) ...[
            SettingsPrimaryFontColor(controller: controller),
            SettingsSecondaryFontColor(controller: controller),
            SettingsBackgroundColor(controller: controller),
            SettingsHeaderColor(controller: controller),
            SettingsButtonColor(controller: controller),
            SettingsResetColors(controller: controller),
          ]
        ],
      ),
    );
  }
}
