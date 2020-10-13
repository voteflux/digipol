import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:voting_app/core/models/bill.dart';
import 'package:voting_app/ui/styles.dart';

class VotingStatusWidget extends StatelessWidget {
  final Bill bill;
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
    Key /*?*/ key,
    @required this.bill,
    @required this.voted,
    @required this.size,
  }) : super(key: key);

  /// To get the status message format
  ///
  /// Returns a list: [colour, message, icon]
  Tuple3<Color, String, IconData> statusMessage() {
    String s = "Closed";
    Color c = appColors.voteClosed;
    var i = Icons.adjust;
    if (voted) {
      s = "Voted";
      c = appColors.voted;
      i = Icons.check_circle_outline;
    } else {
      if (bill.chamber == "House") {
        if (bill.passedSenate == "") {
          s = "Open";
          c = appColors.voteOpen;
          i = Icons.add_circle_outline;
        }
      } else {
        if (bill.passedHouse == "") {
          s = "Open";
          c = appColors.voteOpen;
          i = Icons.add_circle_outline;
        }
      }
    }
    // [colour, message, icon]
    return Tuple3(c, s, i);
  }

  @override
  Widget build(BuildContext context) {
    var statsMsg = statusMessage();
    return Container(
      child: Column(
        children: <Widget>[
          Icon(
            statsMsg.value3, // icon
            color: statsMsg.value1, //color
            size: this.size, // size
          ),
          Text(
            statsMsg.value2, // message
            style: TextStyle(
                fontSize: this.size * 4 / 10,
                fontWeight: FontWeight.bold,
                color: statsMsg.value1),
          ),
        ],
      ),
    );
  }
}
