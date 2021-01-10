import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:voting_app/core/consts.dart';
import 'package:voting_app/core/models/bill_chain_data.dart';
import 'package:voting_app/core/models/bill_vote.dart';
import 'package:voting_app/core/models/bill_vote_success.dart';
import 'package:voting_app/core/viewmodels/bill_vote_model.dart';
import 'package:voting_app/ui/views/base_view.dart';

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
  final String shortDescription;

  VoteWidget(
      {Key /*?*/ key,
      @required this.data,
      this.vote,
      this.no,
      this.yes,
      this.shortDescription})
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
                            color: widget.vote != null
                                ? (widget.vote == 'yes'
                                    ? Theme.of(context).colorScheme.primary
                                    : Theme.of(context).colorScheme.secondary)
                                : Theme.of(context).colorScheme.primary,
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
                    widget.vote != null
                        ? _votingGraph(widget.yes, widget.no)
                        : Divider(
                            height: 0,
                          ),
                    widget.vote != null
                        ? Text('Change your vote')
                        : Divider(
                            height: 0,
                          ),
                    Container(
                      padding: EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.all(10),
                              child: RaisedButton(
                                padding: EdgeInsets.only(
                                    bottom: 8.0,
                                    top: 8.0,
                                    left: 10.0,
                                    right: 10.0),
                                onPressed: () {
                                  areYouSure(
                                      "yes",
                                      model,
                                      widget.data.id,
                                      widget.data.ballotSpecHash,
                                      widget.shortDescription);
                                },
                                color: Theme.of(context).colorScheme.primary,
                                child: Text("Vote YES"),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.all(10),
                              child: RaisedButton(
                                  padding: EdgeInsets.only(
                                      bottom: 8.0,
                                      top: 8.0,
                                      left: 10.0,
                                      right: 10.0),
                                  onPressed: () {
                                    areYouSure(
                                        "no",
                                        model,
                                        widget.data.id,
                                        widget.data.ballotSpecHash,
                                        widget.shortDescription);
                                  },
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  child: Text("Vote NO")),
                            ),
                          )
                        ],
                      ),
                    ),
                  ])
                : FutureBuilder<BillVoteSuccess>(
                    future: _futureSuccess,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return _votingGraph(widget.yes, widget.no);
                      } else if (snapshot.hasError) {
                        return Container(
                            padding: EdgeInsets.all(10),
                            child: Text(
                              "${snapshot.error}",
                              style: Theme.of(context).textTheme.headline6,
                            ));
                      }
                      return Container(
                        padding: EdgeInsets.all(10),
                        child: Center(child: CircularProgressIndicator()),
                      );
                    },
                  ),
          ),
        ),
      ),
    );
  }

  Widget _votingGraph(int yes, int no) {
    return Container(
      child: Column(
        children: [
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
                  flex: yes,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(6),
                          bottomLeft: Radius.circular(6)),
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    alignment: Alignment.centerLeft,
                    height: 40,
                    padding: EdgeInsets.only(left: 10),
                    child: Text(
                        ((yes / (yes + no)) * 100).toStringAsFixed(0) + '%',
                        style: TextStyle(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                        )),
                  ),
                ),
                Expanded(
                  flex: no,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(6),
                          bottomRight: Radius.circular(6)),
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    alignment: Alignment.centerRight,
                    height: 40,
                    padding: EdgeInsets.only(right: 10),
                    child:
                        Text(((no / (yes + no)) * 100).toStringAsFixed(0) + '%',
                            style: TextStyle(
                              color: Theme.of(context).scaffoldBackgroundColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0,
                            )),
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
        ],
      ),
    );
  }

  Future<void> areYouSure(String vote, BillVoteModel model, String id,
      String ballotSpecHash, String shortDescription) {
    /// Dialog to confirm the vote
    String ethAddress = userBox.get('ethereumAddress') as String;

    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          elevation: 100,
          backgroundColor: Theme.of(context).backgroundColor,
          title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text('Vote',
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurface,
                        fontSize: 14.0)),
                Text(vote.toUpperCase(),
                    style: TextStyle(
                        color: vote == 'yes'
                            ? Theme.of(context).colorScheme.primary
                            : Theme.of(context).colorScheme.secondary,
                        fontSize: 20.0)),
                Text('for:',
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurface,
                        fontSize: 14.0)),
              ]),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(shortDescription, textAlign: TextAlign.center),
                Divider(),
                Divider(),
                RaisedButton(
                  child: Text('Confirm'),
                  onPressed: () {
                    Navigator.of(context).pop();
                    setState(() {
                      _futureSuccess = model.postVote(
                        BillVote(
                            id: id,
                            ethAddrHex: ethAddress,
                            ballotId: id,
                            ballotSpecHash: ballotSpecHash,
                            constituency: "Australia",
                            vote: vote),
                      );
                    });
                  },
                ),
                FlatButton.icon(
                  icon: Icon(
                    Icons.arrow_left_sharp,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                  label: Text(
                    'back',
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurface,
                        fontSize: 14.0),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
