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
  Color voteOpen;
  Color voteClosed;
  Color voted;
  Color card;


  AppColors(int styleNum){
    if (styleNum == 0){
      house = Color(0xFF0f4533);
      senate = Color(0xFF2c0b56);
      greyedOut = Colors.grey[800];
      background = Color(0xFF2c2f33);
      mainTheme = Color(0xFF23272a);
      issues = Color(0xFF363663);
      text = Color(0xFF99aab5);
      shareIcon = Color(0xFFd9b526);
      card = Color(0xFF23272a);
      voteOpen = Colors.green;
      voteClosed = Colors.red;
      voted = Colors.blue;

    }else if (styleNum == 1){
      house = Color(0xFF214521);
      senate = Color(0xFF772222);
      greyedOut = Colors.grey[300];
      background = Colors.white;
      mainTheme = Colors.lightBlue;
      issues = Color(0xFF363663);
      text = Colors.black87;
      shareIcon = Color(0xFFd9b526);
      card = Colors.grey[300];
      voteOpen = Colors.green;
      voteClosed = Colors.red;
      voted = Colors.blue;

    }else if (styleNum == 2){
    senate  = Colors.deepPurple;
    house = Colors.green[800];
    greyedOut = Colors.grey[300];
    background = Colors.white;
    mainTheme = Colors.blue;
    issues = Color(0xFF363663);
    text = Colors.black87;
    shareIcon = Color(0xFFd9b526);
    card = Colors.grey[300];
    voteOpen = Colors.green;
    voteClosed = Colors.red;
    voted = Colors.blue;

    }

  }


}

var appColors = AppColors(0);