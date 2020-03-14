import 'package:flutter/material.dart';
import 'package:voting_app/styles.dart';
import 'package:voting_app/cutom_widgets.dart';
import 'package:voting_app/voting_widgets.dart';

class IssuePage extends StatelessWidget {
  /// information about the issue
  final Map data;

  IssuePage({
    Key key,
    @required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double dynamicMediumHeight = MediaQuery.of(context).size.height * 0.25;
    double dynamicLargeWidth = MediaQuery.of(context).size.width * 0.95;
    if (dynamicLargeWidth > appSizes.largeWidth) {
      dynamicLargeWidth = appSizes.largeWidth;
    }
    return Scaffold(
      backgroundColor: appColors.background,
      appBar: AppBar(
        backgroundColor: appColors.mainTheme,
        title: Text('Vote on Issue'),
      ),
      body: Center(
        child: Container(
          width: dynamicLargeWidth,
          child: ListView(
            children: <Widget>[
              Container(
                  width: dynamicLargeWidth,
                  padding: EdgeInsets.all(appSizes.standardPadding),
                  child: Wrap(
                    children: <Widget>[
                      Text(
                        data["Short Title"],
                        style: appTextStyles.heading,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  )),
              Container(
                width: appSizes.largeWidth,
                padding: EdgeInsets.all(20),
                child: Text(
                  data["Summary"],
                  style: appTextStyles.standard,
                ),
              ),
              Container(
                  width: dynamicLargeWidth,
                  padding: EdgeInsets.all(appSizes.standardPadding),
                  child: Wrap(
                    children: <Widget>[
                      Text(
                        "Current Voting Results",
                        style: appTextStyles.standardBold,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  )),
              PieWidget(
                // get from data
                yes: data["Yes"],
                no: data["No"],
                radius: dynamicMediumHeight,
              ),
              Container(
                width: appSizes.largeWidth,
                padding: EdgeInsets.all(20),
                child: Text(
                  data["Description"],
                  style: appTextStyles.standard,
                ),
              ),
              VoteWidget(
                data: data,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
