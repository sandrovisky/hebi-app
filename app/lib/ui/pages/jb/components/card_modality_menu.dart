import 'package:flutter/material.dart';

class CardOptionMenu extends StatelessWidget {
  const CardOptionMenu({
    super.key,
    required this.title,
    this.subtitle,
    required this.onTap,
  });

  final String title;
  final String? subtitle;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Ink(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  fit: FlexFit.loose,
                  child: Center(
                    child: Text(
                      title,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
                subtitle == null
                    ? Container()
                    : FittedBox(
                        child: Center(
                          child: Text(
                            subtitle ?? '',
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 12),
                          ),
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
