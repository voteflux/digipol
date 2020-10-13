import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:voting_app/core/models/bill.dart';
import 'package:voting_app/core/viewmodels/theme_model.dart';
import 'package:voting_app/ui/styles.dart';

class HouseIconsWidget extends StatelessWidget {
  final Bill bill;
  final Color senateColor = appColors.senate;
  final Color houseColor = appColors.house;
  final Color noFillColor = Colors.grey;

  final Color houseLightColor = Colors.green[300];
  final Color houseDarkColor = Colors.green[400];

  final Color senateLightColor = Colors.deepPurple[200];
  final Color senateDarkColor = Colors.deepPurple[400];

  final double size;

  /// shows the progression of a bill as coloured icons
  ///
  /// colours represent the house and senate
  /// usage:
  ///
  /// `child: HouseIconsWidget(issuesMap: issuesMap,size: 20,),`
  HouseIconsWidget({Key /*?*/ key, @required this.size, @required this.bill})
      : super(key: key);

  // gets correct colour for Intro House
  Color hiChooser(Bill theBill, bool state) {
    if (theBill.chamber == "House") {
      if (theBill.introHouse == "") {
        return noFillColor;
      } else {
        return state ? houseDarkColor : houseLightColor;
      }
    } else {
      if (theBill.introSenate == "") {
        return noFillColor;
      } else {
        return state ? senateDarkColor : senateLightColor;
      }
    }
  }

  // gets correct colour for Passed House
  Color hpChooser(Bill theBill, bool state) {
    if (theBill.chamber == "House") {
      if (theBill.passedHouse == "") {
        return noFillColor;
      } else {
        return state ? houseDarkColor : houseLightColor;
      }
    } else {
      if (theBill.passedSenate == "") {
        return noFillColor;
      } else {
        return state ? senateDarkColor : senateLightColor;
      }
    }
  }

  // gets correct colour for Intro Senate
  Color siChooser(Bill theBill, bool state) {
    if (theBill.chamber == "House") {
      if (theBill.introHouse == "") {
        return noFillColor;
      } else {
        return state ? senateDarkColor : senateLightColor;
      }
    } else {
      if (theBill.introHouse == "") {
        return noFillColor;
      } else {
        return state ? houseDarkColor : houseLightColor;
      }
    }
  }

  // gets correct colour for Passed Senate
  Color spChooser(Bill theBill, bool state) {
    if (theBill.chamber == "House") {
      if (theBill.passedSenate == "") {
        return noFillColor;
      } else {
        return state ? senateDarkColor : senateLightColor;
      }
    } else {
      if (theBill.passedHouse == "") {
        return noFillColor;
      } else {
        return state ? houseDarkColor : houseLightColor;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // icons
    return Container(
      height: this.size,
      width: this.size * 7,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Icon(
            Icons.account_balance,
            color: hiChooser(bill,
                Provider.of<ThemeModel>(context, listen: false).isDarkMode),
            size: this.size,
          ),
          Icon(
            Icons.label_important,
            color: noFillColor,
            size: this.size,
          ),
          Icon(
            Icons.check_circle,
            color: hpChooser(bill,
                Provider.of<ThemeModel>(context, listen: false).isDarkMode),
            size: this.size,
          ),
          Icon(
            Icons.label_important,
            color: noFillColor,
            size: this.size,
          ),
          Icon(
            Icons.account_balance,
            color: siChooser(bill,
                Provider.of<ThemeModel>(context, listen: false).isDarkMode),
            size: this.size,
          ),
          Icon(
            Icons.label_important,
            color: noFillColor,
            size: this.size,
          ),
          Icon(
            Icons.check_circle,
            color: spChooser(bill,
                Provider.of<ThemeModel>(context, listen: false).isDarkMode),
            size: this.size,
          ),
        ],
      ),
    );
  }
}
