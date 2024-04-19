import 'package:flutter/material.dart';

import './/domain/entities/entities.dart';

class ShiftCard extends StatelessWidget {
  const ShiftCard({
    super.key,
    required this.shift,
    required this.onChanged,
  });

  final ShiftEntity shift;
  final Function(bool) onChanged;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: SwitchListTile(
        title: Text('${shift.number} - ${shift.abbr}'),
        value: shift.isSelected,
        onChanged: onChanged,
      ),
    );
  }
}
