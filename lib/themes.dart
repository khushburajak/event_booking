import 'package:flutter/material.dart';

class MyThemes {
  static const primary = Color.fromARGB(255, 57, 99, 240);
  static const primaryColor = Color.fromARGB(255, 42, 115, 240);

  static final darkTheme = ThemeData(
    scaffoldBackgroundColor: const Color.fromARGB(255, 8, 16, 45),
    primaryColorDark: primaryColor,
    colorScheme: const ColorScheme.dark(primary: primary),
    dividerColor: Colors.white,
  );

  static final lightTheme = ThemeData(
    // scaffoldBackgroundColor in #FFFFFF
    scaffoldBackgroundColor: const Color.fromARGB(235, 255, 255, 255),

    // scaffoldBackgroundColor: const Color.fromARGB(255, 235, 221, 255),
    primaryColor: primaryColor,
    colorScheme: const ColorScheme.light(primary: primary),
    dividerColor: const Color.fromARGB(255, 8, 16, 45),
  );
}
