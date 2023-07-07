import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FlutterTheme {
  FlutterTheme({required this.context});
  final BuildContext context;

  ThemeData get light {
    return ThemeData(
      textTheme: GoogleFonts.openSansTextTheme(),
      appBarTheme: AppBarTheme(
        elevation: 0,
        centerTitle: true,
        color: Theme.of(context).scaffoldBackgroundColor,
        iconTheme: const IconThemeData(color: Colors.green)
      ),
      colorScheme: ColorScheme.fromSwatch(
        brightness: Brightness.light,
        accentColor: Colors.greenAccent,
        primarySwatch: Colors.green
      ),
      snackBarTheme: const SnackBarThemeData(
        behavior: SnackBarBehavior.floating
      ),
      switchTheme: SwitchThemeData(
        thumbColor: MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
          if (states.contains(MaterialState.disabled)) { return null; }
          if (states.contains(MaterialState.selected)) { return const Color(0xFF30DD5B); }
          return null;
        }),
        trackColor: MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
          if (states.contains(MaterialState.disabled)) { return null; }
          if (states.contains(MaterialState.selected)) { return const Color(0xFF30DD5B); }
          return null;
        })
      ),
      radioTheme: RadioThemeData(
        fillColor: MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
          if (states.contains(MaterialState.disabled)) { return null; }
          if (states.contains(MaterialState.selected)) { return const Color(0xFF30DD5B); }
          return null;
        })
      ),
      checkboxTheme: CheckboxThemeData(
        fillColor: MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
          if (states.contains(MaterialState.disabled)) { return null; }
          if (states.contains(MaterialState.selected)) { return const Color(0xFF30DD5B); }
          return null;
        })
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith<Color?>((state) {
            if (state.contains(MaterialState.disabled)) return Colors.green[200]; // Disabled button color
            return Colors.green; // Enabled button color
          }),
          foregroundColor: MaterialStateProperty.resolveWith<Color?>((state) {
            if (state.contains(MaterialState.disabled)) return Colors.white54; // Disabled text color
            return Colors.white; // Enabled text color
          })
        )
      ),
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.resolveWith<Color?>((state) {
            if (state.contains(MaterialState.disabled)) return Colors.black54; // Disabled text color
            return Colors.green; // Enabled text color
          })
        )
      )
    );
  }

  ThemeData get dark {
    return ThemeData(
      textTheme: GoogleFonts.openSansTextTheme(),
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
      switchTheme: SwitchThemeData(
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
      ), 
      radioTheme: RadioThemeData(
        fillColor: MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
          if (states.contains(MaterialState.disabled)) { return null; }
          if (states.contains(MaterialState.selected)) { return const Color(0xFF30DD5B); }
          return null;
        }),
      ),
      checkboxTheme: CheckboxThemeData(
        fillColor: MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
          if (states.contains(MaterialState.disabled)) { return null; }
          if (states.contains(MaterialState.selected)) { return const Color(0xFF30DD5B); }
          return null;
        }),
      ),
    );
  }
}