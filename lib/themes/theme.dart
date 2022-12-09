import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData.light().copyWith(
  scaffoldBackgroundColor: lithAppColors,
  colorScheme: const ColorScheme.light(
    brightness: Brightness.light,
    primary: Color(0xFF3399cc),

    onPrimary: Colors.white,
    // цвет текста AppBar
    onSurface: Colors.white60,
    // фон AppBar
    surface: Color(0xFF3399CC),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: Color(0xFF006a9b),
    selectedItemColor: Colors.white70,
    unselectedItemColor: Colors.black87,
  ),
  dividerTheme: const DividerThemeData(
    color: Color(0xFF3399CC),
  ),
);

Color lithAppColors = Colors.grey.shade100;
// Color lithAppColors = const Color(0xFF70c9ff);
Color lithAppShadowTop = const Color(0xFFFFFFFF);
Color lithAppShadowBottom = const Color(0xffccd0d3);
Color lithAppTextColor = const Color(0xff333333);
// Color darkAppColors = const Color(0xffefeeee);

ThemeData darkTheme = ThemeData(
  appBarTheme: AppBarTheme(
    backgroundColor: const Color(0xFF424242),
    iconTheme: const IconThemeData(color: Colors.white70),
    elevation: 5.0,
    shadowColor: darkAppColors,
  ),
  scaffoldBackgroundColor: darkAppColors,
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: Color(0xFF1b1b1b),
    selectedItemColor: Colors.white70,
    unselectedItemColor: Colors.white38,
  ),
  colorScheme: const ColorScheme.dark(
    brightness: Brightness.dark,
    // цвет текста AppBar
    onSurface: Colors.white70,
  ),
  dividerTheme: const DividerThemeData(color: Colors.white60),
);

Color darkAppColors = const Color(0xFF6d6d6d);
Color darkAppShadowTop = const Color.fromARGB(255, 122, 122, 122);
Color darkAppShadowBottom = const Color.fromARGB(255, 66, 66, 66);
Color darkAppTextColor = const Color(0xffccd0d3);
