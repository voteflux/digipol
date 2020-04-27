import 'package:flutter/material.dart';
import 'package:voting_app/ui/styles.dart';
import 'dart:async';

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
