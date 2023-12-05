import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import './/core/core.dart';

class ConfigPage extends StatelessWidget {
  const ConfigPage({super.key});

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
          const SizedBox(height: 5),
          const Divider(),
          SwitchListTile(
            title: const Text('Dark Mode'),
            value: controller.isDarkTheme,
            onChanged: controller.changeDarkTheme,
          ),
          if (!controller.isDarkTheme) ...[
            const Divider(),
            ChangeColorListTile(
              saveColor: controller.changePrimaryFontColor,
              title: 'Selecionar cor primaria para fonte',
              color: controller.primaryFontColor,
            ),
            const Divider(),
            ChangeColorListTile(
              saveColor: controller.changeSecondaryFontColor,
              title: 'Selecionar cor secundaria para fonte',
              color: controller.secondaryFontColor,
            ),
            const Divider(),
            ChangeColorListTile(
              saveColor: controller.changeBackgroundColor,
              title: 'Selecionar cor de fundo',
              color: controller.backgroundColor,
            ),
            const Divider(),
            ChangeColorListTile(
              saveColor: controller.changeHeaderColor,
              title: 'Selecionar cor dos cabeçalho',
              color: controller.headerColor,
            ),
            const Divider(),
            ChangeColorListTile(
              saveColor: controller.changeButtonColor,
              title: 'Selecionar cor dos botões',
              color: controller.buttonColor,
            ),
            const Divider(),
            ListTile(
              onTap: controller.resetTheme,
              title: const Text('Resetar cores'),
            ),
            const Divider(),
          ]
        ],
      ),
    );
  }
}

class ChangeColorListTile extends StatelessWidget {
  const ChangeColorListTile({
    super.key,
    required this.saveColor,
    required this.title,
    required this.color,
  });

  final Function(Color) saveColor;
  final String title;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      trailing: ColorIndicator(
        isSelected: false,
        width: 44,
        height: 44,
        borderRadius: 4,
        color: color,
        elevation: 4,
        onSelectFocus: false,
        onSelect: () async {
          final newColor = await colorPickerDialog(context, color);
          await saveColor(newColor);
        },
      ),
    );
  }

  Future<Color> colorPickerDialog(BuildContext context, Color color) async {
    return await showColorPickerDialog(
      context,
      color,
      actionsPadding: const EdgeInsets.all(16),
      width: 50,
      height: 50,
      borderRadius: 50,
      heading: const Text('Selecione uma cor'),
      subheading: const Text('Variações'),
      wheelSubheading: const Text('Selecione uma cor'),
      pickersEnabled: const <ColorPickerType, bool>{
        ColorPickerType.both: false,
        ColorPickerType.primary: true,
        ColorPickerType.accent: true,
        ColorPickerType.bw: false,
        ColorPickerType.custom: false,
        ColorPickerType.wheel: true,
      },
      enableOpacity: false,
      transitionDuration: const Duration(milliseconds: 500),
      transitionBuilder: (context, a1, a2, widget) {
        final curvedValue = Curves.easeInOutBack.transform(a1.value) - 1.0;
        return Transform(
          transform: Matrix4.translationValues(0.0, curvedValue * 200, 0.0),
          child: Opacity(
            opacity: a1.value,
            child: widget,
          ),
        );
      },
    );
  }
}
