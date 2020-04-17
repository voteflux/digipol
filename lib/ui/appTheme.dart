import 'package:flutter/material.dart';


var appColors = LightThemeColors();


class AppTheme {
  AppTheme._();

  static final ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: Color(0xffFFFFFF),
    appBarTheme: AppBarTheme(
      color: Color(0xffFFFFFF),
      iconTheme: IconThemeData(
        color: appColors.text,
      ),
    ),
    backgroundColor: Color(0xffFFFFFF),
    colorScheme: ColorScheme.light(
      primary: Color(0xff4D5CD0),
      onPrimary: Colors.white,
      primaryVariant:  Color(0xffBFD9FF),
      secondary: Colors.red,
      surface: Color(0xffF3F3F3)
    ),
    cardTheme: CardTheme(
      color: Color(0xFFF3F3F3),
      elevation: 2.0,
      margin: EdgeInsets.all(20.0)
    ),
    iconTheme: IconThemeData(
      color: Colors.white54,
    ),
    textTheme: TextTheme(
      headline4: TextStyle(
        color: appColors.text,
        fontSize: 28.0,
      ),
      headline5: TextStyle(
        color: appColors.text,
        fontWeight: FontWeight.bold,
        fontSize: 22.0,
      ),
      headline6: TextStyle(
        color: appColors.text,
        fontWeight: FontWeight.bold,
        fontSize: 20.0,
      ),
      subtitle2: TextStyle(
        color: appColors.text,
        fontSize: 18.0,
      ),
      subtitle1: TextStyle(
        color: appColors.text,
        fontSize: 18.0,
      ),
      bodyText1: TextStyle(
        color: appColors.textSecondary,
        fontSize: 16.0,
      ),
      bodyText2: TextStyle(
        color: appColors.text,
        fontSize: 14.0,
      ),
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: Colors.black,
    appBarTheme: AppBarTheme(
      color: Colors.black,
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
    ),
    colorScheme: ColorScheme.light(
      primary: Colors.black,
      onPrimary: Colors.black,
      primaryVariant: Colors.black,
      secondary: Colors.red,
    ),
    cardTheme: CardTheme(color: Colors.black, elevation: 2.0),
    iconTheme: IconThemeData(
      color: Colors.white54,
    ),
    textTheme: TextTheme(
      headline6: TextStyle(
        color: Colors.white,
        fontSize: 20.0,
      ),
      subtitle2: TextStyle(
        color: Colors.white70,
        fontSize: 18.0,
      ),
    ),
  );
}


// Unique theme colours
class LightThemeColors {

  Color text;
  Color textSecondary;

  LightThemeColors() {
      text = Color(0xff797979);
      textSecondary = Color(0xffA4A4A4);
  }
}