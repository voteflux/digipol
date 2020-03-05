import 'package:flutter/material.dart';

class AppColors {
  Color house;
  Color senate;
  Color greyedOut;
  Color background;
  Color mainTheme;
  Color issues;
  Color text;
  Color shareIcon;

  AppColors(bool dark){
    if (dark){
      house = Color(0xFF214521);
      senate = Color(0xFF772222);
      greyedOut = Colors.grey[800];
      background = Color(0xFF353135);
      mainTheme = Color(0xFF0d0c0d);
      issues = Color(0xFF363663);
      text = Color(0xFFd1d1e0);
      shareIcon = Color(0xFFd9b526);
    }else{
      house = Color(0xFF214521);
      senate = Color(0xFF772222);
      greyedOut = Colors.grey[300];
      background = Colors.white;
      mainTheme = Colors.lightBlue;
      issues = Color(0xFF363663);
      text = Colors.black87;
      shareIcon = Color(0xFFd9b526);
    }

  }


}