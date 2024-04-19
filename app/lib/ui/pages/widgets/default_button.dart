import 'package:flutter/material.dart';

class DefaultButton extends StatelessWidget {
  const DefaultButton({
    super.key,
    required this.enabled,
    required this.onPressed,
    required this.label,
    this.icon = const Icon(Icons.navigate_before_outlined),
  });

  final bool enabled;
  final String label;
  final Function() onPressed;
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 155,
            height: 50,
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: ElevatedButton.icon(
                style: const ButtonStyle(
                  shape: MaterialStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                  ),
                ),
                onPressed: enabled ? onPressed : null,
                label: Text(label),
                icon: icon,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
