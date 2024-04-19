import 'package:flutter/material.dart';

class ShiftsContinueButton extends StatelessWidget {
  const ShiftsContinueButton({
    super.key,
    required this.hasSelectedShift,
    required this.onPressed,
  });

  final bool hasSelectedShift;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 140,
            height: 50,
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: ElevatedButton.icon(
                onPressed: hasSelectedShift ? onPressed : null,
                label: const Text('Continuar'),
                icon: const Icon(Icons.navigate_before_outlined),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
