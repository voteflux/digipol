import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:voting_app/core/models/block_chain_data.dart';
import 'package:voting_app/core/models/issue.dart';
import 'dart:math';
import 'package:voting_app/ui/styles.dart';
import 'package:voting_app/ui/views/issues/issue_view.dart';
import 'package:voting_app/ui/widgets/pie_chart.dart';

class IssueListItem extends StatefulWidget {
  @override
  _IssueListItemState createState() => _IssueListItemState();

  final BlockChainData blockChainData;
  final Map billColorsDark = {
    "House": appColors.house,
    "Senate": appColors.senate
  };
  final Random random = new Random();

  IssueListItem({this.blockChainData});
}

class _IssueListItemState extends State<IssueListItem> {
  Issue completeIssueData;
  Box<Issue> issuesBox = Hive.box<Issue>("issues");

  Future getVote() async {
    // Get all issue data from Box
    List<Issue> list = issuesBox.values
        .where((issue) => issue.id == widget.blockChainData.id)
        .toList();
    completeIssueData = list[0];
  }

  @protected
  @mustCallSuper
  void initState() {
    getVote();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: EdgeInsets.all(appSizes.standardMargin),
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => IssuePage(issue: completeIssueData)),
            );
          },
          child: Container(
            padding: EdgeInsets.all(appSizes.standardPadding),
            width: appSizes.mediumWidth,
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
                Text(completeIssueData.shortTitle,
                    style: Theme.of(context).textTheme.headline6),
                Text(completeIssueData.question,
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
