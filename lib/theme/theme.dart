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
      snackBarTheme: const SnackBarThemeData(behavior: SnackBarBehavior.floating),
      toggleableActiveColor: const Color(0xFF30DD5B),
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
      snackBarTheme: const SnackBarThemeData(behavior: SnackBarBehavior.floating),
      toggleableActiveColor: const Color(0xFF30DD5B),
    );
  }
}