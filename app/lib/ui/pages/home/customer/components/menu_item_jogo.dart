import 'package:flutter/material.dart';
import 'package:hebi/ui/widgets/widgets.dart';

class MenuItemJogo extends StatelessWidget {
  const MenuItemJogo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MenuItem(
      title: 'JOGO',
      svgName: 'snake_2',
      navigateTo: () => Navigator.of(context).pushNamed('/jb'),
    );
  }
}
