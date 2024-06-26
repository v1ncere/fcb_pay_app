import 'package:flutter/material.dart';

import 'utils.dart';

class CustomTheme {
  static ThemeData lightThemeData(BuildContext context) {
    return ThemeData(
      useMaterial3: true,
      fontFamily: 'Montserrat',
      // textTheme: GoogleFonts.montserratTextTheme(),
      colorSchemeSeed: ColorString.eucalyptus,
      appBarTheme: AppBarTheme(
        elevation: 0,
        color: Theme.of(context).scaffoldBackgroundColor,
      ),
      scaffoldBackgroundColor: const Color(0xFFFAFAFA),
      snackBarTheme: const SnackBarThemeData(behavior: SnackBarBehavior.floating),
    );
  }

  static ThemeData darkThemeData(BuildContext context) {
    return ThemeData(
      useMaterial3: true,
      fontFamily: 'Montserrat',
      // textTheme: GoogleFonts.montserratTextTheme(),
      colorSchemeSeed: ColorString.eucalyptus,
      appBarTheme: AppBarTheme(
        elevation: 0,
        centerTitle: true,
        titleTextStyle: const TextStyle(color: Color(0xFF25C166)),
        color: Theme.of(context).scaffoldBackgroundColor,
        iconTheme: const IconThemeData(color: Color(0xFF25C166))
      ),
      scaffoldBackgroundColor: const Color(0xFFFAFAFA),
    );
  }
}