import 'package:flutter/material.dart';
import 'package:voting_app/core/models/issue.dart';
import 'package:voting_app/ui/styles.dart';
import 'package:voting_app/ui/widgets/custom_widgets.dart';
import 'package:voting_app/ui/widgets/pie_chart.dart';
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
      appBar: AppBar(
        iconTheme: IconThemeData(color: appColors.text),
        elevation: 0,
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
                  showValues: true,
                  no: issue.no,
                  radius: dynamicMediumHeight,
                ),
              ),
              Container(
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(25.0),
                          topRight: Radius.circular(25.0))),
                  width: dynamicLargeWidth,
                  padding: EdgeInsets.all(appSizes.standardPadding),
                  child: Wrap(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(bottom: 20.0),
                        child: Text(
                          issue.shortTitle,
                          style: Theme.of(context).textTheme.headline5,
                        ),
                      ),
                      Text(
                        issue.summary,
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      Divider(),
                      Text(
                        issue.description,
                        style: Theme.of(context).textTheme.bodyText2,
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
