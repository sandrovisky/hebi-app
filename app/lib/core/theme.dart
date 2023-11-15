import 'package:flutter/material.dart';

class HebiTheme {
  final Color primaryFontColor;
  final Color secondaryFontColor;
  final Color backgroundColor;
  final Color headerColor;
  final Color buttonColor;
  late ThemeData theme;

  HebiTheme({
    this.primaryFontColor = Colors.amber,
    this.secondaryFontColor = Colors.green,
    this.backgroundColor = Colors.indigo,
    this.headerColor = Colors.lime,
    this.buttonColor = Colors.grey,
  }) {
    theme = ThemeData();
  }

  HebiTheme copyWith({
    Color? primaryFontColor,
    Color? secondaryFontColor,
    Color? backgroundColor,
    Color? headerColor,
    Color? buttonColor,
  }) {
    return HebiTheme(
      primaryFontColor: primaryFontColor ?? this.primaryFontColor,
      secondaryFontColor: secondaryFontColor ?? this.secondaryFontColor,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      headerColor: headerColor ?? this.headerColor,
      buttonColor: buttonColor ?? this.buttonColor,
    );
  }
}
