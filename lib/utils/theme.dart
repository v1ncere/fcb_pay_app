import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FlutterTheme {
  FlutterTheme({required this.context});
  final BuildContext context;

  ThemeData get light {
    return ThemeData(
      // textTheme: GoogleFonts.nunitoTextTheme(),
      textTheme: GoogleFonts.montserratTextTheme(),
      appBarTheme: AppBarTheme(
        elevation: 0,
        centerTitle: true,
        titleTextStyle: const TextStyle(color: Color(0xFF25C166)),
        color: Theme.of(context).scaffoldBackgroundColor,
        iconTheme: const IconThemeData(color: Color(0xFF25C166))
      ),
      scaffoldBackgroundColor: const Color(0xFFFAFAFA),
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
          if (states.contains(MaterialState.selected)) { return const Color(0xFF25C166); }
          return null;
        }),
        trackColor: MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
          if (states.contains(MaterialState.disabled)) { return null; }
          if (states.contains(MaterialState.selected)) { return const Color(0xFF25C166); }
          return null;
        })
      ),
      radioTheme: RadioThemeData(
        fillColor: MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
          if (states.contains(MaterialState.disabled)) { return null; }
          if (states.contains(MaterialState.selected)) { return const Color(0xFF25C166); }
          return null;
        })
      ),
      checkboxTheme: CheckboxThemeData(
        fillColor: MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
          if (states.contains(MaterialState.disabled)) { return null; }
          if (states.contains(MaterialState.selected)) { return const Color(0xFF25C166); }
          return null;
        })
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith<Color?>((state) {
            if (state.contains(MaterialState.disabled)) return Colors.green[200]; // Disabled button color
            return const Color(0xFF25C166); // Enabled button color
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
            return const Color(0xFF25C166); // Enabled text color
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
        accentColor: const Color(0xFF25C166),
      ),
      snackBarTheme: const SnackBarThemeData(behavior: SnackBarBehavior.floating),
      switchTheme: SwitchThemeData(
        thumbColor: MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
          if (states.contains(MaterialState.disabled)) { return null; }
          if (states.contains(MaterialState.selected)) { return const Color(0xFF25C166); }
          return null;
        }),
        trackColor: MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
          if (states.contains(MaterialState.disabled)) { return null; }
          if (states.contains(MaterialState.selected)) { const Color(0xFF25C166); }
          return null;
        }),
      ), 
      radioTheme: RadioThemeData(
        fillColor: MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
          if (states.contains(MaterialState.disabled)) { return null; }
          if (states.contains(MaterialState.selected)) { return const Color(0xFF25C166); }
          return null;
        }),
      ),
      checkboxTheme: CheckboxThemeData(
        fillColor: MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
          if (states.contains(MaterialState.disabled)) { return null; }
          if (states.contains(MaterialState.selected)) { return const Color(0xFF25C166); }
          return null;
        }),
      ),
    );
  }
}