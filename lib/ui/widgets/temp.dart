import 'package:flutter/material.dart';

class VotingStatusWidget extends StatelessWidget {
  Map issuesMap;
  bool voted;
  VotingStatusWidget(Map m, bool v) {
    this.issuesMap = m;
    this.voted = v;
  }

  statusMessage() {
    String s = "Closed";
    Color c = Colors.red;
    var i = Icons.adjust;
    if (voted) {
      s = "Voted";
      c = Colors.blue;
      i = Icons.check_circle_outline;
    } else {
      if (issuesMap["Chamber"] == "House") {
        if (issuesMap["Passed Senate"] == "") {
          s = "Open";
          c = Colors.green;
          i = Icons.add_circle_outline;
        }
      } else {
        if (issuesMap["Passed House"] == "") {
          s = "Open";
          c = Colors.green;
          i = Icons.add_circle_outline;
        }
      }
    }

    return [c, s, i];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Icon(
            statusMessage()[2],
            color: statusMessage()[0],
            size: 20,
          ),
          Text(
            statusMessage()[1],
            style: TextStyle(
                fontSize: 8,
                fontWeight: FontWeight.bold,
                color: statusMessage()[0]),
          ),
        ],
      ),
    );
  }
}
