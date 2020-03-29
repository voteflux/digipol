import 'package:flutter/material.dart';
import 'package:voting_app/styles.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:voting_app/api/vote.dart';
import 'dart:math';
import 'dart:async';

class HouseIconsWidget extends StatelessWidget {
  final issuesMap;
  final Color senateColor = appColors.senate;
  final Color houseColor = appColors.house;
  final Color noFillColor = appColors.greyedOut;
  final double size;

  /// shows the progression of a bill as coloured icons
  ///
  /// colours represent the house and senate
  /// usage:
  ///
  /// `child: HouseIconsWidget(issuesMap: issuesMap,size: 20,),`
  HouseIconsWidget({
    Key key,
    @required this.issuesMap,
    @required this.size,
  }) : super(key: key);

  // gets correct colour for Intro House
  hiChooser(Map theBill) {
    if (theBill["Chamber"] == "House") {
      if (theBill["Intro House"] == "") {
        return noFillColor;
      } else {
        return houseColor;
      }
    } else {
      if (theBill["Intro Senate"] == "") {
        return noFillColor;
      } else {
        return senateColor;
      }
    }
  }

  // gets correct colour for Passed House
  hpChooser(Map theBill) {
    if (theBill["Chamber"] == "House") {
      if (theBill["Passed House"] == "") {
        return noFillColor;
      } else {
        return houseColor;
      }
    } else {
      if (theBill["Passed Senate"] == "") {
        return noFillColor;
      } else {
        return senateColor;
      }
    }
  }

  // gets correct colour for Intro Senate
  siChooser(Map theBill) {
    if (theBill["Chamber"] == "House") {
      if (theBill["Intro Senate"] == "") {
        return noFillColor;
      } else {
        return senateColor;
      }
    } else {
      if (theBill["Intro House"] == "") {
        return noFillColor;
      } else {
        return houseColor;
      }
    }
  }

  // gets correct colour for Passed Senate
  spChooser(Map theBill) {
    if (theBill["Chamber"] == "House") {
      if (theBill["Passed Senate"] == "") {
        return noFillColor;
      } else {
        return senateColor;
      }
    } else {
      if (theBill["Passed House"] == "") {
        return noFillColor;
      } else {
        return houseColor;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // icons
    return Container(
      margin: EdgeInsets.all(appSizes.standardPadding),
      height: this.size,
      width: this.size * 7,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Icon(
            Icons.account_balance,
            color: hiChooser(issuesMap),
            size: this.size,
          ),
          Icon(
            Icons.label_important,
            color: appColors.greyedOut,
            size: this.size,
          ),
          Icon(
            Icons.check_circle,
            color: hpChooser(issuesMap),
            size: this.size,
          ),
          Icon(
            Icons.label_important,
            color: appColors.greyedOut,
            size: this.size,
          ),
          Icon(
            Icons.account_balance,
            color: siChooser(issuesMap),
            size: this.size,
          ),
          Icon(
            Icons.label_important,
            color: appColors.greyedOut,
            size: this.size,
          ),
          Icon(
            Icons.check_circle,
            color: spChooser(issuesMap),
            size: this.size,
          ),
        ],
      ),
    );
  }
}

class VotingStatusWidget extends StatelessWidget {
  final Map issuesMap;
  final bool voted;
  final double size;

  ///Widget showing the voting status
  ///
  /// displays as either: voting open, voting closed or voted
  ///
  /// Usage:
  ///
  /// `child:  VotingStatusWidget(issuesMap: issuesMap,voted: true,size: 20),`

  VotingStatusWidget({
    Key key,
    @required this.issuesMap,
    @required this.voted,
    @required this.size,
  }) : super(key: key);

  /// To get the status message format
  ///
  /// Returns a list: [colour, message, icon]
  statusMessage() {
    String s = "Closed";
    Color c = appColors.voteClosed;
    var i = Icons.adjust;
    if (voted) {
      s = "Voted";
      c = appColors.voted;
      i = Icons.check_circle_outline;
    } else {
      if (issuesMap["Chamber"] == "House") {
        if (issuesMap["Passed Senate"] == "") {
          s = "Open";
          c = appColors.voteOpen;
          i = Icons.add_circle_outline;
        }
      } else {
        if (issuesMap["Passed House"] == "") {
          s = "Open";
          c = appColors.voteOpen;
          i = Icons.add_circle_outline;
        }
      }
    }
    // [colour, message, icon]
    return [c, s, i];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: <Widget>[
        Icon(
          statusMessage()[2], // icon
          color: statusMessage()[0], //color
          size: this.size, // size
        ),
        Text(
          statusMessage()[1], // message
          style: TextStyle(
              fontSize: this.size * 4 / 10,
              fontWeight: FontWeight.bold,
              color: statusMessage()[0]),
        ),
      ],
    ));
  }
}

class CountUpWidget extends StatefulWidget {
  @override
  _CountUpWidgetState createState() => _CountUpWidgetState();
  final int number;
  final String text;
  final List<int> delayers = [1, 2, 4, 6, 8, 10, 16, 18, 20];

  /// to display a number by counting up to it
  ///
  /// Usage:
  ///
  /// `child: CountUpWidget(number: bunnyNum, text: "Bunnies bred"),`

  CountUpWidget({
    Key key,
    @required this.number,
    @required this.text,
  }) : super(key: key);
}

class _CountUpWidgetState extends State<CountUpWidget> {
  int index = 0;
  int outputNumber = 0;
  var fw = FontWeight.normal;

  @override
  Widget build(BuildContext context) {
    if (index < widget.delayers.length) {
      int d = widget.delayers[index];
      Future.delayed(Duration(milliseconds: d * 16), () {
        setState(() {
          this.index = this.index + 1;
          this.outputNumber = d * widget.number ~/ 20;
        });
      });
    } else {
      fw = FontWeight.bold;
    }

    return Center(
        child: Container(
      padding: EdgeInsets.all(appSizes.standardPadding),
      child: Column(
        children: <Widget>[
          Text(
            widget.text,
            style: appTextStyles.smallBold,
          ),
          Text(
            this.outputNumber.toString(),
            style:
                TextStyle(fontSize: 55, color: appColors.text, fontWeight: fw),
          ),
        ],
      ),
    ));
  }
}

class PieWidget extends StatelessWidget {
  final int yes;
  final int no;
  final double radius;

  /// Pie graph showing yes vs no
  ///
  /// usage:
  ///
  /// `child: PieWidget(yes: 1000, no: 551, radius: 50,),`
  PieWidget({
    Key key,
    @required this.yes,
    @required this.no,
    @required this.radius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double yesOut = (this.yes / (this.yes + this.no)) * 100;
    double noOut = 100 - yesOut;

    Map<String, double> dataMap = new Map();
    dataMap.putIfAbsent("No", () => noOut);
    dataMap.putIfAbsent("Yes", () => yesOut);

    return PieChart(
      dataMap: dataMap,
      animationDuration: Duration(milliseconds: 1500),
      chartLegendSpacing: 10.0,
      chartRadius: this.radius,
      showChartValuesInPercentage: true,
      legendStyle:
          TextStyle(fontSize: this.radius / 20 + 10, color: appColors.text),
      chartValueStyle: TextStyle(
          fontSize: this.radius / 20 + 10,
          fontWeight: FontWeight.bold,
          color: Colors.black),
    );
  }
}
