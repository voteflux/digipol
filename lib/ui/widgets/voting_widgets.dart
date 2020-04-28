import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:voting_app/core/enums/viewstate.dart';
import 'package:voting_app/core/models/bill_vote.dart';
import 'package:voting_app/core/models/bill_vote_success.dart';
import 'package:voting_app/core/services/auth_service.dart';
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
  Future<BillVoteSuccess> _futureSuccess;

  @override
  Widget build(BuildContext context) {

    return BaseView<BillVoteModel>(
      builder: (context, model, child) => Center(
        child: Container(
          width: appSizes.largeWidth,
          child: Card(
            margin: EdgeInsets.all(30.0),
            color: Theme.of(context).scaffoldBackgroundColor,
            child: (_futureSuccess == null)
                ? Column(children: <Widget>[
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
                                areYouSure("yes", model, widget.data.id,
                                    widget.data.ballotSpecHash);
                              },
                              color: appColors.yes,
                              child: Text("Vote Yes",
                                  style: appTextStyles.yesnobutton)),
                          RaisedButton(
                              onPressed: () {
                                areYouSure("no", model, widget.data.id,
                                    widget.data.ballotSpecHash);
                              },
                              color: appColors.no,
                              child: Text("Vote No",
                                  style: appTextStyles.yesnobutton)),
                        ],
                      ),
                    ),
                  ])
                : FutureBuilder<BillVoteSuccess>(
                    future: _futureSuccess,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Container(
                            padding: EdgeInsets.all(appSizes.standardPadding),
                            child: Text(
                              "Successful vote: " +
                                  snapshot.data.ballotspecHash,
                              style: Theme.of(context).textTheme.headline6,
                            ));
                      } else if (snapshot.hasError) {
                        return Container(
                            padding: EdgeInsets.all(appSizes.standardPadding),
                            child: Text(
                              "${snapshot.error}",
                              style: Theme.of(context).textTheme.headline6,
                            ));
                      }
                      return Container(
                        padding: EdgeInsets.all(appSizes.standardPadding),
                        child: Center(child: CircularProgressIndicator()),
                      );
                    },
                  ),
          ),
        ),
      ),
    );
  }

  areYouSure(String vote, model, String id, String ballotSpecHash) {
    /// Dialog to confirm the vote
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).backgroundColor,
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
                setState(() {
                  _futureSuccess = model.postVote(
                    BillVote(
                        //TO DO: update to real data
                        pubKey: model.getEthereumAddress().toString(),
                        ballotId: id,
                        ballotSpecHash: ballotSpecHash,
                        constituency: "Australia",
                        vote: vote),
                  );
                });
              },
            ),
          ],
        );
      },
    );
  }
}
