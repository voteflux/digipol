import 'package:flutter/material.dart';
import 'package:voting_app/ui/styles.dart';
import 'package:pie_chart/pie_chart.dart';

class PieWidget extends StatelessWidget {
  final int yes;
  final int no;
  final double radius;
  final bool showValues;

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
    @required this.showValues
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
      animationDuration: Duration(milliseconds: 800),
      chartLegendSpacing: 10.0,
      chartRadius: this.radius,
      showChartValues: false,
      showChartValueLabel: false,
      legendStyle:
          TextStyle(fontSize: this.radius / 20 + 10, color: appColors.text),
      chartValueStyle: TextStyle(
          fontSize: this.radius / 20 + 10,
          fontWeight: FontWeight.bold,
          color: Colors.black),
    );
  }
}