import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:voting_app/route_generator.dart';
import 'package:voting_app/styles.dart';
import 'package:voting_app/cutom_widgets.dart';
import 'package:pie_chart/pie_chart.dart';

class BillPage extends StatelessWidget {
  final Map data;

  BillPage({
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
        title: Text('Vote on Bill'),
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
              Wrap(
                children: <Widget>[
                  HouseIconsWidget(billsMap: data, size: 40),
                  VotingStatusWidget(billsMap: data, voted: false, size: 40),
                ],
              ),
              Container(
                width: appSizes.largeWidth,
                padding: EdgeInsets.all(20),
                child: Text(
                  data["Summary"],
                  style: appTextStyles.standard,
                ),
              ),
              BillInfoWidget(
                billText: data["text link pdf"],
                billEM: data["em link pdf"],
              ),
              PieWidget(
                // get from data
                yes: 1000,
                no: 551,
                radius: dynamicMediumHeight,
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

class BillInfoWidget extends StatelessWidget {
  /// Card directing voters to detailed info about the bill
  final billText;
  final billEM;
  BillInfoWidget({
    Key key,
    @required this.billText,
    @required this.billEM,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: appSizes.largeWidth,
        padding: EdgeInsets.all(appSizes.standardPadding),
        child: Card(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(appSizes.cardCornerRadius)),
          elevation: appSizes.cardElevation,
          color: appColors.card,
          child: Container(
            margin: EdgeInsets.all(appSizes.standardMargin),
            padding: EdgeInsets.symmetric(
                vertical: appSizes.standardPadding, horizontal: 0),
            child: Column(
              children: <Widget>[
                Text("Bill Information:", style: appTextStyles.heading),
                Wrap(
//                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                  children: <Widget>[
                    Container(
                      width: appSizes.smallWidth,
                      padding: EdgeInsets.all(appSizes.standardPadding),
                      child: Column(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.all(appSizes.standardPadding),
                            child: FlatButton(
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                    color: Colors.deepOrange[900], width: 2),
                                borderRadius: new BorderRadius.circular(
                                    appSizes.buttonRadius),
                              ),
                              onPressed: () {
                                Navigator.of(context).pushNamed(
                                  '/pdf',
                                  arguments: this.billText,
                                );
                              },
                              color: appColors.card,
                              child: Text("View Bill Text",
                                  style: appTextStyles.standard),
                            ),
                          ),
                          Container(
                            child: Text(
                              "Text of the bill as introduced into the Parliament",
                              style: appTextStyles.standardItalic,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(appSizes.standardPadding),
                      width: appSizes.smallWidth,
                      child: Column(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.all(appSizes.standardMargin),
                            child: FlatButton(
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                    color: Colors.purple[900], width: 3),
                                borderRadius: new BorderRadius.circular(
                                    appSizes.buttonRadius),
                              ),
                              onPressed: () {
                                Navigator.of(context).pushNamed(
                                  '/pdf',
                                  arguments: this.billEM,
                                );
                              },
                              color: appColors.card,
                              child: Text(
                                "View Explanatory Memoranda",
                                style: appTextStyles.standard,
                              ),
                            ),
                          ),
                          Container(
                            child: Text(
                              "Explanatory Memorandum: Accompanies and provides an explanation of the content of the introduced version (first reading) of the bill.",
                              style: appTextStyles.standardItalic,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class VoteWidget extends StatelessWidget {
  /// card with voting info and buttons
  final data;
  VoteWidget({
    Key key,
    @required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    areYouSure(String vote) {
      /// Dialog to confirm the vote
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: appColors.card,
            elevation: appSizes.cardElevation,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(appSizes.cardCornerRadius)),
            title: Text('Confirm Vote', style: appTextStyles.smallBold),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(
                    'Are you sure you want to vote ',
                    style: appTextStyles.small,
                  ),
                  Text(vote + '?', style: appTextStyles.smallBold),
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                child: Text('Confirm Vote'),
                onPressed: () {
                  // Put the vote on the blockchain!
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }

    return Center(
      child: Container(
        width: appSizes.largeWidth,
        padding: EdgeInsets.all(appSizes.standardPadding),
        child: Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(appSizes.cardCornerRadius)),
            elevation: appSizes.cardElevation,
            color: appColors.card,
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(appSizes.standardPadding),
                  child: Text("How would you like to vote on bill:",
                      style: appTextStyles.small),
                ),
                Container(
                    padding: EdgeInsets.all(appSizes.standardPadding),
                    child: Text(
                      this.data["Short Title"],
                      style: appTextStyles.standardBold,
                    )),
                Container(
                    padding: EdgeInsets.symmetric(
                        vertical: appSizes.standardPadding, horizontal: 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        FlatButton(
                            shape: RoundedRectangleBorder(
                              side: BorderSide(color: appColors.yes, width: 2),
                              borderRadius: new BorderRadius.circular(
                                  appSizes.buttonRadius),
                            ),
                            onPressed: () {
                              areYouSure("Yes");
                            },
                            color: appColors.card,
                            child: Text("Vote Yes",
                                style: appTextStyles.standard)),
                        FlatButton(
                            shape: RoundedRectangleBorder(
                              side: BorderSide(color: appColors.no, width: 2),
                              borderRadius: new BorderRadius.circular(
                                  appSizes.buttonRadius),
                            ),
                            onPressed: () {
                              areYouSure("No");
                            },
                            color: appColors.background,
                            child:
                                Text("Vote No", style: appTextStyles.standard)),
                      ],
                    )),
              ],
            )),
      ),
    );
  }
}
