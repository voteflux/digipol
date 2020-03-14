import 'package:flutter/material.dart';
import 'package:voting_app/styles.dart';
import 'package:voting_app/api/vote.dart';

class VoteWidget extends StatefulWidget {
  /// card with voting info and buttons
  final data;
  final bool loggedIn = false;
  VoteWidget({
    Key key,
    @required this.data,
  }) : super(key: key);

  @override
  _VoteWidgetState createState() => _VoteWidgetState();
}

class _VoteWidgetState extends State<VoteWidget> {
  @override
  Widget build(BuildContext context) {
    notLoggedIn() {
      showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: appColors.card,
            elevation: appSizes.cardElevation,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(appSizes.cardCornerRadius)),
            title: Text('Not Logged in', style: appTextStyles.smallBold),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(
                    'You can not make a vote because you are not logged in',
                    style: appTextStyles.small,
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }

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
                  Navigator.of(context).pop();
                  if (widget.loggedIn) {
                    makeVote(vote, widget.data["id"], "UserID");
                  } else {
                    notLoggedIn();
                  }
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
                  child: Text("How would you like to vote on:",
                      style: appTextStyles.standardItalic),
                ),
                Container(
                    padding: EdgeInsets.all(appSizes.standardPadding),
                    child: Text(
                      widget.data["Short Title"],
                      style: appTextStyles.standardBold,
                    )),
                Container(
                    padding: EdgeInsets.symmetric(
                        vertical: appSizes.standardPadding, horizontal: 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        RaisedButton(
                            elevation: appSizes.cardElevation,
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                  color: appColors.buttonOutline, width: 2),
                              borderRadius: new BorderRadius.circular(
                                  appSizes.buttonRadius),
                            ),
                            onPressed: () {
                              areYouSure("Yes");
                            },
                            color: appColors.yes,
                            child: Text("Vote Yes",
                                style: appTextStyles.yesnobutton)),
                        RaisedButton(
                            elevation: appSizes.cardElevation,
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                  color: appColors.buttonOutline, width: 2),
                              borderRadius: new BorderRadius.circular(
                                  appSizes.buttonRadius),
                            ),
                            onPressed: () {
                              areYouSure("No");
                            },
                            color: appColors.no,
                            child: Text("Vote No",
                                style: appTextStyles.yesnobutton)),
                      ],
                    )),
              ],
            )),
      ),
    );
  }
}
