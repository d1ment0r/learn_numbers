import 'package:flutter/material.dart';

// import 'colors.dart';

class AppTheme {
  static ThemeData get lightTheme {
    //1
    return ThemeData(
      //2
      primaryColor: Colors.amber.shade900,
      // backgroundColor: Colors.white60,
      // scaffoldBackgroundColor: Colors.white,
      // fontFamily: 'Montserrat', //3
      textTheme: ThemeData.light().textTheme,
      // buttonTheme: ButtonThemeData(
      //   // 4
      //   shape:
      //       RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
      //   buttonColor: CustomColors.lightPurple,
      // ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      primaryColor: Colors.grey.shade100,
      scaffoldBackgroundColor: Colors.black,
      // fontFamily: 'Montserrat',
      textTheme: ThemeData.dark().textTheme,
      // buttonTheme: ButtonThemeData(
      //   shape:
      //       RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
      //   buttonColor: CustomColors.lightPurple,
      // ),
    );
  }
}
