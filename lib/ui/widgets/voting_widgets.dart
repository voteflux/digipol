import 'package:flutter/material.dart';
import 'package:voting_app/ui/styles.dart';
import 'package:voting_app/core/services/vote.dart';

// The plan here is to have a card that has 3 states
// 1 voting options - the default
// 2 Vote processing
// 3 Voted - showing vote info (time, hash, vote...)
// separate into widgets


class VoteWidget extends StatefulWidget {
  // card with voting info and buttons
  final data;
  final bool loggedIn = false;
  /// Where voting stuff happens
  ///
  /// usage:
  ///
  /// `child: VoteWidget(data: data,),`
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
        child: Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(appSizes.cardCornerRadius)),
            elevation: appSizes.cardElevation,
            color: appColors.card,
            child: Column(
              children: <Widget>[
                Container(
                    padding: EdgeInsets.all(appSizes.standardPadding),
                    child: Text(
                      widget.data.shortTitle,
                      style: appTextStyles.standardBold,
                    )),
                Container(
                  padding: EdgeInsets.only(bottom: 20.0),
                    child: 
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        RaisedButton(
                            elevation: appSizes.cardElevation,
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                  color: appColors.buttonOutline, width: 2),
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
