import 'package:flutter/material.dart';
import 'package:hebi/data/cache/cache.dart';

const defaultInput = InputDecorationTheme(
  border: OutlineInputBorder(),
  contentPadding: EdgeInsets.fromLTRB(20, 0, 10, 0),
  filled: true,
);

const cardDarkTheme = CardTheme(
  shadowColor: Colors.white,
  shape: RoundedRectangleBorder(
    side: BorderSide(color: Colors.white, width: 0.25),
    borderRadius: BorderRadius.all(Radius.circular(10)),
  ),
);

final thumbIcon = MaterialStateProperty.resolveWith<Icon?>(
  (Set<MaterialState> states) {
    if (states.contains(MaterialState.selected)) {
      return const Icon(Icons.check);
    }
    return const Icon(Icons.close);
  },
);

class ThemeController extends ValueNotifier<HebiTheme> {
  final ICacheStorage storage;

  ThemeController({required this.storage}) : super(HebiTheme.initial()) {
    _darkTheme = ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      inputDecorationTheme: defaultInput,
      cardTheme: cardDarkTheme,
      appBarTheme: const AppBarTheme(shadowColor: Colors.white),
      switchTheme: SwitchThemeData(
        thumbIcon: thumbIcon,
        thumbColor: MaterialStateProperty.resolveWith<Color?>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.selected)) {
              return Colors.green;
            }

            return Colors.red;
          },
        ),
        trackColor: MaterialStateProperty.resolveWith<Color?>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.selected)) {
              return Color.fromARGB(255, 28, 87, 10);
            }

            return const Color.fromARGB(255, 95, 19, 12);
          },
        ),
      ),
    );

    _lightTheme = ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      inputDecorationTheme: defaultInput,
      switchTheme: SwitchThemeData(
        thumbIcon: thumbIcon,
        thumbColor: MaterialStateProperty.resolveWith<Color?>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.selected)) {
              return const Color.fromARGB(255, 104, 219, 108);
            }

            return Colors.red;
          },
        ),
        trackColor: MaterialStateProperty.resolveWith<Color?>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.selected)) {
              return Color.fromARGB(255, 29, 104, 41);
            }

            return Color.fromARGB(255, 128, 26, 16);
          },
        ),
      ),
    );

    _customTheme = _lightTheme;
  }

  Color primaryFontColor = Colors.black;
  Color secondaryFontColor = Colors.black;
  Color backgroundColor = Colors.white;
  Color headerColor = Colors.white;
  Color buttonColor = Colors.white;

  bool _isDarkTheme = false;

  late ThemeData _darkTheme;

  late ThemeData _lightTheme;

  late ThemeData _customTheme;

  bool get isDarkTheme => _isDarkTheme;

  Future<void> init() async {
    final map = await storage.fetch('colorsTheme');
    if (map != null) {
      primaryFontColor = Color(map['primaryFontColor']);
      secondaryFontColor = Color(map['secondaryFontColor']);
      backgroundColor = Color(map['backgroundColor']);
      headerColor = Color(map['headerColor']);
      buttonColor = Color(map['buttonColor']);
      _isDarkTheme = map['isDarktheme'];

      _buildTheme();
    }
  }

  Future<void> resetTheme() async {
    await storage.delete('colorsTheme');
    primaryFontColor = Colors.black;
    secondaryFontColor = Colors.black;
    backgroundColor = Colors.white;
    headerColor = Colors.white;
    buttonColor = Colors.white;
    _customTheme = _lightTheme;
    _buildTheme();
  }

  Future<void> changeDarkTheme(bool isdark) async {
    _isDarkTheme = isdark;
    await _saveInCache();
  }

  Future<void> changePrimaryFontColor(Color color) async {
    primaryFontColor = color;
    await _saveInCache();
    _buildTheme();
  }

  Future<void> changeSecondaryFontColor(Color color) async {
    secondaryFontColor = color;
    await _saveInCache();
    _buildTheme();
  }

  Future<void> changeBackgroundColor(Color color) async {
    backgroundColor = color;
    await _saveInCache();
    _buildTheme();
  }

  Future<void> changeHeaderColor(Color color) async {
    headerColor = color;
    await _saveInCache();
    _buildTheme();
  }

  Future<void> changeButtonColor(Color color) async {
    buttonColor = color;
    await _saveInCache();
    _buildTheme();
  }

  Future<void> _saveInCache() async {
    await storage.save(key: 'colorsTheme', value: toMap());

    _buildTheme();
  }

  void _buildTheme() {
    _changeThemePrimaryFont();
    _changeThemeSecondaryFont();
    _changeThemeBackground();
    _changeThemeHeader();
    _changeThemeButton();

    if (_isDarkTheme) {
      value = HebiTheme(theme: _darkTheme, themeMode: ThemeMode.dark);
    } else {
      value = HebiTheme(theme: _customTheme, themeMode: ThemeMode.light);
    }
  }

  void _changeThemePrimaryFont() {
    final textStyle = TextStyle(color: primaryFontColor, fontSize: 16);
    _customTheme = _customTheme.copyWith(
      textTheme: TextTheme(
        bodyLarge: textStyle.copyWith(fontSize: 18),
        bodyMedium: textStyle,
        bodySmall: textStyle,
        displayLarge: textStyle,
        displayMedium: textStyle,
        displaySmall: textStyle,
        headlineLarge: textStyle,
        headlineMedium: textStyle,
        headlineSmall: textStyle,
        labelLarge: textStyle,
        labelMedium: textStyle,
        labelSmall: textStyle,
        titleLarge: textStyle,
        titleMedium: textStyle,
        titleSmall: textStyle,
      ),
      listTileTheme: ListTileThemeData(
        titleTextStyle: textStyle.copyWith(inherit: false),
      ),
      appBarTheme: AppBarTheme(
        titleTextStyle: TextStyle(color: primaryFontColor, fontSize: 24),
        iconTheme: IconThemeData(color: primaryFontColor),
      ),
    );
  }

  void _changeThemeSecondaryFont() {
    final textStyle = TextStyle(color: secondaryFontColor);
    _customTheme = _customTheme.copyWith(
      inputDecorationTheme: _customTheme.inputDecorationTheme.copyWith(
        hintStyle: textStyle,
        errorStyle: textStyle,
      ),
    );
  }

  void _changeThemeBackground() {
    _customTheme = _customTheme.copyWith(
      scaffoldBackgroundColor: backgroundColor,
    );
  }

  void _changeThemeHeader() {
    _customTheme = _customTheme.copyWith(
      listTileTheme: ListTileThemeData(
          tileColor: headerColor,
          shape: ContinuousRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)))),
      appBarTheme: _customTheme.appBarTheme.copyWith(
        backgroundColor: headerColor,
      ),
    );
  }

  void _changeThemeButton() {
    _customTheme = _customTheme.copyWith(
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) {
            if (states.contains(MaterialState.disabled)) {
              return Colors.grey;
            }
            return buttonColor;
          }),
          foregroundColor: MaterialStateProperty.all<Color>(secondaryFontColor),
        ),
      ),
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'primaryFontColor': primaryFontColor.value,
      'secondaryFontColor': secondaryFontColor.value,
      'backgroundColor': backgroundColor.value,
      'headerColor': headerColor.value,
      'buttonColor': buttonColor.value,
      'isDarktheme': _isDarkTheme,
    };
  }
}

class HebiTheme {
  final ThemeData theme;
  final ThemeMode themeMode;

  HebiTheme({required this.theme, required this.themeMode});

  factory HebiTheme.initial() => HebiTheme(
        theme: ThemeData(
          useMaterial3: true,
          brightness: Brightness.light,
          inputDecorationTheme: const InputDecorationTheme(
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.fromLTRB(20, 0, 10, 0),
            filled: true,
          ),
          switchTheme: SwitchThemeData(
            thumbIcon: thumbIcon,
          ),
        ),
        themeMode: ThemeMode.light,
      );
}
