import 'package:flutter/material.dart';

// This file contains universal styles for the app
// to help create a sense of consistency throwout the app
// eg the theme colours here - have a mess around... - kc

/// object containing the colors for the app
///
/// eg usage for the text color:
///
/// `color: appColors.text`
var appColors = AppColors(0);

/// object containing the standard sized for the app
///
/// eg usage for a the card corner:
///
/// `borderRadius: BorderRadius.circular(appSizes.cardCornerRadius)`
var appSizes = AppSizes();

/// object containing the standard text styles for the app
///
/// eg usage for a heading:
///
/// `Text("Heading", style: appTextStyles.heading,textAlign: TextAlign.center,)`
var appTextStyles = AppTextStyles();

// Classes below

class AppColors {
  Color house;
  Color senate;
  Color greyedOut;
  Color background;
  Color backgroundSecondary;
  Color mainTheme;
  Color issues;
  Color text;
  Color shareIcon;
  Color voteOpen;
  Color voteClosed;
  Color voted;
  Color card;
  Color cardInkWell;
  Color yes;
  Color no;
  Color selected;
  Color unSelected;
  Color button;
  Color buttonOutline;

  AppColors(int styleNum) {
    /// The colors for the app

    if (styleNum == 0) {
      // Dark mode
      house = Color(0xFF0f4533);
      senate = Color(0xFFa81717);
      greyedOut = Colors.grey[800];
      background = Color(0xFF16171b);
      backgroundSecondary = Color(0xFF202125);
      mainTheme = Color(0xFFE0E6E9);
      issues = Color(0xFF363663);
      text = Color(0xFF99aab5);
      shareIcon = Color(0xFFd9b526);
      card = Color(0xFF23272a);
      voteOpen = Colors.green;
      voteClosed = Colors.red;
      voted = Colors.blue;
      cardInkWell = Colors.blue.withAlpha(30);
      yes = Colors.lightBlueAccent;
      no = Colors.redAccent;
      selected = Colors.blue;
      unSelected = Color(0xff818181);
      button = Colors.blue;
      buttonOutline = Colors.transparent;
    } else if (styleNum == 1) {
      // Light mode
      senate = Colors.deepPurple;
      house = Colors.green[800];
      greyedOut = Colors.grey[300];
      background = Color(0xffEFEEEE);
      backgroundSecondary = Color(0xFFF3F3F3);
      mainTheme = Colors.blue;
      issues = Color(0xFF363663);
      text = Color(0xff797979);
      shareIcon = Color(0xFFd9b526);
      card = Color(0xffF9F9F9);
      voteOpen = Colors.green;
      voteClosed = Colors.red;
      voted = Colors.blue;
      cardInkWell = Colors.blue.withAlpha(30);
      yes = Colors.blue;
      no = Colors.redAccent;
      selected = Color(0xff818181);
      unSelected = Color(0xffB9B9B9);
      button = Colors.blue;
      buttonOutline = Colors.transparent;
    }
  }
}

class AppSizes {
  /// The standard sizes for the app
  double largeWidth;
  double mediumWidth;
  double smallWidth;
  double cardCornerRadius;
  double buttonRadius;
  double cardElevation;
  double standardMargin;
  double standardPadding;

  AppSizes() {
    largeWidth = 1200;
    mediumWidth = 600;
    smallWidth = 300;
    cardCornerRadius = 9.0;
    buttonRadius = 20.0;
    cardElevation = 2.0;
    standardMargin = 10.0;
    standardPadding = 30.0;
  }
}

class AppTextStyles {
  /// The standard text styles for the app
  TextStyle heading;
  TextStyle heading2;
  TextStyle heading3;
  TextStyle card;
  TextStyle smallBold;
  TextStyle small;
  TextStyle standard;
  TextStyle standardItalic;
  TextStyle standardBold;
  TextStyle yesnobutton;

  AppTextStyles() {
    heading = TextStyle(
      fontSize: 24,
      color: appColors.text,
      fontWeight: FontWeight.w700,
    );
    heading2 = TextStyle(
      fontSize: 20,
      color: appColors.text,
      fontWeight: FontWeight.w700,
    );
    heading3 = TextStyle(
      fontSize: 16,
      color: appColors.text,
      fontWeight: FontWeight.w700,
    );
    card = TextStyle(
        fontSize: 20, fontWeight: FontWeight.bold, color: appColors.text);

    smallBold = TextStyle(
        fontSize: 15, color: appColors.text, fontWeight: FontWeight.bold);

    small = TextStyle(
        fontSize: 15, color: appColors.text, fontWeight: FontWeight.normal);

    standard = TextStyle(fontSize: 16, color: appColors.text, height: 1.5);

    standardItalic = TextStyle(
        fontSize: 20, color: appColors.text, fontStyle: FontStyle.italic);

    standardBold = TextStyle(
        fontSize: 20, color: appColors.text, fontWeight: FontWeight.bold);

    yesnobutton = TextStyle(
        fontSize: 14, color: Colors.white, fontWeight: FontWeight.bold);
  }
}
