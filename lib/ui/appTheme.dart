import 'package:flutter/material.dart';

var lightAppColors = LightThemeColors();
var darkAppColors = DarkThemeColors();

class AppTheme {
  AppTheme._();

  static final ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: Color(0xffF3F3F3),
    appBarTheme: AppBarTheme(
      color: Color(0xffF3F3F3),
      iconTheme: IconThemeData(
        color: lightAppColors.text,
      ),
    ),
    brightness: Brightness.light,
    buttonTheme: ButtonThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(6.0),
          ),
        ),
        padding: EdgeInsets.symmetric(vertical: 15),
        textTheme: ButtonTextTheme.primary),
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: TextStyle(color: lightAppColors.text),
    ),
    backgroundColor: Color(0xffFFFFFF),
    colorScheme: ColorScheme.light(
        primary: Color(0xff5468f7),
        onPrimary: Colors.white,
        primaryVariant: Color(0xff354355),
        secondary: Colors.red,
        surface: Color(0xffFFFFFF)),
    cardTheme: CardTheme(
      color: Color(0xFFFFFFFF),
      elevation: 3.0,
      margin: EdgeInsets.all(20.0),
    ),
    iconTheme: IconThemeData(
      color: Colors.black,
    ),
    textTheme: TextTheme(
      button: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 16.0,
      ),
      headline4: TextStyle(
        color: lightAppColors.text,
        fontWeight: FontWeight.bold,
        fontSize: 28.0,
      ),
      headline5: TextStyle(
        color: lightAppColors.text,
        fontWeight: FontWeight.bold,
        fontSize: 22.0,
      ),
      headline6: TextStyle(
        color: lightAppColors.text,
        fontWeight: FontWeight.bold,
        fontSize: 19.0,
      ),
      subtitle2: TextStyle(
        color: lightAppColors.text,
        fontSize: 18.0,
      ),
      subtitle1: TextStyle(
        color: lightAppColors.text,
        fontWeight: FontWeight.bold,
        fontSize: 16.0,
      ),
      bodyText1: TextStyle(
        color: lightAppColors.textSecondary,
        height: 1.4,
        fontSize: 16.0,
      ),
      bodyText2: TextStyle(
        color: lightAppColors.text,
        height: 1.4,
        fontSize: 14.0,
      ),
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: Color(0xFF1c1f27),
    primaryColor: Color(0xFF49f2dd),
    accentColor: Color(0xFF49f2dd),
    appBarTheme: AppBarTheme(
      color: Color(0xFF34393e),
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
    ),
    buttonTheme: ButtonThemeData(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(6.0))),
        padding: EdgeInsets.symmetric(vertical: 15),
        textTheme: ButtonTextTheme.primary),
    inputDecorationTheme:
        InputDecorationTheme(hintStyle: TextStyle(color: Colors.white)),
    backgroundColor: Color(0xFF1c1f27),
    colorScheme: ColorScheme.light(
        primary: Color(0xFF49f2dd),
        onPrimary: Colors.white,
        primaryVariant: Color(0xff354355),
        secondary: Color(0xFFb28dff),
        onSurface: Colors.grey[400],
        surface: Color(0xFF272a2f)),
    cardTheme: CardTheme(
        color: Color(0xFF373841),
        elevation: 10.0,
        margin: EdgeInsets.all(20.0)),
    iconTheme: IconThemeData(
      color: Colors.white,
    ),
    textTheme: TextTheme(
      button: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 16.0,
      ),
      headline4: TextStyle(
        color: darkAppColors.text,
        fontWeight: FontWeight.bold,
        fontSize: 28.0,
      ),
      headline5: TextStyle(
        color: darkAppColors.text,
        fontWeight: FontWeight.bold,
        fontSize: 22.0,
      ),
      headline6: TextStyle(
        color: Colors.white,
        fontSize: 16.0,
      ),
      subtitle2: TextStyle(
        color: darkAppColors.text,
        fontSize: 18.0,
      ),
      subtitle1: TextStyle(
        color: darkAppColors.text,
        fontSize: 18.0,
      ),
      bodyText1: TextStyle(
        color: darkAppColors.textSecondary,
        height: 1.4,
        fontSize: 16.0,
      ),
      bodyText2: TextStyle(
        color: darkAppColors.text,
        height: 1.4,
        fontSize: 14.0,
      ),
    ),
  );
}

// Unique theme colours
class LightThemeColors {
  /*late*/ Color text;
  /*late*/ Color textSecondary;

  LightThemeColors() {
    text = Color(0xff000000);
    textSecondary = Color(0xff000000);
  }
}

class DarkThemeColors {
  /*late*/ Color text;
  /*late*/ Color textSecondary;

  DarkThemeColors() {
    text = Colors.white;
    textSecondary = Colors.white60;
  }
}
