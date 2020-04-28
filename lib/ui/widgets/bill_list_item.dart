import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:voting_app/core/models/bill.dart';
import 'package:voting_app/ui/views/bills/bill.dart';
import 'dart:math';
import 'package:voting_app/ui/styles.dart';
import 'package:voting_app/ui/widgets/house_icon_widget.dart';
import 'package:voting_app/ui/widgets/pie_chart.dart';
import 'package:voting_app/ui/widgets/voting_status_widget.dart';

class BillListItem extends StatelessWidget {
  final Bill bill;
  final Map issuesMap;
  final Map billColors = {"House": appColors.house, "Senate": appColors.senate};
  final Map billIntro = {"House": "Intro House", "Senate": "Intro Senate"};
  // Delete Random when vote status is obtained
  final Random random = new Random();

  BillListItem({this.bill, this.issuesMap});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: EdgeInsets.all(appSizes.standardMargin),
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => BillPage(bill: bill)),
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
                          bill: bill,
                          // Delete Random when vote status is obtained
                          voted: random.nextInt(5) == 0,
                          size: 20),
                      Text(bill.chamber,
                          // TextStyle specific to this widget
                          style: Theme.of(context).textTheme.bodyText1),
                    ],
                  ),
                ),
                Divider(),
                Container(
                  child: Text(bill.shortTitle,
                      style: Theme.of(context).textTheme.headline6),
                ),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    HouseIconsWidget(
                      bill: bill,
                      size: 20,
                    ),
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
