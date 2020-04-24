import 'package:flutter/material.dart';
import 'package:voting_app/core/enums/viewstate.dart';
import 'package:voting_app/core/models/bill_vote.dart';
import 'package:voting_app/core/services/voting_service.dart';
import 'package:voting_app/core/viewmodels/bill_vote_model.dart';
import 'package:voting_app/ui/styles.dart';
import 'package:voting_app/ui/views/base_view.dart';

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
    return BaseView<BillVoteModel>(
      builder: (context, model, child) => Center(
        child: Container(
          width: appSizes.largeWidth,
          child: model.state == ViewState.Busy
              ? Card(
                  margin: EdgeInsets.all(30.0),
                  color: Theme.of(context).scaffoldBackgroundColor,
                  child: Column(
                    children: <Widget>[
                      Text("Voting ",
                          style: Theme.of(context).textTheme.headline6),
                      Container(
                        padding: EdgeInsets.all(appSizes.standardPadding),
                        child: CircularProgressIndicator(),
                      )
                    ],
                  ))
              : Card(
                  margin: EdgeInsets.all(30.0),
                  color: Theme.of(context).scaffoldBackgroundColor,
                  child: Column(
                    children: <Widget>[
                      Container(
                          padding: EdgeInsets.all(appSizes.standardPadding),
                          child: Text(
                            widget.data.shortTitle,
                            style: Theme.of(context).textTheme.headline6,
                          )),
                      Container(
                        padding: EdgeInsets.all(appSizes.standardPadding),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            RaisedButton(
                                onPressed: () {
                                  areYouSure("Yes", model);
                                },
                                color: appColors.yes,
                                child: Text("Vote Yes",
                                    style: appTextStyles.yesnobutton)),
                            RaisedButton(
                                onPressed: () {
                                  areYouSure("No", model);
                                },
                                color: appColors.no,
                                child: Text("Vote No",
                                    style: appTextStyles.yesnobutton)),
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

  areYouSure(String vote, model) {
    /// Dialog to confirm the vote
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          elevation: appSizes.cardElevation,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(appSizes.cardCornerRadius)),
          title: Text('Confirm Vote',
              style: Theme.of(context).textTheme.headline6),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  'Are you sure you want to vote ',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                Text(vote + '?', style: Theme.of(context).textTheme.headline6),
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
            RaisedButton(
              child: Text('Confirm Vote'),
              onPressed: () {
                Navigator.of(context).pop();
                model.postVote(
                  BillVote(
                      //TO DO: update to real data
                      pubKey: "lafksdjfnhc934y8q5pcn98xpc5ny85y410c5mp9xnyv",
                      ballotId: "r6434",
                      ballotSpecHash:
                          "86d9935a4fcdd7d517293229527ace224287cb6ba2d07115f4784db16fece5af",
                      constituency: "Australia",
                      vote: vote),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
