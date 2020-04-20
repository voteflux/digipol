import 'package:flutter/material.dart';
import 'package:voting_app/core/models/issue.dart';
import 'dart:math';
import 'package:voting_app/ui/styles.dart';
import 'package:voting_app/ui/views/issues/issue.dart';
import 'package:voting_app/ui/widgets/pie_chart.dart';

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
        child: InkWell(
          splashColor: Colors.blue.withAlpha(30),
          onTap: () {
            // Pushing a named route
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => IssuePage(issue: issue)),
            );
          },
          child: Container(
            width: appSizes.mediumWidth,
            padding: EdgeInsets.all(appSizes.standardPadding),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("Open",
                          // TextStyle specific to this widget
                          style: Theme.of(context).textTheme.bodyText1),
                    ],
                  ),
                ),
                Divider(),
                Container(
                  child: Text(issue.shortTitle,
                      style: Theme.of(context).textTheme.headline6),
                ),
                Container(
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
                        showValues: false,
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