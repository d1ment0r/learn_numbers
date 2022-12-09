import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData.light().copyWith(
  colorScheme: const ColorScheme(
    brightness: Brightness.light,
    primary: Color(0xFF3399cc),

    onPrimary: Colors.white,
    secondary: Color(0xFFF49FB6),
    background: Color(0xFFF49FB6),
    onSecondary: Color(0xFFF49FB6),
    error: Color(0xFFF49FB6),
    onBackground: Colors.red,
    onError: Color(0xFFF49FB6),
    // цвет текста AppBar
    onSurface: Colors.white60,
    // фон AppBar
    surface: Color(0xFF3399CC),
    // светлая тень  кнопки
    inverseSurface: Color(0xffffffff),
    // темная тень кнопки
    onInverseSurface: Color(0xffccd0d3),
  ),
  // textTheme: const TextTheme(
  //   bodyText1: TextStyle(
  //     color: Color(0xFF33E1Ed),
  //   ),
  //   // button: TextStyle(
  //   //   color: Color(0xFF33E1Ed),
  //   // ),
  // ),
);

ThemeData darkTheme = ThemeData.dark().copyWith();

Color lithAppColors = Colors.grey.shade100;
Color lithAppShadowTop = const Color(0xFFFFFFFF);
Color lithAppShadowBottom = const Color(0xffccd0d3);
Color lithAppTextColor = const Color(0xff333333);
// Color darkAppColors = const Color(0xffefeeee);

Color darkAppColors = const Color(0xff333333);
Color darkAppShadowTop = const Color(0xff464646);
Color darkAppShadowBottom = const Color(0xff202020);
Color darkAppTextColor = const Color(0xffccd0d3);
