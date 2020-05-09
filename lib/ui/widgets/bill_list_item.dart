import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:voting_app/core/models/bill.dart';
import 'package:voting_app/core/models/block_chain_data.dart';
import 'package:voting_app/core/services/api.dart';
import 'package:voting_app/core/viewmodels/bill_model.dart';
import 'package:voting_app/locator.dart';
import 'package:voting_app/ui/views/bills/bill.dart';
import 'dart:math';
import 'package:voting_app/ui/styles.dart';
import 'package:voting_app/ui/widgets/house_icon_widget.dart';
import 'package:voting_app/ui/widgets/pie_chart.dart';
import 'package:voting_app/ui/widgets/voting_status_widget.dart';

class BillListItem extends StatefulWidget {
  @override
  _BillListItemState createState() => _BillListItemState();
  
  final BlockChainData bill;
  final Map issuesMap;
  final Map billColors = {"House": appColors.house, "Senate": appColors.senate};
  final Map billIntro = {"House": "Intro House", "Senate": "Intro Senate"};
  // Delete Random when vote status is obtained
  final Random random = new Random();

  BillListItem({this.bill, this.issuesMap});
}

class _BillListItemState extends State<BillListItem> {
  BillModel billModel = locator<BillModel>();
  String _vote;

  Future getVote() async {
    var vote = await billModel.hasVoted(widget.bill.id);
    setState(() {
      _vote = vote;
    });
  }

  @protected
  @mustCallSuper
  void initState() {
    getVote();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: EdgeInsets.all(appSizes.standardMargin),
        child: InkWell(
          onTap: () {
            Navigator.push(
             context,
              MaterialPageRoute(
                  builder: (context) => BillPage(billId: widget.bill.id)),
            );
          },
          child: Container(
            padding: EdgeInsets.all(appSizes.standardPadding),
            width: appSizes.mediumWidth,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      //VotingStatusWidget(
                      //    bill: widget.bill,
                      //    // Delete Random when vote status is obtained
                      //    voted: _vote != null ? true : false,
                      //    size: 20),
                      Text(widget.bill.chamber,
                          // TextStyle specific to this widget
                          style: Theme.of(context).textTheme.bodyText1),
                    ],
                  ),
                ),
                Divider(),
                Container(
                  child: Text(widget.bill.shortTitle,
                      style: Theme.of(context).textTheme.headline6),
                ),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                  //  HouseIconsWidget(
                  //    bill: widget.bill,
                  //    size: 20,
                  //  ),
                    //PieWidget(
                    // Delete Random when vote status is obtained
                    //  yes: 10,
                    //  showValues: false,
                    //  no: 10,
                    //  radius: 50,
                    //)
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
