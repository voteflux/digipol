import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:voting_app/core/models/bill.dart';
import 'package:voting_app/ui/styles.dart';

class UserVotedStatus extends StatelessWidget {
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

  UserVotedStatus({
    Key /*?*/ key,
    @required this.bill,
    @required this.voted,
    @required this.size,
  }) : super(key: key);

  /// To get the status message format
  ///
  /// Returns a list: [colour, message, icon]
  Tuple3<Color, String, IconData> statusMessage(BuildContext context) {
    String s = "Not voted";
    Color c = appColors.voteClosed;
    var i = Icons.adjust;
    if (voted) {
      s = "Voted";
      c = Theme.of(context).colorScheme.primary;
      i = Icons.check_circle_outline;
    }
    // [colour, message, icon]
    return Tuple3(c, s, i);
  }

  @override
  Widget build(BuildContext context) {
    var statsMsg = statusMessage(context);
    return Container(
      child: Row(
        children: <Widget>[
          Text(
            statsMsg.value2, // message
            style: TextStyle(
                fontSize: 12, color: Theme.of(context).colorScheme.secondary),
          ),
          Padding(
            padding: EdgeInsets.only(left: 4),
            child: Icon(
              statsMsg.value3, // icon
              color: Theme.of(context).colorScheme.secondary, //color
              size: 16, // size
            ),
          )
        ],
      ),
    );
  }
}
