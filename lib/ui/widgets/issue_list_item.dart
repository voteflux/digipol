import 'package:flutter/material.dart';
import 'package:voting_app/core/models/issue.dart';
import 'dart:math';
import 'package:voting_app/ui/styles.dart';
import 'package:voting_app/ui/widgets/custom_widgets.dart';
import 'package:voting_app/ui/views/issues/issue.dart';

class IssueListItem extends StatelessWidget {

  final Issue issue;
  final Map billColorsDark = {
    "House": appColors.house,
    "Senate": appColors.senate
  };
  final Random random = new Random();

  IssueListItem({this.issue});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(appSizes.cardCornerRadius)),
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        elevation: appSizes.cardElevation,
        color: appColors.card,
        child: InkWell(
          splashColor: Colors.blue.withAlpha(30),
          onTap: () {
            // Pushing a named route
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => IssuePage(issue: issue)),
            );
          },
          child: Container(
            width: 500,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("Open",
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w800,
                              fontStyle: FontStyle.italic,
                              color: Colors.blue)),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(15),
                  child: Text(issue.shortTitle,
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: appColors.text)),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Icon(
                            Icons.contacts,
                            color: appColors.text,
                          ),
                          Text(
                            (issue.yes + issue.no).toString(),
                            style:
                                TextStyle(color: appColors.text, fontSize: 10),
                          )
                        ],
                      ),
                      PieWidget(
                        // Delete Random when vote status is obtained
                        yes: issue.yes,
                        no: issue.no,
                        radius: 55,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

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
