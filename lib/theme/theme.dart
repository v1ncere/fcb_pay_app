import 'package:flutter/material.dart';

class FlutterTheme {
  FlutterTheme({required this.context});
  final BuildContext context;

  ThemeData get light {
    return ThemeData(
      appBarTheme: AppBarTheme(
        elevation: 0,
        centerTitle: true,
        color: Theme.of(context).scaffoldBackgroundColor,
        iconTheme: const IconThemeData(color: Colors.black)
      ),
      colorScheme: ColorScheme.fromSwatch(accentColor: const Color(0xFF30DD5B)),
      snackBarTheme: const SnackBarThemeData(behavior: SnackBarBehavior.floating), switchTheme: SwitchThemeData(
      thumbColor: MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
      if (states.contains(MaterialState.disabled)) { return null; }
      if (states.contains(MaterialState.selected)) { return const Color(0xFF30DD5B); }
      return null;
      }),
      trackColor: MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
      if (states.contains(MaterialState.disabled)) { return null; }
      if (states.contains(MaterialState.selected)) { return const Color(0xFF30DD5B); }
      return null;
      }),
      ), radioTheme: RadioThemeData(
      fillColor: MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
      if (states.contains(MaterialState.disabled)) { return null; }
      if (states.contains(MaterialState.selected)) { return const Color(0xFF30DD5B); }
      return null;
      }),
      ), checkboxTheme: CheckboxThemeData(
      fillColor: MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
      if (states.contains(MaterialState.disabled)) { return null; }
      if (states.contains(MaterialState.selected)) { return const Color(0xFF30DD5B); }
      return null;
      }),
      ),
    );
  }

  ThemeData get dark {
    return ThemeData(
      appBarTheme: AppBarTheme(
        elevation: 0,
        centerTitle: true,
        color: Theme.of(context).scaffoldBackgroundColor,
        iconTheme: const IconThemeData(color: Colors.black)
      ),
      colorScheme: ColorScheme.fromSwatch(
        brightness: Brightness.dark,
        accentColor: const Color(0xFF30DD5B),
      ),
      snackBarTheme: const SnackBarThemeData(behavior: SnackBarBehavior.floating), switchTheme: SwitchThemeData(
      thumbColor: MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
      if (states.contains(MaterialState.disabled)) { return null; }
      if (states.contains(MaterialState.selected)) { return const Color(0xFF30DD5B); }
      return null;
      }),
      trackColor: MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
      if (states.contains(MaterialState.disabled)) { return null; }
      if (states.contains(MaterialState.selected)) { return const Color(0xFF30DD5B); }
      return null;
      }),
      ), radioTheme: RadioThemeData(
      fillColor: MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
      if (states.contains(MaterialState.disabled)) { return null; }
      if (states.contains(MaterialState.selected)) { return const Color(0xFF30DD5B); }
      return null;
      }),
      ), checkboxTheme: CheckboxThemeData(
      fillColor: MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
      if (states.contains(MaterialState.disabled)) { return null; }
      if (states.contains(MaterialState.selected)) { return const Color(0xFF30DD5B); }
      return null;
      }),
      ),
    );
  }
}