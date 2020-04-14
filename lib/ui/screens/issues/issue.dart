import 'package:flutter/material.dart';
import 'package:voting_app/core/models/issue.dart';
import 'package:voting_app/ui/styles.dart';
import 'package:voting_app/ui/widgets/custom_widgets.dart';
import 'package:voting_app/ui/widgets/voting_widgets.dart';

class IssuePage extends StatelessWidget {
  /// information about the issue

  final Issue issue;

  IssuePage({
    Key key,
    @required this.issue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double dynamicMediumHeight = MediaQuery.of(context).size.height * 0.25;
    double dynamicLargeWidth = MediaQuery.of(context).size.width * 1;
    if (dynamicLargeWidth > appSizes.largeWidth) {
      dynamicLargeWidth = appSizes.largeWidth;
    }
    return Scaffold(
      backgroundColor: appColors.background,
      appBar: AppBar(
        iconTheme: IconThemeData(color: appColors.text),
        elevation: 0,
        backgroundColor: appColors.background,
        title: Text('Vote on Issue', style: appTextStyles.standard),
      ),
      body: Center(
        child: Container(
          width: dynamicLargeWidth,
          child: ListView(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(bottom: 20.0, top: 10.0),
                child: PieWidget(
                  // get from data
                  yes: issue.yes,
                  no: issue.no,
                  radius: dynamicMediumHeight,
                ),
              ),
              Container(
                  color: appColors.backgroundSecondary,
                  width: dynamicLargeWidth,
                  padding: EdgeInsets.all(appSizes.standardPadding),
                  child: Wrap(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(bottom: 20.0),
                        child: Text(
                          issue.shortTitle,
                          style: appTextStyles.heading,
                        ),
                      ),
                      Text(
                        issue.summary,
                        style: appTextStyles.standard,
                      ),
                      Text(
                        issue.description,
                        style: appTextStyles.standard,
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 20.0, top: 20.0),
                        child: VoteWidget(
                          data: issue,
                        ),
                      )
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
