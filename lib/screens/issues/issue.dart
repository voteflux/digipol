import 'package:flutter/material.dart';
import 'package:voting_app/styles.dart';
import 'package:voting_app/widgets/custom_widgets.dart';
import 'package:voting_app/widgets/voting_widgets.dart';

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
                  yes: data["Yes"],
                  no: data["No"],
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
                          data["Short Title"],
                          style: appTextStyles.heading,
                        ),
                      ),
                      Text(
                        data["Summary"],
                        style: appTextStyles.standard,
                      ),
                      Text(
                        data["Description"],
                        style: appTextStyles.standard,
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 20.0, top: 20.0),
                        child: VoteWidget(
                          data: data,
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
