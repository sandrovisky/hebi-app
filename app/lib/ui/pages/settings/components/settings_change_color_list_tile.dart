import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';

class SettingsChangeColorListTile extends StatelessWidget {
  const SettingsChangeColorListTile({
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
