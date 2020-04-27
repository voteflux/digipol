import 'package:flutter/material.dart';
import 'package:voting_app/core/models/issue.dart';
import 'dart:math';
import 'package:voting_app/ui/styles.dart';
import 'package:voting_app/ui/views/issues/issue_view.dart';
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
        child: InkWell(
          onTap: () {
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
                          style: Theme.of(context).textTheme.bodyText1),
                    ],
                  ),
                ),
                Divider(),
                Text(issue.shortTitle,
                    style: Theme.of(context).textTheme.headline6),
                Text(issue.question,
                    style: Theme.of(context).textTheme.bodyText2),
                Divider(),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Icon(
                            Icons.supervised_user_circle,
                            color: appColors.text,
                          ),
                          Text(
                            (1).toString(),
                            style:
                                TextStyle(color: appColors.text, fontSize: 10),
                          )
                        ],
                      ),
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
