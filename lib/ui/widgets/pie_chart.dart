import 'package:flutter/material.dart';
import 'package:voting_app/ui/styles.dart';
import 'package:fl_chart/fl_chart.dart';

class PieWidget extends StatelessWidget {
  final int yes;
  final int no;
  final double sectionSpace;
  final double radius;
  final bool showValues;

  /// Pie graph showing yes vs no
  ///
  /// usage:
  ///
  /// `child: PieWidget(yes: 1000, no: 551, radius: 50,),`
  PieWidget(
      {Key key,
      @required this.yes,
      @required this.no,
      @required this.sectionSpace,
      @required this.radius,
      @required this.showValues})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double yesOut = this.yes.toDouble();
    double noOut = this.no.toDouble();

    return PieChart(
      PieChartData(
          startDegreeOffset: 180,
          borderData: FlBorderData(
            show: false,
          ),
          sectionsSpace: this.sectionSpace,
          sections: showingSections(yesOut, noOut, showValues)),
    );
  }

  List<PieChartSectionData> showingSections(yes, no, showValues) {
    return List.generate(2, (i) {
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: const Color(0xff0066CC),
            value: yes,
            title: showValues ? 'Yes: ' + yes.toInt().toString() : '',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 1:
          return PieChartSectionData(
            color: const Color(0xffFFB1AC),
            value: no,
            title: showValues ? 'No: ' + no.toInt().toString() : '',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        default:
          return null;
      }
    });
  }
}
