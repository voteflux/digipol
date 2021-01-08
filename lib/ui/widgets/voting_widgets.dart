import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:voting_app/core/consts.dart';
import 'package:voting_app/core/models/bill_chain_data.dart';
import 'package:voting_app/core/models/bill_vote.dart';
import 'package:voting_app/core/models/bill_vote_success.dart';
import 'package:voting_app/core/viewmodels/bill_vote_model.dart';
import 'package:voting_app/ui/styles.dart';
import 'package:voting_app/ui/views/base_view.dart';
import 'package:web3dart/web3dart.dart';

// The plan here is to have a card that has 3 states
// 1 voting options - the default
// 2 Vote processing
// 3 Voted - showing vote info (time, hash, vote...)
// separate into widgets

class VoteWidget extends StatefulWidget {
  final BillChainData data;
  final String /*?*/ vote;
  final int yes;
  final int no;

  VoteWidget({Key /*?*/ key, @required this.data, this.vote, this.no, this.yes})
      : super(key: key);

  @override
  _VoteWidgetState createState() => _VoteWidgetState();
}

class _VoteWidgetState extends State<VoteWidget> {
  Future<BillVoteSuccess> /*?*/ _futureSuccess;
  Box userBox = Hive.box<String>(HIVE_USER_PREFS_STR);

  @override
  Widget build(BuildContext context) {
    return BaseView<BillVoteModel>(
      onModelReady: (model) {},
      builder: (context, model, child) => Center(
        child: Container(
          child: Card(
            color: Theme.of(context).scaffoldBackgroundColor,
            child: (_futureSuccess == null)
                ? Column(children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        widget.vote != null
                            ? "You've voted ".toUpperCase() +
                                widget.vote.toUpperCase()
                            : 'vote'.toUpperCase(),
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontSize: 20,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        widget.data.shortTitle,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Votes so far',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 16.0, right: 16.0),
                      child: Row(
                        children: [
                          Expanded(
                            flex: widget.yes,
                            child: Container(
                              alignment: Alignment.centerLeft,
                              height: 40,
                              padding: EdgeInsets.only(left: 10),
                              child: Text(
                                  ((widget.yes / (widget.yes + widget.no)) *
                                              100)
                                          .toString() +
                                      '%',
                                  style: TextStyle(
                                    color: Theme.of(context)
                                        .scaffoldBackgroundColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0,
                                  )),
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                          Expanded(
                            flex: widget.no,
                            child: Container(
                              alignment: Alignment.centerRight,
                              height: 40,
                              padding: EdgeInsets.only(right: 10),
                              child: Text(
                                  ((widget.no / (widget.yes + widget.no)) * 100)
                                          .toString() +
                                      '%',
                                  style: TextStyle(
                                    color: Theme.of(context)
                                        .scaffoldBackgroundColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0,
                                  )),
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 16.0, right: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text('YES',
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                                fontWeight: FontWeight.bold,
                                fontSize: 14.0,
                              )),
                          Text('NO',
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.secondary,
                                fontWeight: FontWeight.bold,
                                fontSize: 14.0,
                              ))
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          RaisedButton(
                              padding: EdgeInsets.only(
                                  bottom: 8.0,
                                  top: 8.0,
                                  left: 10.0,
                                  right: 10.0),
                              onPressed: () {
                                areYouSure("yes", model, widget.data.id,
                                    widget.data.ballotSpecHash);
                              },
                              color: Theme.of(context).colorScheme.primary,
                              child: Text("Vote YES")),
                          RaisedButton(
                              padding: EdgeInsets.only(
                                  bottom: 8.0,
                                  top: 8.0,
                                  left: 10.0,
                                  right: 10.0),
                              onPressed: () {
                                areYouSure("no", model, widget.data.id,
                                    widget.data.ballotSpecHash);
                              },
                              color: Theme.of(context).colorScheme.secondary,
                              child: Text("Vote NO")),
                        ],
                      ),
                    ),
                  ])
                : FutureBuilder<BillVoteSuccess>(
                    future: _futureSuccess,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        print(snapshot.hasData);
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

  Future<void> areYouSure(
      String vote, BillVoteModel model, String id, String ballotSpecHash) {
    /// Dialog to confirm the vote
    String ethAddress = userBox.get('ethereumAddress') as String;

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
                  print(ethAddress);
                  _futureSuccess = model.postVote(
                    BillVote(

                        // TODO: update to real data
                        ethAddrHex: ethAddress,
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
