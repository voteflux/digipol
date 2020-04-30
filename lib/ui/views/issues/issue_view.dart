import 'package:flutter/material.dart';
import 'package:voting_app/core/enums/viewstate.dart';
import 'package:voting_app/core/models/issue.dart';
import 'package:voting_app/core/viewmodels/issue_model.dart';
import 'package:voting_app/ui/styles.dart';
import 'package:voting_app/ui/views/base_view.dart';
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

    return BaseView<IssueModel>(
      onModelReady: (model) => model.getIssue(issue.id),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: appColors.text),
          elevation: 0,
          title: Text('Vote on Issue', style: appTextStyles.standard),
        ),
        body: model.state == ViewState.Busy
            ? Center(child: CircularProgressIndicator())
            : Center(
                child: Container(
                  width: dynamicLargeWidth,
                  child: ListView(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(bottom: 20.0, top: 10.0),
                        child: PieWidget(
                          // get from data
                          yes: model.billVoteResult.yes,
                          showValues: true,
                          no: model.billVoteResult.no,
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
                        child: Column(
                          children: <Widget>[
                            Align(
                              child: Padding(
                                padding: EdgeInsets.only(bottom: 20.0),
                                child: Text(
                                  issue.shortTitle,
                                  style: Theme.of(context).textTheme.headline5,
                                ),
                              ),
                              alignment: Alignment.centerLeft,
                            ),
                            Align(
                              child: Padding(
                                padding: EdgeInsets.only(bottom: 20.0),
                                child: Text(
                                  issue.question,
                                  style: Theme.of(context).textTheme.bodyText1,
                                ),
                              ),
                              alignment: Alignment.centerLeft,
                            ),
                            Divider(),
                            Text(
                              issue.description,
                              style: Theme.of(context).textTheme.bodyText2,
                            ),
                            VoteWidget(
                              data: model.billChainData,
                              vote: model.getVote,
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
