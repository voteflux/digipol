import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:voting_app/core/models/bill.dart';
import 'package:voting_app/core/models/block_chain_data.dart';
import 'package:voting_app/core/services/api.dart';
import 'package:voting_app/core/viewmodels/bill_model.dart';
import 'package:voting_app/locator.dart';
import 'package:voting_app/ui/views/bills/bill_view.dart';
import 'dart:math';
import 'package:voting_app/ui/styles.dart';
import 'package:voting_app/ui/widgets/house_icon_widget.dart';
import 'package:voting_app/ui/widgets/pie_chart.dart';
import 'package:voting_app/ui/widgets/voting_status_widget.dart';

class BillListItem extends StatefulWidget {
  @override
  _BillListItemState createState() => _BillListItemState();

  final BlockChainData blockChainData;
  final Map issuesMap;
  final Map billColors = {"House": appColors.house, "Senate": appColors.senate};
  final Map billIntro = {"House": "Intro House", "Senate": "Intro Senate"};

  BillListItem({Key key, this.blockChainData, this.issuesMap})
      : super(key: key);
}

class _BillListItemState extends State<BillListItem> {
  BillModel billModel = locator<BillModel>();
  String _vote;
  Bill completeBillData;
  Box<Bill> billsBox = Hive.box<Bill>("bills");

  Future getVote() async {
    // Get all bill data from Box
    List<Bill> list = billsBox.values
        .where((bill) => bill.id == widget.blockChainData.id)
        .toList();
    completeBillData = list[0];

    var vote = await billModel.hasVoted(widget.blockChainData.id);
    setState(() {
      _vote = vote;
    });
  }

  @protected
  @mustCallSuper
  void initState() {
    super.initState();
    getVote();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: EdgeInsets.all(appSizes.standardMargin),
        child: InkWell(
          onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BillPage(
                  blockChainData: widget.blockChainData,
                ),
              ),
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
                      VotingStatusWidget(
                          bill: completeBillData,
                          voted: _vote != null ? true : false,
                          size: 20),
                      Text(widget.blockChainData.chamber,
                          style: Theme.of(context).textTheme.bodyText2),
                      Text(widget.blockChainData.startDate,
                          style: Theme.of(context).textTheme.bodyText2),
                    ],
                  ),
                ),
                Divider(),
                Container(
                  child: Text(widget.blockChainData.shortTitle,
                      style: Theme.of(context).textTheme.headline6),
                ),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    HouseIconsWidget(
                      bill: completeBillData,
                      size: 20,
                    ),
                    SizedBox(
                      width: 50.0,
                      height: 50.0,
                      child: PieWidget(
                        yes: completeBillData.yes,
                        showValues: false,
                        sectionSpace: 0,
                        no: completeBillData.no,
                        radius: 35,
                      ),
                    )
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
